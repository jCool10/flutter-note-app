import { BadRequestError } from '~/core/error.response'
import { UserModel } from '~/models/access.model'
import bcrypt from 'bcrypt'
import crypto from 'crypto'

class AccessService {
  login = async (payload: any) => {
    const { email, password } = payload

    return {}
  }

  signup = async (payload: any) => {
    const { email, password } = payload

    const existEmail = await UserModel.findOne({ email }).lean()
    if (existEmail) throw new BadRequestError('Email already registered')

    const hashedPassword = await bcrypt.hash(password, 10)

    const newUser = await UserModel.create({ email, password: hashedPassword })

    if (newUser) {
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
    }

    return {}
  }
}

export default new AccessService()
