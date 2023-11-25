import crypto from 'crypto'
import JWT from 'jsonwebtoken'

const createTokenPair = async (payload: any, publicKey: crypto.KeyObject, privateKey: string) => {
  const accessToken = await JWT.sign(payload, privateKey, {
    algorithm: 'RS256',
    expiresIn: '1 days'
  })

  // refresh token
  // const refreshToken = await JWT.sign(payload, privateKey, {
  //   algorithm: 'RS256',
  //   expiresIn: '2 days'
  // })

  // verify key
  // JWT.verify(accessToken, publicKey, (err, decode) => {
  //   if (err) {
  //     console.error(`error verify:: `, err)
  //   } else {
  //     console.log('decode verify::', decode)
  //   }
  // })

  const verify = JWT.verify(accessToken, publicKey)

  return {
    accessToken
    // refreshToken
  }
}

export { createTokenPair }
