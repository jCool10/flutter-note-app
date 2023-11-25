import { Response } from 'express'
import { ReasonPhrases, StatusCodes } from '../constants/httpStatusCode'

class SuccessResponse {
  message: string
  status: number
  data?: object
  reasonStatusCode?: string

  constructor({
    message = ReasonPhrases.OK,
    statusCode = StatusCodes.OK,
    data = {},
    reasonStatusCode = ReasonPhrases.OK
  }) {
    this.message = message
    this.status = statusCode
    this.data = data
    this.reasonStatusCode = reasonStatusCode
  }

  send(res: Response) {
    return res.status(this.status).json(this)
  }
}

class OK extends SuccessResponse {
  constructor({ message = ReasonPhrases.OK, data = {} }) {
    super({ message, data })
  }
}

class Create extends SuccessResponse {
  constructor({ message = '', data = {} }) {
    super({
      message,
      statusCode: StatusCodes.CREATED,
      reasonStatusCode: ReasonPhrases.CREATED,
      data
    })
  }
}

export { Create, OK, SuccessResponse }
