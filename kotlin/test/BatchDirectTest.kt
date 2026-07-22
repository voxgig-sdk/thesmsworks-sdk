package voxgig.thesmsworkssdk.sdktest

import java.util.function.BiFunction
import java.util.function.Supplier

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertNotNull
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Assumptions
import org.junit.jupiter.api.Test

import voxgig.thesmsworkssdk.core.Helpers
import voxgig.thesmsworkssdk.core.ThesmsworksSDK
import voxgig.thesmsworkssdk.utility.Json

@Suppress("UNCHECKED_CAST", "UNUSED_VARIABLE")
class BatchDirectTest {

  @Test
  fun directLoadBatch() {
    val setup = directSetup(jm("id", "direct01"))
    val mode = if (setup.live) "live" else "unit"
    val reason = RunnerSupport.skipReason("direct", "direct-load-batch", mode)
    Assumptions.assumeTrue(
      reason == null,
      if (reason == null || "" == reason) "skipped via sdk-test-control.json" else reason,
    )
    if (setup.live) {
      for (liveKey in arrayOf("id01")) {
        Assumptions.assumeTrue(setup.idmap[liveKey] != null,
            "live test needs " + liveKey + " via *_ENTID env var (synthetic IDs only)")
      }
    }
    val client = setup.client

    val params = linkedMapOf<String, Any?>()
    val query = linkedMapOf<String, Any?>()
    if (setup.live) {
    } else {
      params["id"] = "direct01"
    }

    val result = client.direct(jm(
        "path", "batch/{id}",
        "method", "GET",
        "params", params,
        "query", query))
    if (setup.live) {
      Assumptions.assumeTrue(result["ok"] == true,
          "load call not ok (likely synthetic IDs against live API): " + result)
      val status = Helpers.toInt(result["status"])
      Assumptions.assumeTrue(status in 200..299, "expected 2xx status, got " + result["status"])
    } else {
      assertEquals(true, result["ok"], "expected ok to be true")
      assertEquals(200, Helpers.toInt(result["status"]), "expected status 200")
      assertNotNull(result["data"], "expected data to be non-null")
    }

    if (!setup.live) {
      val dataMap = Helpers.toMapAny(result["data"])
      if (dataMap != null) {
        assertEquals("direct01", dataMap["id"], "expected data.id to be direct01")
      }

      assertEquals(1, setup.calls.size, "expected 1 call")
      val call = setup.calls[0]
      val initMap = Helpers.toMapAny(call["init"])
      if (initMap != null) {
        assertEquals("GET", initMap["method"], "expected method GET")
      }
      val url = if (call["url"] is String) call["url"] as String else ""
      assertTrue(url.contains("direct01"),
          "expected url to contain direct01, got " + url)
    }
  }

  companion object {
    fun jm(vararg kv: Any?): MutableMap<String, Any?> {
      val out = linkedMapOf<String, Any?>()
      var i = 0
      while (i < kv.size - 1) {
        out[kv[i].toString()] = kv[i + 1]
        i += 2
      }
      return out
    }

    class DirectSetup {
      lateinit var client: ThesmsworksSDK
      var calls: MutableList<MutableMap<String, Any?>> = mutableListOf()
      var live: Boolean = false
      var idmap: MutableMap<String, Any?> = linkedMapOf()
    }

    fun directSetup(mockres: Any?): DirectSetup {
      RunnerSupport.loadEnvLocal()

      val calls = mutableListOf<MutableMap<String, Any?>>()

      val envm = linkedMapOf<String, Any?>()
      envm["THESMSWORKS_TEST_BATCH_ENTID"] = linkedMapOf<String, Any?>()
      envm["THESMSWORKS_TEST_LIVE"] = "FALSE"
      envm["THESMSWORKS_APIKEY"] = "NONE"
      val env = RunnerSupport.envOverride(envm)

      val live = "TRUE" == env["THESMSWORKS_TEST_LIVE"]

      val setup = DirectSetup()
      setup.calls = calls

      if (live) {
        val mergedOpts = linkedMapOf<String, Any?>()
        mergedOpts["apikey"] = env["THESMSWORKS_APIKEY"]
        setup.client = ThesmsworksSDK(mergedOpts)
        setup.live = true

        var idmap: MutableMap<String, Any?> = linkedMapOf()
        val entidRaw = env["THESMSWORKS_TEST_BATCH_ENTID"]
        if (entidRaw is String && entidRaw.startsWith("{")) {
          val parsed = Helpers.toMapAny(Json.parseOrNull(entidRaw))
          if (parsed != null) {
            idmap = parsed
          }
        } else if (entidRaw is MutableMap<*, *>) {
          idmap = entidRaw as MutableMap<String, Any?>
        }
        setup.idmap = idmap
        return setup
      }

      val mockdata: Any? = mockres ?: jm("id", "direct01")
      val mockFetch = BiFunction<String, MutableMap<String, Any?>, MutableMap<String, Any?>> { url, init ->
        calls.add(jm("url", url, "init", init))
        jm(
            "status", 200,
            "statusText", "OK",
            "headers", linkedMapOf<String, Any?>(),
            "json", Supplier<Any?> { mockdata })
      }

      setup.client = ThesmsworksSDK(jm(
          "base", "http://localhost:8080",
          "system", jm("fetch", mockFetch)))
      setup.live = false
      setup.idmap = linkedMapOf()
      return setup
    }
  }
}
