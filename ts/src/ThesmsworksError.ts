
import { Context } from './Context'


class ThesmsworksError extends Error {

  isThesmsworksError = true

  sdk = 'Thesmsworks'

  code: string
  ctx: Context

  constructor(code: string, msg: string, ctx: Context) {
    super(msg)
    this.code = code
    this.ctx = ctx
  }

}

export {
  ThesmsworksError
}

