import { Schema, model } from 'mongoose'

const DOCUMENT_NAME = 'Note'
const COLLECTION_NAME = 'Notes'

export interface INote {
  title: string
  content: string
  contentRich: string
  password: string
  tags: [string]
  trashed: boolean
  pinned: boolean
  reminder: string
}

const noteSchema: Schema<INote> = new Schema(
  {
    title: { type: String, required: true },
    content: { type: String, required: true },
    contentRich: { type: String, required: true },
    password: { type: String, required: true },
    tags: { type: [String], required: true },
    trashed: { type: Boolean, required: true },
    pinned: { type: Boolean, required: true },
    reminder: { type: String, required: true }
  },
  { timestamps: true, collection: COLLECTION_NAME }
)

export const KeyTokenModel = model<INote>(DOCUMENT_NAME, noteSchema)
