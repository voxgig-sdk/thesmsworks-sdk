// Generated basic-flow test for the util entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped UtilTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.thesmsworkssdk.core.{Helpers, ThesmsworksSDK}
import voxgig.thesmsworkssdk.utility.struct.Struct

object UtilEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("util.instance") {
      val testsdk = ThesmsworksSDK.testSDK()
      val ent = testsdk.util(null)
      rep.check("util.instance", ent != null, "expected non-null util entity")
    }

    rep.scope("util.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/util/UtilTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = ThesmsworksSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("util01", "UTIL01")
      idmap.put("util02", "UTIL02")
      idmap.put("util03", "UTIL03")
      idmap.put("error01", "ERROR01")
      idmap.put("error02", "ERROR02")
      idmap.put("error03", "ERROR03")
      val now = System.currentTimeMillis()

      // LOAD
      val utilRef01Ent = client.util(null)
      val utilRef01MatchDt0 = new LinkedHashMap[String, Object]()
      val utilRef01DataDt0Loaded = utilRef01Ent.load(utilRef01MatchDt0, null)
      rep.check("util.load.nonnull", utilRef01DataDt0Loaded != null, "expected load result to be non-null")
    }
  }
}
