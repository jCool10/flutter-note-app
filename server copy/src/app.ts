import compression from 'compression'
import express from 'express'
import helmet from 'helmet'
import morgan from 'morgan'
import cors from 'cors'

import Database from './dbs/mongodb'
import { notFoundError, returnError } from './middleware/errorHandle.middleware'
import router from './routers'

const app: express.Application = express()

Database.connect()

app.use(morgan('dev'))
app.use(helmet())
app.use(compression())
app.use(express.json())
app.use(cors())
app.use(express.urlencoded({ extended: true }))

app.use('/api', router)

app.use(notFoundError)

app.use(returnError)

export default app
