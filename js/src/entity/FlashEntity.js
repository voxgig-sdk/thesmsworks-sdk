
const { inspect } = require('node:util')

const { ThesmsworksEntityBase } = require('../ThesmsworksEntityBase')


// TODO: needs Entity superclass
class FlashEntity extends ThesmsworksEntityBase {

  constructor(client, entopts) {
    super(client, entopts)
    this.name = 'flash'
    this.name_ = 'flash'
    this.Name = 'Flash'
  }


  make() {
    return new FlashEntity(this._client, this.entopts())
  }







}


module.exports = {
  FlashEntity
}
