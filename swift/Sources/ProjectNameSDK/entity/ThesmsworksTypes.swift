// Typed models for the Thesmsworks SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types are mapped
// from the canonical type sentinels. Do not edit by hand.
//
// These are DOCUMENTARY: the SDK runtime is dynamic (ops take/return the
// `Value` enum), so nothing consumes these structs yet — they mirror the
// entity/op shapes for reference and IDE support.

import Foundation

/// Batch is the typed data model for the batch entity.
public struct Batch {
}

/// BatchLoadMatch is the typed request payload for Batch.load.
public struct BatchLoadMatch {
  public var id: String
}

/// BatchMessage is the typed data model for the batch_message entity.
public struct BatchMessage {
  public var ai: Bool?
  public var content: String
  public var deliveryreporturl: String?
  public var destination: [Value]
  public var schedule: String?
  public var sender: String
  public var tag: String?
  public var ttl: Double?
  public var validity: Double?
}

/// BatchMessageCreateData is the typed request payload for BatchMessage.create.
public struct BatchMessageCreateData {
  public var ai: Bool?
  public var content: String
  public var deliveryreporturl: String?
  public var destination: [Value]
  public var schedule: String?
  public var sender: String
  public var tag: String?
  public var ttl: Double?
  public var validity: Double?
}

/// BatchMessageRemoveMatch is the typed request payload for BatchMessage.remove.
public struct BatchMessageRemoveMatch {
  public var batchid: String
}

/// Credit is the typed data model for the credit entity.
public struct Credit {
}

/// CreditLoadMatch is the typed request payload for Credit.load.
public struct CreditLoadMatch {
}

/// Flash is the typed data model for the flash entity.
public struct Flash {
}

/// Message is the typed data model for the message entity.
public struct Message {
  public var ai: Bool?
  public var content: String
  public var credit: Double?
  public var deliveryreporturl: String?
  public var destination: String
  public var from: String?
  public var keyword: String?
  public var limit: Double?
  public var metadata: VMap?
  public var responseemail: [Value]?
  public var schedule: String?
  public var sender: String
  public var skip: Double?
  public var status: String?
  public var tag: String?
  public var to: String?
  public var ttl: Double?
  public var unread: Bool?
  public var validity: Double?
}

/// MessageLoadMatch is the typed request payload for Message.load.
public struct MessageLoadMatch {
  public var id: String
}

/// MessageCreateData is the typed request payload for Message.create.
public struct MessageCreateData {
  public var ai: Bool?
  public var content: String
  public var credit: Double?
  public var deliveryreporturl: String?
  public var destination: String
  public var from: String?
  public var keyword: String?
  public var limit: Double?
  public var metadata: VMap?
  public var responseemail: [Value]?
  public var schedule: String?
  public var sender: String
  public var skip: Double?
  public var status: String?
  public var tag: String?
  public var to: String?
  public var ttl: Double?
  public var unread: Bool?
  public var validity: Double?
}

/// MessageRemoveMatch is the typed request payload for Message.remove.
public struct MessageRemoveMatch {
  public var id: String?
  public var messageid: String?
}

/// OneTimePassword is the typed data model for the one_time_password entity.
public struct OneTimePassword {
  public var destination: String?
  public var length: VMap?
  public var metadata: VMap?
  public var passcode: String?
  public var sender: String?
  public var template: String?
  public var validity: Double?
}

/// OneTimePasswordLoadMatch is the typed request payload for OneTimePassword.load.
public struct OneTimePasswordLoadMatch {
  public var messageid: String
}

/// OneTimePasswordCreateData is the typed request payload for OneTimePassword.create.
public struct OneTimePasswordCreateData {
  public var destination: String?
  public var length: VMap?
  public var metadata: VMap?
  public var passcode: String?
  public var sender: String?
  public var template: String?
  public var validity: Double?
}

/// Schedule is the typed data model for the schedule entity.
public struct Schedule {
}

/// Swagger is the typed data model for the swagger entity.
public struct Swagger {
}

/// Util is the typed data model for the util entity.
public struct Util {
}

/// UtilLoadMatch is the typed request payload for Util.load.
public struct UtilLoadMatch {
  public var errorcode: String
}

