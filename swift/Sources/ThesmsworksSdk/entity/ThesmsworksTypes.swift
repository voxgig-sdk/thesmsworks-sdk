// Typed models for the Thesmsworks SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
// params (op.<name>.points[].g.params[]). Field/param types are mapped
// from the canonical type sentinels. Do not edit by hand.
//
// These are DOCUMENTARY: the SDK runtime is dynamic (ops take/return the
// `Value` enum), so nothing consumes these structs yet — they mirror the
// entity/op shapes for reference and IDE support.

import Foundation

/// Batch is the typed data model for the batch entity.
public struct Batch {
  public var id: String?
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
  public var destinations: [Value]
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
  public var destinations: [Value]
  public var schedule: String?
  public var sender: String
  public var tag: String?
  public var ttl: Double?
  public var validity: Double?
}

/// Credit is the typed data model for the credit entity.
public struct Credit {
}

/// CreditLoadMatch is the typed request payload for Credit.load.
public struct CreditLoadMatch {
}

/// Message is the typed data model for the message entity.
public struct Message {
}

/// MessageCreateData is the typed request payload for Message.create.
public struct MessageCreateData {
}

/// MessageMessage is the typed data model for the message_message entity.
public struct MessageMessage {
  public var credits: Double?
  public var destination: String?
  public var from: String?
  public var id: String?
  public var keyword: String?
  public var limit: Double?
  public var metadata: VMap?
  public var sender: String?
  public var skip: Double?
  public var status: String?
  public var to: String?
  public var unread: Bool?
}

/// MessageMessageLoadMatch is the typed request payload for MessageMessage.load.
public struct MessageMessageLoadMatch {
  public var id: String
}

/// MessageMessageCreateData is the typed request payload for MessageMessage.create.
public struct MessageMessageCreateData {
  public var credits: Double?
  public var destination: String?
  public var from: String?
  public var id: String?
  public var keyword: String?
  public var limit: Double?
  public var metadata: VMap?
  public var sender: String?
  public var skip: Double?
  public var status: String?
  public var to: String?
  public var unread: Bool?
}

/// MessageMessageRemoveMatch is the typed request payload for MessageMessage.remove.
public struct MessageMessageRemoveMatch {
  public var id: String
}

/// MessageSchedule is the typed data model for the message_schedule entity.
public struct MessageSchedule {
  public var id: String?
}

/// MessageScheduleLoadMatch is the typed request payload for MessageSchedule.load.
public struct MessageScheduleLoadMatch {
  public var id: String
}

/// MessageScheduleRemoveMatch is the typed request payload for MessageSchedule.remove.
public struct MessageScheduleRemoveMatch {
  public var id: String
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
  public var id: String?
}

/// ScheduleRemoveMatch is the typed request payload for Schedule.remove.
public struct ScheduleRemoveMatch {
  public var id: String
}

/// Util is the typed data model for the util entity.
public struct Util {
}

/// UtilLoadMatch is the typed request payload for Util.load.
public struct UtilLoadMatch {
  public var errorcode: String
}

