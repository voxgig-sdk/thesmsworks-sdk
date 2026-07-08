
import { inspect } from 'node:util'

import { ThesmsworksEntityBase } from '../ThesmsworksEntityBase'

import type {
  ThesmsworksSDK,
} from '../ThesmsworksSDK'


import type {
  Operation,
  Context,
  Control,
} from '../types'

import type {
  Schedule,
} from '../ThesmsworksTypes'

// TODO: needs Entity superclass
class ScheduleEntity extends ThesmsworksEntityBase<Schedule> {

  constructor(client: ThesmsworksSDK, entopts: any) {
    super(client, entopts)
    this.name = 'schedule'
    this.name_ = 'schedule'
    this.Name = 'Schedule'
  }


  make(this: ScheduleEntity) {
    return new ScheduleEntity(this._client, this.entopts())
  }







}


export {
  ScheduleEntity
}
