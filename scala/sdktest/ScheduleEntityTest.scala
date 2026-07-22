// Generated basic-flow test for the schedule entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped ScheduleTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.thesmsworkssdk.core.{Helpers, ThesmsworksSDK}
import voxgig.thesmsworkssdk.utility.struct.Struct

object ScheduleEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("schedule.instance") {
      val testsdk = ThesmsworksSDK.testSDK()
      val ent = testsdk.schedule(null)
      rep.check("schedule.instance", ent != null, "expected non-null schedule entity")
    }

    rep.scope("schedule.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/schedule/ScheduleTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = ThesmsworksSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("schedule01", "SCHEDULE01")
      idmap.put("schedule02", "SCHEDULE02")
      idmap.put("schedule03", "SCHEDULE03")
      val now = System.currentTimeMillis()
    }
  }
}
