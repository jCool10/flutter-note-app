import { RequestAuthentication, NextFunction } from 'express'
import JWT from 'jsonwebtoken'
import { AuthFailureError, ForbiddenError, NotFoundError } from '~/core/error.response'
import asyncCatch from '~/helpers/cathAsync'
import { IKeyToken } from '~/models/keytoken.model'
import KeyTokenService from '~/services/keyToken.service'

const HEADER = {
  AUTHORIZATION: 'authorization',
  REFRESH_TOKEN: 'refresh-token',
  X_CLIENT_ID: 'x-client-id',
  BEARER: 'Bearer '
}

declare module 'express' {
  export interface RequestAuthentication extends Request {
    user?: JWT.JwtPayload
    keyStore: IKeyToken
  }
}

// interface Request

const authentication = asyncCatch(async (req: RequestAuthentication, res: Response, next: NextFunction) => {
  console.log('authentication-mid')
  const accessToken = extractToken(req.headers[HEADER.AUTHORIZATION] as string)

  const obj = parseJwt(accessToken)
  if (!obj.userId) throw new ForbiddenError('Invalid request')

  const userId = obj.userId
  if (!userId) throw new ForbiddenError('Invalid request')

  const keyStore = await KeyTokenService.findByUserId(userId)
  if (!keyStore) throw new NotFoundError('Resource not found')

  // 3. get auth token
  if (!accessToken) throw new AuthFailureError('Invalid request')

  // eslint-disable-next-line no-useless-catch
  try {
    const decodeUser = verifyJwt(accessToken, keyStore.publicKey)
    if (userId !== decodeUser.userId) throw new AuthFailureError('Invalid userId')

    req.user = decodeUser
    req.keyStore = keyStore
    return next()
  } catch (error) {
    throw error
  }
})

const parseJwt = (token: string) => {
  return JSON.parse(Buffer.from(token.split('.')[1], 'base64').toString())
}

const extractToken = (token: string) => {
  if (!token) return ''
  return token.replace(HEADER.BEARER, '')
}

const verifyJwt = (token: any, keySecret: JWT.Secret) => JWT.verify(token, keySecret) as JWT.JwtPayload

export { authentication }
