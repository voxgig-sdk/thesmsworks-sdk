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
class OneTimePasswordEntityTest {

  @Test
  fun instance() {
    val testsdk = ThesmsworksSDK.testSDK()
    val ent = testsdk.oneTimePassword(null)
    assertNotNull(ent, "expected non-null one_time_password entity")
  }

  @Test
  fun basic() {
    val setup = oneTimePasswordBasicSetup(null)
    // Per-op sdk-test-control.json skip.
    val mode = if (setup.live) "live" else "unit"
    for (op in arrayOf("create", "load")) {
      val reason = RunnerSupport.skipReason("entityOp", "one_time_password.$op", mode)
      Assumptions.assumeTrue(
        reason == null,
        if (reason == null || "" == reason) "skipped via sdk-test-control.json" else reason,
      )
    }
    Assumptions.assumeFalse(
      setup.syntheticOnly,
      "live entity test uses synthetic IDs from fixture — set THESMSWORKS_TEST_ONE_TIME_PASSWORD_ENTID JSON to run live",
    )
    val client = setup.client

    // CREATE
    val oneTimePasswordRef01Ent = client.oneTimePassword(null)
    var oneTimePasswordRef01Data: MutableMap<String, Any?> = (Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.one_time_password"), "one_time_password_ref01")) ?: linkedMapOf())

    val oneTimePasswordRef01DataResult = oneTimePasswordRef01Ent.create(oneTimePasswordRef01Data, null)
    oneTimePasswordRef01Data = Helpers.toMapAny(oneTimePasswordRef01DataResult) ?: linkedMapOf()
    assertNotNull(oneTimePasswordRef01Data, "expected create result to be a map")

    // LOAD
    val oneTimePasswordRef01MatchDt0 = linkedMapOf<String, Any?>()
    val oneTimePasswordRef01DataDt0Loaded = oneTimePasswordRef01Ent.load(oneTimePasswordRef01MatchDt0, null)
    assertNotNull(oneTimePasswordRef01DataDt0Loaded, "expected load result to be non-null")

  }

  companion object {
    fun oneTimePasswordBasicSetup(extra: MutableMap<String, Any?>?): RunnerSupport.EntityTestSetup {
      RunnerSupport.loadEnvLocal()

      val entityData: MutableMap<String, Any?>
      try {
        val entityDataSource = Files.readString(Paths.get(
            "..", ".sdk", "test", "entity", "one_time_password", "OneTimePasswordTestData.json"))
        entityData = Helpers.toMapAny(Json.parse(entityDataSource)) ?: linkedMapOf()
      } catch (e: Exception) {
        throw AssertionError("failed to read one_time_password test data: " + e.message, e)
      }

      val options = linkedMapOf<String, Any?>()
      options["entity"] = entityData["existing"]

      var client = ThesmsworksSDK.testSDK(options, extra)

      // Generate idmap via transform, matching TS pattern.
      val idnames = mutableListOf<Any?>()
      idnames.add("one_time_password01")
      idnames.add("one_time_password02")
      idnames.add("one_time_password03")
      idnames.add("otp01")
      idnames.add("otp02")
      idnames.add("otp03")
      val idmap = Struct.transform(idnames, Json.parse(
          "{\"`\$PACK`\": [\"\", {" +
          "\"`\$KEY`\": \"`\$COPY`\"," +
          "\"`\$VAL`\": [\"`\$FORMAT`\", \"upper\", \"`\$COPY`\"]" +
          "}]}"))

      // Detect ENTID env override before envOverride consumes it.
      val entidEnvRaw = RunnerSupport.getenv("THESMSWORKS_TEST_ONE_TIME_PASSWORD_ENTID")
      val idmapOverridden = entidEnvRaw != null && entidEnvRaw.trim().startsWith("{")

      val envm = linkedMapOf<String, Any?>()
      envm["THESMSWORKS_TEST_ONE_TIME_PASSWORD_ENTID"] = idmap
      envm["THESMSWORKS_TEST_LIVE"] = "FALSE"
      envm["THESMSWORKS_TEST_EXPLAIN"] = "FALSE"
      envm["THESMSWORKS_APIKEY"] = "NONE"
      val env = RunnerSupport.envOverride(envm)

      var idmapResolved = Helpers.toMapAny(env["THESMSWORKS_TEST_ONE_TIME_PASSWORD_ENTID"])
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
