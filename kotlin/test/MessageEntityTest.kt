package voxgig.thesmsworkssdk.sdktest

import java.nio.file.Files
import java.nio.file.Paths

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertFalse
import org.junit.jupiter.api.Assertions.assertNotNull
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Assumptions
import org.junit.jupiter.api.Test

import voxgig.thesmsworkssdk.core.Helpers
import voxgig.thesmsworkssdk.core.SdkEntity
import voxgig.thesmsworkssdk.core.ThesmsworksSDK
import voxgig.thesmsworkssdk.utility.Json
import voxgig.thesmsworkssdk.utility.struct.Struct

@Suppress("UNCHECKED_CAST", "UNUSED_VARIABLE", "UNUSED_VALUE")
class MessageEntityTest {

  @Test
  fun instance() {
    val testsdk = ThesmsworksSDK.testSDK()
    val ent = testsdk.message(null)
    assertNotNull(ent, "expected non-null message entity")
  }

  @Test
  fun basic() {
    val setup = messageBasicSetup(null)
    // Per-op sdk-test-control.json skip.
    val mode = if (setup.live) "live" else "unit"
    for (op in arrayOf("create", "load", "remove")) {
      val reason = RunnerSupport.skipReason("entityOp", "message.$op", mode)
      Assumptions.assumeTrue(
        reason == null,
        if (reason == null || "" == reason) "skipped via sdk-test-control.json" else reason,
      )
    }
    Assumptions.assumeFalse(
      setup.syntheticOnly,
      "live entity test uses synthetic IDs from fixture — set THESMSWORKS_TEST_MESSAGE_ENTID JSON to run live",
    )
    val client = setup.client

    // CREATE
    val messageRef01Ent = client.message(null)
    var messageRef01Data: MutableMap<String, Any?> = (Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.message"), "message_ref01")) ?: linkedMapOf())

    val messageRef01DataResult = messageRef01Ent.create(messageRef01Data, null)
    messageRef01Data = Helpers.toMapAny(messageRef01DataResult) ?: linkedMapOf()
    assertNotNull(messageRef01Data, "expected create result to be a map")

    // LOAD
    val messageRef01MatchDt0 = linkedMapOf<String, Any?>()
    val messageRef01DataDt0Loaded = messageRef01Ent.load(messageRef01MatchDt0, null)
    assertNotNull(messageRef01DataDt0Loaded, "expected load result to be non-null")

    // REMOVE
    val messageRef01MatchRm0 = linkedMapOf<String, Any?>()
    messageRef01MatchRm0["id"] = messageRef01Data["id"]
    messageRef01Ent.remove(messageRef01MatchRm0, null)

  }

  companion object {
    fun messageBasicSetup(extra: MutableMap<String, Any?>?): RunnerSupport.EntityTestSetup {
      RunnerSupport.loadEnvLocal()

      val entityData: MutableMap<String, Any?>
      try {
        val entityDataSource = Files.readString(Paths.get(
            "..", ".sdk", "test", "entity", "message", "MessageTestData.json"))
        entityData = Helpers.toMapAny(Json.parse(entityDataSource)) ?: linkedMapOf()
      } catch (e: Exception) {
        throw AssertionError("failed to read message test data: " + e.message, e)
      }

      val options = linkedMapOf<String, Any?>()
      options["entity"] = entityData["existing"]

      var client = ThesmsworksSDK.testSDK(options, extra)

      // Generate idmap via transform, matching TS pattern.
      val idnames = mutableListOf<Any?>()
      idnames.add("message01")
      idnames.add("message02")
      idnames.add("message03")
      idnames.add("schedule01")
      idnames.add("schedule02")
      idnames.add("schedule03")
      val idmap = Struct.transform(idnames, Json.parse(
          "{\"`\$PACK`\": [\"\", {" +
          "\"`\$KEY`\": \"`\$COPY`\"," +
          "\"`\$VAL`\": [\"`\$FORMAT`\", \"upper\", \"`\$COPY`\"]" +
          "}]}"))

      // Detect ENTID env override before envOverride consumes it.
      val entidEnvRaw = RunnerSupport.getenv("THESMSWORKS_TEST_MESSAGE_ENTID")
      val idmapOverridden = entidEnvRaw != null && entidEnvRaw.trim().startsWith("{")

      val envm = linkedMapOf<String, Any?>()
      envm["THESMSWORKS_TEST_MESSAGE_ENTID"] = idmap
      envm["THESMSWORKS_TEST_LIVE"] = "FALSE"
      envm["THESMSWORKS_TEST_EXPLAIN"] = "FALSE"
      envm["THESMSWORKS_APIKEY"] = "NONE"
      val env = RunnerSupport.envOverride(envm)

      var idmapResolved = Helpers.toMapAny(env["THESMSWORKS_TEST_MESSAGE_ENTID"])
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
