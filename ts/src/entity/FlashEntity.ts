
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
  Flash,
} from '../ThesmsworksTypes'

// TODO: needs Entity superclass
class FlashEntity extends ThesmsworksEntityBase<Flash> {

  constructor(client: ThesmsworksSDK, entopts: any) {
    super(client, entopts)
    this.name = 'flash'
    this.name_ = 'flash'
    this.Name = 'Flash'
  }


  make(this: FlashEntity) {
    return new FlashEntity(this._client, this.entopts())
  }







}


export {
  FlashEntity
}
