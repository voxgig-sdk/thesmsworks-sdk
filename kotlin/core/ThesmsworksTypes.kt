package voxgig.thesmsworkssdk.core

// Typed reference models for the Thesmsworks SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels (source of truth: @voxgig/apidef VALID_CANON). Do
// not edit by hand.
//
// These types are documentation/DX reference shapes ONLY. The SDK ops take and
// return the loose object model (MutableMap<String, Any?> / Any?) at runtime,
// so these types are not wired into the op signatures — use them to describe a
// payload before converting it to a map. Every component is a nullable type, so
// an optional (req:false) key needs no distinct rendering.

@Suppress("unused")
object ThesmsworksTypes {

  class Batch

  data class BatchLoadMatch(val id: String?)

  data class BatchMessage(val ai: Boolean?, val content: String?, val deliveryreporturl: String?, val destination: List<Any?>?, val schedule: String?, val sender: String?, val tag: String?, val ttl: Double?, val validity: Double?)

  data class BatchMessageCreateData(val ai: Boolean?, val content: String?, val deliveryreporturl: String?, val destination: List<Any?>?, val schedule: String?, val sender: String?, val tag: String?, val ttl: Double?, val validity: Double?)

  data class BatchMessageRemoveMatch(val batchid: String?)

  class Credit

  class CreditLoadMatch

  class Flash

  data class Message(val ai: Boolean?, val content: String?, val credit: Double?, val deliveryreporturl: String?, val destination: String?, val from: String?, val keyword: String?, val limit: Double?, val metadata: Map<String, Any?>?, val responseemail: List<Any?>?, val schedule: String?, val sender: String?, val skip: Double?, val status: String?, val tag: String?, val to: String?, val ttl: Double?, val unread: Boolean?, val validity: Double?)

  data class MessageLoadMatch(val id: String?)

  data class MessageCreateData(val ai: Boolean?, val content: String?, val credit: Double?, val deliveryreporturl: String?, val destination: String?, val from: String?, val keyword: String?, val limit: Double?, val metadata: Map<String, Any?>?, val responseemail: List<Any?>?, val schedule: String?, val sender: String?, val skip: Double?, val status: String?, val tag: String?, val to: String?, val ttl: Double?, val unread: Boolean?, val validity: Double?)

  data class MessageRemoveMatch(val id: String?, val messageid: String?)

  data class OneTimePassword(val destination: String?, val length: Map<String, Any?>?, val metadata: Map<String, Any?>?, val passcode: String?, val sender: String?, val template: String?, val validity: Double?)

  data class OneTimePasswordLoadMatch(val messageid: String?)

  data class OneTimePasswordCreateData(val destination: String?, val length: Map<String, Any?>?, val metadata: Map<String, Any?>?, val passcode: String?, val sender: String?, val template: String?, val validity: Double?)

  class Schedule

  class Swagger

  class Util

  data class UtilLoadMatch(val errorcode: String?)

}
