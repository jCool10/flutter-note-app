import { Schema, model } from 'mongoose'

const DOCUMENT_NAME = 'User'
const COLLECTION_NAME = 'Users'

export interface IUser {
  email: string
  password: string
}

const userSchema: Schema<IUser> = new Schema(
  {
    email: { type: String, required: true },
    password: { type: String, required: true, minlength: 6, maxlength: 160 }
  },
  { timestamps: true, collection: COLLECTION_NAME }
)

export const UserModel = model<IUser>(DOCUMENT_NAME, userSchema)
