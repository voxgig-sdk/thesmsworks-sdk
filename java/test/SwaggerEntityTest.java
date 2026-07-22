package voxgig.thesmsworkssdk.sdktest;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.junit.jupiter.api.Assumptions;
import org.junit.jupiter.api.Test;

import voxgig.thesmsworkssdk.core.Helpers;
import voxgig.thesmsworkssdk.core.SdkEntity;
import voxgig.thesmsworkssdk.core.ThesmsworksSDK;
import voxgig.thesmsworkssdk.utility.Json;
import voxgig.thesmsworkssdk.utility.struct.Struct;

@SuppressWarnings({"unchecked", "unused"})
public class SwaggerEntityTest {

  @Test
  public void instance() {
    ThesmsworksSDK testsdk = ThesmsworksSDK.testSDK();
    SdkEntity ent = testsdk.swagger(null);
    assertNotNull(ent, "expected non-null swagger entity");
  }

  @Test
  public void basic() {
    RunnerSupport.EntityTestSetup setup = swaggerBasicSetup(null);
    // Per-op sdk-test-control.json skip — basic test exercises a flow
    // with multiple ops; skipping any op skips the whole flow.
    String mode = setup.live ? "live" : "unit";
    for (String op : new String[] {  }) {
      String reason = RunnerSupport.skipReason("entityOp", "swagger." + op, mode);
      Assumptions.assumeTrue(reason == null,
          reason == null || "".equals(reason)
              ? "skipped via sdk-test-control.json" : reason);
    }
    // The basic flow consumes synthetic IDs from the fixture. In live mode
    // without an *_ENTID env override, those IDs hit the live API and 4xx.
    Assumptions.assumeFalse(setup.syntheticOnly,
        "live entity test uses synthetic IDs from fixture — set THESMSWORKS_TEST_SWAGGER_ENTID JSON to run live");
    // Bootstrap entity data from existing test data (no create step in flow).
    List<List<Object>> swaggerRef01DataRaw = Struct.items(Helpers.toMapAny(
        Struct.getpath(setup.data, "existing.swagger")));
    Map<String, Object> swaggerRef01Data = swaggerRef01DataRaw.isEmpty()
        ? null : Helpers.toMapAny(swaggerRef01DataRaw.get(0).get(1));

  }

  static RunnerSupport.EntityTestSetup swaggerBasicSetup(Map<String, Object> extra) {
    RunnerSupport.loadEnvLocal();

    Map<String, Object> entityData;
    try {
      String entityDataSource = Files.readString(Path.of(
          "..", ".sdk", "test", "entity", "swagger", "SwaggerTestData.json"));
      entityData = Helpers.toMapAny(Json.parse(entityDataSource));
    }
    catch (Exception e) {
      throw new AssertionError("failed to read swagger test data: " + e.getMessage(), e);
    }

    Map<String, Object> options = new LinkedHashMap<>();
    options.put("entity", entityData.get("existing"));

    ThesmsworksSDK client = ThesmsworksSDK.testSDK(options, extra);

    // Generate idmap via transform, matching TS pattern.
    List<Object> idnames = new ArrayList<>();
    idnames.add("swagger01");
    idnames.add("swagger02");
    idnames.add("swagger03");
    Object idmap = Struct.transform(idnames, Json.parse(
        "{\"`$PACK`\": [\"\", {"
        + "\"`$KEY`\": \"`$COPY`\","
        + "\"`$VAL`\": [\"`$FORMAT`\", \"upper\", \"`$COPY`\"]"
        + "}]}"));

    // Detect ENTID env override before envOverride consumes it. When live
    // mode is on without a real override, the basic test runs against
    // synthetic IDs from the fixture and 4xx's. Surface this so the test
    // can skip.
    String entidEnvRaw = RunnerSupport.getenv("THESMSWORKS_TEST_SWAGGER_ENTID");
    boolean idmapOverridden = entidEnvRaw != null
        && entidEnvRaw.trim().startsWith("{");

    Map<String, Object> envm = new LinkedHashMap<>();
    envm.put("THESMSWORKS_TEST_SWAGGER_ENTID", idmap);
    envm.put("THESMSWORKS_TEST_LIVE", "FALSE");
    envm.put("THESMSWORKS_TEST_EXPLAIN", "FALSE");
    envm.put("THESMSWORKS_APIKEY", "NONE");
    Map<String, Object> env = RunnerSupport.envOverride(envm);

    Map<String, Object> idmapResolved = Helpers.toMapAny(env.get("THESMSWORKS_TEST_SWAGGER_ENTID"));
    if (idmapResolved == null) {
      idmapResolved = Helpers.toMapAny(idmap);
    }

    boolean live = "TRUE".equals(env.get("THESMSWORKS_TEST_LIVE"));
    if (live) {
      Map<String, Object> liveOpts = new LinkedHashMap<>();
      liveOpts.put("apikey", env.get("THESMSWORKS_APIKEY"));
      Object mergedOpts = Struct.merge(Struct.jt(liveOpts, extra));
      client = new ThesmsworksSDK(Helpers.toMapAny(mergedOpts));
    }

    RunnerSupport.EntityTestSetup setup = new RunnerSupport.EntityTestSetup();
    setup.client = client;
    setup.data = entityData;
    setup.idmap = idmapResolved;
    setup.env = env;
    setup.explain = "TRUE".equals(env.get("THESMSWORKS_TEST_EXPLAIN"));
    setup.live = live;
    setup.syntheticOnly = live && !idmapOverridden;
    setup.now = System.currentTimeMillis();
    return setup;
  }
}
