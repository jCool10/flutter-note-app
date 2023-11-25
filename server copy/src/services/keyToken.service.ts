import { Types } from 'mongoose'
import { ICreateKeyToken } from '~/@types/keyToken.type'
import { KeyTokenModel } from '~/models/keytoken.model'

class KeyTokenService {
  static createKeyToken = async ({ userId, publicKey, privateKey }: ICreateKeyToken) => {
    const filter = { user: userId },
      update = { publicKey, privateKey },
      options = { upsert: true, new: true }
    const tokens = await KeyTokenModel.findOneAndUpdate(filter, update, options)

    console.log(tokens)

    if (!tokens) throw new Error('Tokens error')

    return tokens.publicKey
  }

  static findByUserId = async (userId: Types.ObjectId) =>
    await KeyTokenModel.findOne({ user: new Types.ObjectId(userId) })

  static removeKeyById = async (id: string) => {
    return await KeyTokenModel.findOneAndDelete({ _id: id })
  }

  static deleteKeyById = async (userId: string) => {
    return await KeyTokenModel.findByIdAndDelete({ userId: userId })
  }
}

export default KeyTokenService
