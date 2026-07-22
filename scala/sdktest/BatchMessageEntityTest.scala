// Generated basic-flow test for the batch_message entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped BatchMessageTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.thesmsworkssdk.core.{Helpers, ThesmsworksSDK}
import voxgig.thesmsworkssdk.utility.struct.Struct

object BatchMessageEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("batch_message.instance") {
      val testsdk = ThesmsworksSDK.testSDK()
      val ent = testsdk.batchMessage(null)
      rep.check("batch_message.instance", ent != null, "expected non-null batch_message entity")
    }

    rep.scope("batch_message.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/batch_message/BatchMessageTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = ThesmsworksSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("batch_message01", "BATCH_MESSAGE01")
      idmap.put("batch_message02", "BATCH_MESSAGE02")
      idmap.put("batch_message03", "BATCH_MESSAGE03")
      idmap.put("schedule01", "SCHEDULE01")
      idmap.put("schedule02", "SCHEDULE02")
      idmap.put("schedule03", "SCHEDULE03")
      val now = System.currentTimeMillis()

      // CREATE
      val batchMessageRef01Ent = client.batchMessage(null)
      var batchMessageRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.batch_message"), "batch_message_ref01"))
      val batchMessageRef01DataResult = batchMessageRef01Ent.create(batchMessageRef01Data, null)
      batchMessageRef01Data = Helpers.toMapAny(batchMessageRef01DataResult)
      rep.check("batch_message.create.map", batchMessageRef01Data != null, "expected create result to be a map")

      // REMOVE
      val batchMessageRef01MatchRm0 = new LinkedHashMap[String, Object]()
      batchMessageRef01MatchRm0.put("id", batchMessageRef01Data.get("id"))
      batchMessageRef01Ent.remove(batchMessageRef01MatchRm0, null)
    }
  }
}
