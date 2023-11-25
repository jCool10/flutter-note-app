import { KeyTokenModel } from '../keytoken.model'

const findKeyTokenAndUpdate = async (filter: any, update: any, options: any) =>
  await KeyTokenModel.findOneAndUpdate(filter, update, options)

export { findKeyTokenAndUpdate }
