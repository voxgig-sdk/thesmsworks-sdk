package voxgig.thesmsworkssdk.sdktest

import java.nio.file.Files
import java.nio.file.Paths

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertFalse
import org.junit.jupiter.api.Assertions.assertNotNull
import org.junit.jupiter.api.Assertions.assertThrows
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Assumptions
import org.junit.jupiter.api.Test

import voxgig.thesmsworkssdk.core.Config
import voxgig.thesmsworkssdk.core.Context
import voxgig.thesmsworkssdk.core.Helpers
import voxgig.thesmsworkssdk.core.SdkEntity
import voxgig.thesmsworkssdk.core.SdkError
import voxgig.thesmsworkssdk.core.ThesmsworksSDK
import voxgig.thesmsworkssdk.feature.BaseFeature
import voxgig.thesmsworkssdk.utility.Json
import voxgig.thesmsworkssdk.utility.struct.Struct

@Suppress("UNCHECKED_CAST", "UNUSED_VARIABLE", "UNUSED_VALUE")
class MessageMessageEntityTest {

  // main.kit.test.live.strict is true (the default is true): a live
  // request that fails, or a live test missing an input it needs,
  // fails the test.
  // An account with no record for a test to read skips it either way.
  private val LIVE_STRICT = true

  @Test
  fun instance() {
    val testsdk = ThesmsworksSDK.testSDK()
    val ent = testsdk.messageMessage(null)
    assertNotNull(ent, "expected non-null message_message entity")
  }

  @Test
  fun basic() {
    val setup = messageMessageBasicSetup(null)
    // Per-op sdk-test-control.json skip.
    val mode = if (setup.live) "live" else "unit"
    for (op in arrayOf<String>("create", "load", "remove")) {
      val reason = RunnerSupport.skipReason("entityOp", "message_message.$op", mode)
      Assumptions.assumeTrue(
        reason == null,
        if (reason == null || "" == reason) "skipped via sdk-test-control.json" else reason,
      )
    }
    val client = setup.client

    // CREATE
    val messageMessageRef01Ent = client.messageMessage(null)
    var messageMessageRef01Data: MutableMap<String, Any?> = (Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.message_message"), "message_message_ref01")) ?: linkedMapOf())

    val messageMessageRef01DataResult = messageMessageRef01Ent.create(messageMessageRef01Data, null)
    messageMessageRef01Data = Helpers.toMapAny(if (messageMessageRef01DataResult is SdkEntity) messageMessageRef01DataResult.data() else messageMessageRef01DataResult) ?: linkedMapOf()
    assertNotNull(messageMessageRef01Data, "expected create result to be a map")
    assertNotNull(messageMessageRef01Data["id"], "expected created entity to have an id")

    // LOAD
    val messageMessageRef01MatchDt0 = linkedMapOf<String, Any?>()
    messageMessageRef01MatchDt0["id"] = messageMessageRef01Data["id"]
    val messageMessageRef01DataDt0Loaded = messageMessageRef01Ent.load(messageMessageRef01MatchDt0, null)
    val messageMessageRef01DataDt0LoadResult = Helpers.toMapAny(if (messageMessageRef01DataDt0Loaded is SdkEntity) messageMessageRef01DataDt0Loaded.data() else messageMessageRef01DataDt0Loaded) ?: linkedMapOf()
    assertNotNull(messageMessageRef01DataDt0LoadResult, "expected load result to be a map")
    assertEquals(messageMessageRef01Data["id"], messageMessageRef01DataDt0LoadResult["id"],
        "expected load result id to match")

    // REMOVE
    val messageMessageRef01MatchRm0 = linkedMapOf<String, Any?>()
    messageMessageRef01MatchRm0["id"] = messageMessageRef01Data["id"]
    messageMessageRef01Ent.remove(messageMessageRef01MatchRm0, null)

  }

  private fun hasFeature(name: String): Boolean {
    val fm = Helpers.toMapAny(Config.sharedConfig()["feature"])
    return fm != null && fm[name] != null
  }

  @Test
  fun validate() {
    Assumptions.assumeTrue(hasFeature("validate"), "feature not present in this SDK: validate")
    val client = ThesmsworksSDK.testSDK(null, linkedMapOf<String, Any?>(
      "feature" to linkedMapOf<String, Any?>(
        "validate" to linkedMapOf<String, Any?>("active" to true))))
    val err = assertThrows(SdkError::class.java) {
      client.messageMessage(null).load(linkedMapOf<String, Any?>("id" to 1), null)
    }
    assertEquals("validate_failed", err.code)
  }

  companion object {
    fun messageMessageBasicSetup(extra: MutableMap<String, Any?>?): RunnerSupport.EntityTestSetup {
      RunnerSupport.loadEnvLocal()

      val entityData: MutableMap<String, Any?>
      try {
        val entityDataSource = Files.readString(Paths.get(
            "..", ".sdk", "test", "entity", "message_message", "MessageMessageTestData.json"))
        entityData = Helpers.toMapAny(Json.parse(entityDataSource)) ?: linkedMapOf()
      } catch (e: Exception) {
        throw AssertionError("failed to read message_message test data: " + e.message, e)
      }

      val options = linkedMapOf<String, Any?>()
      options["entity"] = entityData["existing"]

      var client = ThesmsworksSDK.testSDK(options, extra)

      // Generate idmap via transform, matching TS pattern.
      val idnames = mutableListOf<Any?>()
      idnames.add("message_message01")
      idnames.add("message_message02")
      idnames.add("message_message03")
      val idmap = Struct.transform(idnames, Json.parse(
          "{\"`\$PACK`\": [\"\", {" +
          "\"`\$KEY`\": \"`\$COPY`\"," +
          "\"`\$VAL`\": [\"`\$FORMAT`\", \"upper\", \"`\$COPY`\"]" +
          "}]}"))

      // Whether *_ENTID supplied the idmap, read before envOverride consumes it.
      val entidEnvRaw = RunnerSupport.getenv("THESMSWORKS_TEST_MESSAGE_MESSAGE_ENTID")
      val idmapOverridden = entidEnvRaw != null && entidEnvRaw.trim().startsWith("{")

      val envm = linkedMapOf<String, Any?>()
      envm["THESMSWORKS_TEST_MESSAGE_MESSAGE_ENTID"] = idmap
      envm["THESMSWORKS_TEST_LIVE"] = "FALSE"
      envm["THESMSWORKS_TEST_EXPLAIN"] = "FALSE"
      envm["THESMSWORKS_APIKEY"] = "NONE"
      val env = RunnerSupport.envOverride(envm)

      var idmapResolved = Helpers.toMapAny(env["THESMSWORKS_TEST_MESSAGE_MESSAGE_ENTID"])
      if (idmapResolved == null) {
        idmapResolved = Helpers.toMapAny(idmap) ?: linkedMapOf()
      }

      val live = "TRUE" == env["THESMSWORKS_TEST_LIVE"]
      if (live) {
        val liveOpts = linkedMapOf<String, Any?>()
        liveOpts["apikey"] = env["THESMSWORKS_APIKEY"]
        val mergedOpts = Struct.merge(Struct.jt(liveOpts, extra))
        client = ThesmsworksSDK(Helpers.toMapAny(mergedOpts))
      }

      val setup = RunnerSupport.EntityTestSetup()
      setup.client = client
      setup.data = entityData
      setup.idmap = idmapResolved
      setup.env = env
      setup.explain = "TRUE" == env["THESMSWORKS_TEST_EXPLAIN"]
      setup.live = live
      setup.syntheticOnly = live && !idmapOverridden
      setup.now = System.currentTimeMillis()
      return setup
    }
  }
}
