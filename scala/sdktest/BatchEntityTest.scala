// Generated basic-flow test for the batch entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped BatchTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.thesmsworkssdk.core.{Helpers, SdkEntity, ThesmsworksSDK}
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
      val batchRef01DataRaw = Struct.items(Helpers.toMapAny(
          Struct.getpath(entityData, "existing.batch")))
      val batchRef01Data = Helpers.toMapAny(batchRef01DataRaw.get(0).get(1))

      // LOAD
      val batchRef01Ent = client.batch(null)
      val batchRef01MatchDt0 = new LinkedHashMap[String, Object]()
      batchRef01MatchDt0.put("id", batchRef01Data.get("id"))
      val batchRef01DataDt0Loaded = batchRef01Ent.load(batchRef01MatchDt0, null)
      val batchRef01DataDt0LoadResult = Helpers.toMapAny(batchRef01DataDt0Loaded match { case e: SdkEntity => e.data(); case o => o })
      rep.check("batch.load.map", batchRef01DataDt0LoadResult != null, "expected load result to be a map")
      rep.eq("batch.load.id", batchRef01Data.get("id"), batchRef01DataDt0LoadResult.get("id"))
    }
  }
}
