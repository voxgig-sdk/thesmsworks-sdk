
const { inspect } = require('node:util')

const { ThesmsworksEntityBase } = require('../ThesmsworksEntityBase')


// TODO: needs Entity superclass
class SwaggerEntity extends ThesmsworksEntityBase {

  constructor(client, entopts) {
    super(client, entopts)
    this.name = 'swagger'
    this.name_ = 'swagger'
    this.Name = 'Swagger'
  }


  make() {
    return new SwaggerEntity(this._client, this.entopts())
  }







}


module.exports = {
  SwaggerEntity
}
