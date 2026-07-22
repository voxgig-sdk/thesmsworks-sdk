// Generated basic-flow test for the credit entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped CreditTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.thesmsworkssdk.core.{Helpers, ThesmsworksSDK}
import voxgig.thesmsworkssdk.utility.struct.Struct

object CreditEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("credit.instance") {
      val testsdk = ThesmsworksSDK.testSDK()
      val ent = testsdk.credit(null)
      rep.check("credit.instance", ent != null, "expected non-null credit entity")
    }

    rep.scope("credit.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/credit/CreditTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = ThesmsworksSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("credit01", "CREDIT01")
      idmap.put("credit02", "CREDIT02")
      idmap.put("credit03", "CREDIT03")
      val now = System.currentTimeMillis()

      // LOAD
      val creditRef01Ent = client.credit(null)
      val creditRef01MatchDt0 = new LinkedHashMap[String, Object]()
      val creditRef01DataDt0Loaded = creditRef01Ent.load(creditRef01MatchDt0, null)
      rep.check("credit.load.nonnull", creditRef01DataDt0Loaded != null, "expected load result to be non-null")
    }
  }
}
