import { NextFunction, Request, RequestAuthentication, Response } from 'express'
import { SuccessResponse } from '~/core/success.response'
import asyncCatch from '~/helpers/cathAsync'
import AccessService from '~/services/access.service'

class AccessController {
  static login = asyncCatch(async (req: Request, res: Response, next: NextFunction) => {
    new SuccessResponse({
      message: 'Login Success!',
      data: await AccessService.login(req.body)
    }).send(res)
  })

  static signup = asyncCatch(async (req: Request, res: Response, next: NextFunction) => {
    new SuccessResponse({
      message: 'Signup Success!',
      data: await AccessService.signup(req.body)
    }).send(res)
  })

  static logout = asyncCatch(async (req: RequestAuthentication, res: Response, next: NextFunction) => {
    new SuccessResponse({
      message: 'Logout Success!',
      data: await AccessService.logout({ keyStore: req.keyStore })
    }).send(res)
  })
}

export default AccessController
