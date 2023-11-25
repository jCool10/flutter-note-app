import { UserModel } from '../user.model'

const findUserByEmail = async (email: string) => await UserModel.findOne({ email }).lean()

const createNewUser = async (payload: any) => UserModel.create(payload)

export { findUserByEmail, createNewUser }
