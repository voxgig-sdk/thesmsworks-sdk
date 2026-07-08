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
  destination: any[]
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
  destination: any[]
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
}

export interface Flash {
}

export interface Message {
  ai?: boolean
  content: string
  credit?: number
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
}

export interface MessageCreateData {
  ai?: boolean
  content: string
  credit?: number
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
}

