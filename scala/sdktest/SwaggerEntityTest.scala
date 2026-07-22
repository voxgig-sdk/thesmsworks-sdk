// Generated basic-flow test for the swagger entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped SwaggerTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.thesmsworkssdk.core.{Helpers, ThesmsworksSDK}
import voxgig.thesmsworkssdk.utility.struct.Struct

object SwaggerEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("swagger.instance") {
      val testsdk = ThesmsworksSDK.testSDK()
      val ent = testsdk.swagger(null)
      rep.check("swagger.instance", ent != null, "expected non-null swagger entity")
    }

    rep.scope("swagger.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/swagger/SwaggerTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = ThesmsworksSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("swagger01", "SWAGGER01")
      idmap.put("swagger02", "SWAGGER02")
      idmap.put("swagger03", "SWAGGER03")
      val now = System.currentTimeMillis()
    }
  }
}
