import bcrypt from 'bcrypt'
import crypto from 'crypto'
import { ILogin, ISignup } from '~/@types/user.type'
import { AuthFailureError, BadRequestError } from '~/core/error.response'
import { findUserByEmail } from '~/models/repositories/user.repo'
import { UserModel } from '~/models/user.model'
import { getInfoData } from '~/utils'
import { createTokenPair } from '~/utils/JWT'
import KeyTokenService from './keyToken.service'

class AccessService {
  static login = async ({ email, password }: ILogin) => {
    const foundUser = await findUserByEmail(email)

    if (!foundUser) throw new BadRequestError('Email not registered')

    const matchPassword = await bcrypt.compare(password, foundUser.password)

    if (!matchPassword) throw new AuthFailureError('Authentication error')

    const { publicKey, privateKey } = crypto.generateKeyPairSync('rsa', {
      modulusLength: 4096,
      publicKeyEncoding: {
        type: 'pkcs1',
        format: 'pem'
      },
      privateKeyEncoding: {
        type: 'pkcs1',
        format: 'pem'
      }
    })

    const { _id: userId } = foundUser
    const publicKeyObject = await crypto.createPublicKey(publicKey)
    console.log('publicKeyObject:: ', publicKeyObject)

    const tokens = await createTokenPair({ userId, email }, publicKeyObject, privateKey)

    await KeyTokenService.createKeyToken({
      privateKey,
      publicKey,
      userId
    })

    const userInfo = getInfoData({
      field: ['_id', 'username', 'email'],
      object: foundUser
    })

    return {
      user: userInfo,
      tokens
    }
  }

  static signup = async ({ username, password }: any) => {
    console.log({ username, password })
    const foundEmail = await UserModel.findOne({ username }).lean()

    if (foundEmail) throw new BadRequestError('Username already registered!')

    const hashedPassword = await bcrypt.hash(password, 10)

    const newUser = await UserModel.create({ username, password: hashedPassword })

    if (newUser) {
      // const [privateKey, publicKey] = crypto.getRandomValues(64).toString('hex')
      const { publicKey, privateKey } = crypto.generateKeyPairSync('rsa', {
        modulusLength: 4096,
        publicKeyEncoding: {
          type: 'pkcs1',
          format: 'pem'
        },
        privateKeyEncoding: {
          type: 'pkcs1',
          format: 'pem'
        }
      })

      console.log({ privateKey, publicKey })

      // const keyStore = await KeyTokenService.createKeyToken({ userId: newUser._id, privateKey, publicKey })
      const publicKeyString = await KeyTokenService.createKeyToken({
        userId: newUser._id,
        publicKey: publicKey.toString(),
        privateKey: privateKey.toString()
      })

      if (!publicKeyString) {
        throw new BadRequestError('Error: Public Key error')
      }

      console.log('publicKeyString', publicKeyString)

      const publicKeyObject = await crypto.createPublicKey(publicKeyString)
      console.log('publicKeyObject:: ', publicKeyObject)

      const tokens = await createTokenPair({ userId: newUser._id }, publicKeyObject, privateKey)

      console.log('tokens', tokens)

      const userInfo = getInfoData({ field: ['_id', 'username'], object: newUser })

      return {
        user: userInfo,
        tokens
      }
    }
  }

  static logout = async ({ keyStore }: { keyStore: any }) => {
    const delKey = await KeyTokenService.removeKeyById(keyStore._id)
    return {
      delKey
    }
  }
}

export default AccessService
