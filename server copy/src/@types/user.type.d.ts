import { IKeyToken } from '~/models/keytoken.model'

export interface ILogin {
  email: string
  password: string
}

export interface ISignup {
  email: string
  password: string
  username: string
}

export interface IRefreshToken {
  user: JWT.JwtPayload
  keyStore: IKeyToken
  refreshToken: string
}
