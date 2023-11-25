import { Router } from 'express'
import accessRouter from './access.router'

const router: Router = Router()

router.use('/access', accessRouter)

export default router
