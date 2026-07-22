
const { inspect } = require('node:util')

const { ThesmsworksEntityBase } = require('../ThesmsworksEntityBase')


// TODO: needs Entity superclass
class ScheduleEntity extends ThesmsworksEntityBase {

  constructor(client, entopts) {
    super(client, entopts)
    this.name = 'schedule'
    this.name_ = 'schedule'
    this.Name = 'Schedule'
  }


  make() {
    return new ScheduleEntity(this._client, this.entopts())
  }







}


module.exports = {
  ScheduleEntity
}
