

class ThesmsworksError extends Error {

  isThesmsworksError = true

  sdk = 'Thesmsworks'

  constructor(code, msg, ctx) {
    super(msg)
    this.code = code
    this.ctx = ctx
  }

}

module.exports = {
  ThesmsworksError
}

