
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
  Swagger,
} from '../ThesmsworksTypes'

// TODO: needs Entity superclass
class SwaggerEntity extends ThesmsworksEntityBase<Swagger> {

  constructor(client: ThesmsworksSDK, entopts: any) {
    super(client, entopts)
    this.name = 'swagger'
    this.name_ = 'swagger'
    this.Name = 'Swagger'
  }


  make(this: SwaggerEntity) {
    return new SwaggerEntity(this._client, this.entopts())
  }







}


export {
  SwaggerEntity
}
