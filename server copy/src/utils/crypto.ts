import crypto from 'crypto'

const random = () => crypto.randomBytes(64).toString('hex')

export { random }
