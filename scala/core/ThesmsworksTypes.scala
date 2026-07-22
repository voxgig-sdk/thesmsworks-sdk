package voxgig.thesmsworkssdk.core

// Typed reference models for the Thesmsworks SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels (source of truth: @voxgig/apidef VALID_CANON). Do
// not edit by hand.
//
// These case classes are documentation/DX reference shapes ONLY. The SDK ops
// take and return the loose object model (java.util.Map[String, Object] /
// Object) at runtime, so these types are not wired into the op signatures —
// use them to describe a payload before converting it to a map. Every
// component is a boxed (nullable) type, so an optional (req:false) key needs
// no distinct rendering.

object ThesmsworksTypes {

  final case class Batch()

  final case class BatchLoadMatch(id: String)

  final case class BatchMessage(ai: java.lang.Boolean, content: String, deliveryreporturl: String, destination: java.util.List[Object], schedule: String, sender: String, tag: String, ttl: java.lang.Double, validity: java.lang.Double)

  final case class BatchMessageCreateData(ai: java.lang.Boolean, content: String, deliveryreporturl: String, destination: java.util.List[Object], schedule: String, sender: String, tag: String, ttl: java.lang.Double, validity: java.lang.Double)

  final case class BatchMessageRemoveMatch(batchid: String)

  final case class Credit()

  final case class CreditLoadMatch()

  final case class Flash()

  final case class Message(ai: java.lang.Boolean, content: String, credit: java.lang.Double, deliveryreporturl: String, destination: String, from: String, keyword: String, limit: java.lang.Double, metadata: java.util.Map[String, Object], responseemail: java.util.List[Object], schedule: String, sender: String, skip: java.lang.Double, status: String, tag: String, to: String, ttl: java.lang.Double, unread: java.lang.Boolean, validity: java.lang.Double)

  final case class MessageLoadMatch(id: String)

  final case class MessageCreateData(ai: java.lang.Boolean, content: String, credit: java.lang.Double, deliveryreporturl: String, destination: String, from: String, keyword: String, limit: java.lang.Double, metadata: java.util.Map[String, Object], responseemail: java.util.List[Object], schedule: String, sender: String, skip: java.lang.Double, status: String, tag: String, to: String, ttl: java.lang.Double, unread: java.lang.Boolean, validity: java.lang.Double)

  final case class MessageRemoveMatch(id: String, messageid: String)

  final case class OneTimePassword(destination: String, length: java.util.Map[String, Object], metadata: java.util.Map[String, Object], passcode: String, sender: String, template: String, validity: java.lang.Double)

  final case class OneTimePasswordLoadMatch(messageid: String)

  final case class OneTimePasswordCreateData(destination: String, length: java.util.Map[String, Object], metadata: java.util.Map[String, Object], passcode: String, sender: String, template: String, validity: java.lang.Double)

  final case class Schedule()

  final case class Swagger()

  final case class Util()

  final case class UtilLoadMatch(errorcode: String)

}
