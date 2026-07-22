// Generated basic-flow test for the batch entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped BatchTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.thesmsworkssdk.core.{Helpers, ThesmsworksSDK}
import voxgig.thesmsworkssdk.utility.struct.Struct

object BatchEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("batch.instance") {
      val testsdk = ThesmsworksSDK.testSDK()
      val ent = testsdk.batch(null)
      rep.check("batch.instance", ent != null, "expected non-null batch entity")
    }

    rep.scope("batch.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/batch/BatchTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = ThesmsworksSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("batch01", "BATCH01")
      idmap.put("batch02", "BATCH02")
      idmap.put("batch03", "BATCH03")
      val now = System.currentTimeMillis()

      // LOAD
      val batchRef01Ent = client.batch(null)
      val batchRef01MatchDt0 = new LinkedHashMap[String, Object]()
      val batchRef01DataDt0Loaded = batchRef01Ent.load(batchRef01MatchDt0, null)
      rep.check("batch.load.nonnull", batchRef01DataDt0Loaded != null, "expected load result to be non-null")
    }
  }
}
