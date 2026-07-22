// Generated basic-flow test for the flash entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped FlashTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.thesmsworkssdk.core.{Helpers, ThesmsworksSDK}
import voxgig.thesmsworkssdk.utility.struct.Struct

object FlashEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("flash.instance") {
      val testsdk = ThesmsworksSDK.testSDK()
      val ent = testsdk.flash(null)
      rep.check("flash.instance", ent != null, "expected non-null flash entity")
    }

    rep.scope("flash.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/flash/FlashTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = ThesmsworksSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("flash01", "FLASH01")
      idmap.put("flash02", "FLASH02")
      idmap.put("flash03", "FLASH03")
      val now = System.currentTimeMillis()
    }
  }
}
