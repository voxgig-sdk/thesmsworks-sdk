// Typed models for the Thesmsworks SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.

export interface Batch {
}

export interface BatchLoadMatch {
  id: string
}

export interface BatchMessage {
  ai?: boolean
  content: string
  deliveryreporturl?: string
  destinations: any[]
  schedule?: string
  sender: string
  tag?: string
  ttl?: number
  validity?: number
}

export interface BatchMessageCreateData {
  ai?: boolean
  content: string
  deliveryreporturl?: string
  destinations: any[]
  schedule?: string
  sender: string
  tag?: string
  ttl?: number
  validity?: number
}

export interface BatchMessageRemoveMatch {
  batchid: string
}

export interface Credit {
}

export interface CreditLoadMatch {

  // Selects a custom action instead of the plain load:
  //   'balance'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
}

export interface Flash {
}

export interface Message {
  ai?: boolean
  content: string
  credits?: number
  deliveryreporturl?: string
  destination: string
  from?: string
  keyword?: string
  limit?: number
  metadata?: Record<string, any>
  responseemail?: any[]
  schedule?: string
  sender: string
  skip?: number
  status?: string
  tag?: string
  to?: string
  ttl?: number
  unread?: boolean
  validity?: number
}

export interface MessageLoadMatch {
  id: string

  // Selects a custom action instead of the plain load:
  //   'schedule'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
}

export interface MessageCreateData {
  ai?: boolean
  content: string
  credits?: number
  deliveryreporturl?: string
  destination: string
  from?: string
  keyword?: string
  limit?: number
  metadata?: Record<string, any>
  responseemail?: any[]
  schedule?: string
  sender: string
  skip?: number
  status?: string
  tag?: string
  to?: string
  ttl?: number
  unread?: boolean
  validity?: number

  // Selects a custom action instead of the plain create:
  //   'failed' | 'flash' | 'inbox' | 'schedule' | 'send'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
}

export interface MessageRemoveMatch {
  id?: string
  messageid?: string
}

export interface OneTimePassword {
  destination?: string
  length?: Record<string, any>
  metadata?: Record<string, any>
  passcode?: string
  sender?: string
  template?: string
  validity?: number
}

export interface OneTimePasswordLoadMatch {
  messageid: string
}

export interface OneTimePasswordCreateData {
  destination?: string
  length?: Record<string, any>
  metadata?: Record<string, any>
  passcode?: string
  sender?: string
  template?: string
  validity?: number
}

export interface Schedule {
}

export interface Swagger {
}

export interface Util {
}

export interface UtilLoadMatch {
  errorcode: string

  // Selects a custom action instead of the plain load:
  //   'test'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
}

