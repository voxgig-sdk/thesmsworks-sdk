// Generated basic-flow test for the one_time_password entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped OneTimePasswordTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.thesmsworkssdk.core.{Helpers, ThesmsworksSDK}
import voxgig.thesmsworkssdk.utility.struct.Struct

object OneTimePasswordEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("one_time_password.instance") {
      val testsdk = ThesmsworksSDK.testSDK()
      val ent = testsdk.oneTimePassword(null)
      rep.check("one_time_password.instance", ent != null, "expected non-null one_time_password entity")
    }

    rep.scope("one_time_password.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/one_time_password/OneTimePasswordTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = ThesmsworksSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("one_time_password01", "ONE_TIME_PASSWORD01")
      idmap.put("one_time_password02", "ONE_TIME_PASSWORD02")
      idmap.put("one_time_password03", "ONE_TIME_PASSWORD03")
      idmap.put("otp01", "OTP01")
      idmap.put("otp02", "OTP02")
      idmap.put("otp03", "OTP03")
      val now = System.currentTimeMillis()

      // CREATE
      val oneTimePasswordRef01Ent = client.oneTimePassword(null)
      var oneTimePasswordRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.one_time_password"), "one_time_password_ref01"))
      val oneTimePasswordRef01DataResult = oneTimePasswordRef01Ent.create(oneTimePasswordRef01Data, null)
      oneTimePasswordRef01Data = Helpers.toMapAny(oneTimePasswordRef01DataResult)
      rep.check("one_time_password.create.map", oneTimePasswordRef01Data != null, "expected create result to be a map")

      // LOAD
      val oneTimePasswordRef01MatchDt0 = new LinkedHashMap[String, Object]()
      val oneTimePasswordRef01DataDt0Loaded = oneTimePasswordRef01Ent.load(oneTimePasswordRef01MatchDt0, null)
      rep.check("one_time_password.load.nonnull", oneTimePasswordRef01DataDt0Loaded != null, "expected load result to be non-null")
    }
  }
}
