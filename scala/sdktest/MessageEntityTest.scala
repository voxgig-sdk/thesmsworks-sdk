// Generated basic-flow test for the message entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped MessageTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.thesmsworkssdk.core.{Helpers, ThesmsworksSDK}
import voxgig.thesmsworkssdk.utility.struct.Struct

object MessageEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("message.instance") {
      val testsdk = ThesmsworksSDK.testSDK()
      val ent = testsdk.message(null)
      rep.check("message.instance", ent != null, "expected non-null message entity")
    }

    rep.scope("message.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/message/MessageTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = ThesmsworksSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("message01", "MESSAGE01")
      idmap.put("message02", "MESSAGE02")
      idmap.put("message03", "MESSAGE03")
      idmap.put("schedule01", "SCHEDULE01")
      idmap.put("schedule02", "SCHEDULE02")
      idmap.put("schedule03", "SCHEDULE03")
      val now = System.currentTimeMillis()

      // CREATE
      val messageRef01Ent = client.message(null)
      var messageRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.message"), "message_ref01"))
      val messageRef01DataResult = messageRef01Ent.create(messageRef01Data, null)
      messageRef01Data = Helpers.toMapAny(messageRef01DataResult)
      rep.check("message.create.map", messageRef01Data != null, "expected create result to be a map")

      // LOAD
      val messageRef01MatchDt0 = new LinkedHashMap[String, Object]()
      val messageRef01DataDt0Loaded = messageRef01Ent.load(messageRef01MatchDt0, null)
      rep.check("message.load.nonnull", messageRef01DataDt0Loaded != null, "expected load result to be non-null")

      // REMOVE
      val messageRef01MatchRm0 = new LinkedHashMap[String, Object]()
      messageRef01MatchRm0.put("id", messageRef01Data.get("id"))
      messageRef01Ent.remove(messageRef01MatchRm0, null)
    }
  }
}
