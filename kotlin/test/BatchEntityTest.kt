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
class BatchEntityTest {

  // main.kit.test.live.strict is true (the default is true): a live
  // request that fails, or a live test missing an input it needs,
  // fails the test.
  // An account with no record for a test to read skips it either way.
  private val LIVE_STRICT = true

  @Test
  fun instance() {
    val testsdk = ThesmsworksSDK.testSDK()
    val ent = testsdk.batch(null)
    assertNotNull(ent, "expected non-null batch entity")
  }

  @Test
  fun basic() {
    val setup = batchBasicSetup(null)
    // Per-op sdk-test-control.json skip.
    val mode = if (setup.live) "live" else "unit"
    for (op in arrayOf<String>("load")) {
      val reason = RunnerSupport.skipReason("entityOp", "batch.$op", mode)
      Assumptions.assumeTrue(
        reason == null,
        if (reason == null || "" == reason) "skipped via sdk-test-control.json" else reason,
      )
    }
    if (setup.live) {
      RunnerSupport.liveMiss(LIVE_STRICT, "Live entity test blocked: " + "the flow loads a batch record it has no list to find")
    }
    val client = setup.client

    // Bootstrap entity data from existing test data (no create step in flow).
    val batchRef01DataRaw = Struct.items(Helpers.toMapAny(
        Struct.getpath(setup.data, "existing.batch")))
    val batchRef01Data: MutableMap<String, Any?> = if (batchRef01DataRaw.isEmpty())
        linkedMapOf() else (Helpers.toMapAny(batchRef01DataRaw[0][1]) ?: linkedMapOf())

    // LOAD
    val batchRef01Ent = client.batch(null)
    val batchRef01MatchDt0 = linkedMapOf<String, Any?>()
    batchRef01MatchDt0["id"] = batchRef01Data["id"]
    val batchRef01DataDt0Loaded = batchRef01Ent.load(batchRef01MatchDt0, null)
    val batchRef01DataDt0LoadResult = Helpers.toMapAny(if (batchRef01DataDt0Loaded is SdkEntity) batchRef01DataDt0Loaded.data() else batchRef01DataDt0Loaded) ?: linkedMapOf()
    assertNotNull(batchRef01DataDt0LoadResult, "expected load result to be a map")
    assertEquals(batchRef01Data["id"], batchRef01DataDt0LoadResult["id"],
        "expected load result id to match")

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
      client.batch(null).load(linkedMapOf<String, Any?>("id" to 1), null)
    }
    assertEquals("validate_failed", err.code)
  }

  companion object {
    fun batchBasicSetup(extra: MutableMap<String, Any?>?): RunnerSupport.EntityTestSetup {
      RunnerSupport.loadEnvLocal()

      val entityData: MutableMap<String, Any?>
      try {
        val entityDataSource = Files.readString(Paths.get(
            "..", ".sdk", "test", "entity", "batch", "BatchTestData.json"))
        entityData = Helpers.toMapAny(Json.parse(entityDataSource)) ?: linkedMapOf()
      } catch (e: Exception) {
        throw AssertionError("failed to read batch test data: " + e.message, e)
      }

      val options = linkedMapOf<String, Any?>()
      options["entity"] = entityData["existing"]

      var client = ThesmsworksSDK.testSDK(options, extra)

      // Generate idmap via transform, matching TS pattern.
      val idnames = mutableListOf<Any?>()
      idnames.add("batch01")
      idnames.add("batch02")
      idnames.add("batch03")
      val idmap = Struct.transform(idnames, Json.parse(
          "{\"`\$PACK`\": [\"\", {" +
          "\"`\$KEY`\": \"`\$COPY`\"," +
          "\"`\$VAL`\": [\"`\$FORMAT`\", \"upper\", \"`\$COPY`\"]" +
          "}]}"))

      // Whether *_ENTID supplied the idmap, read before envOverride consumes it.
      val entidEnvRaw = RunnerSupport.getenv("THESMSWORKS_TEST_BATCH_ENTID")
      val idmapOverridden = entidEnvRaw != null && entidEnvRaw.trim().startsWith("{")

      val envm = linkedMapOf<String, Any?>()
      envm["THESMSWORKS_TEST_BATCH_ENTID"] = idmap
      envm["THESMSWORKS_TEST_LIVE"] = "FALSE"
      envm["THESMSWORKS_TEST_EXPLAIN"] = "FALSE"
      envm["THESMSWORKS_APIKEY"] = "NONE"
      val env = RunnerSupport.envOverride(envm)

      var idmapResolved = Helpers.toMapAny(env["THESMSWORKS_TEST_BATCH_ENTID"])
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
