import { Schema, model } from 'mongoose'

const DOCUMENT_NAME = 'Key'
const COLLECTION_NAME = 'Keys'

export interface IKeyToken {
  user: Schema.Types.ObjectId
  publicKey: string
  privateKey: string
  refreshTokensUsed: string[]
  refreshToken: string
}

const keyTokenSchema: Schema<IKeyToken> = new Schema(
  {
    user: {
      type: Schema.Types.ObjectId,
      trim: true,
      ref: 'User'
    },
    publicKey: {
      type: String,
      trim: true
    },
    privateKey: {
      type: String,
      trim: true
    },
    refreshTokensUsed: [String],
    refreshToken: {
      type: String,
      required: true
    }
  },
  { timestamps: true, collection: COLLECTION_NAME }
)

export const KeyTokenModel = model<IKeyToken>(DOCUMENT_NAME, keyTokenSchema)
