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
public class MessageEntityTest {

  @Test
  public void instance() {
    ThesmsworksSDK testsdk = ThesmsworksSDK.testSDK();
    SdkEntity ent = testsdk.message(null);
    assertNotNull(ent, "expected non-null message entity");
  }

  @Test
  public void basic() {
    RunnerSupport.EntityTestSetup setup = messageBasicSetup(null);
    // Per-op sdk-test-control.json skip — basic test exercises a flow
    // with multiple ops; skipping any op skips the whole flow.
    String mode = setup.live ? "live" : "unit";
    for (String op : new String[] { "create", "load", "remove" }) {
      String reason = RunnerSupport.skipReason("entityOp", "message." + op, mode);
      Assumptions.assumeTrue(reason == null,
          reason == null || "".equals(reason)
              ? "skipped via sdk-test-control.json" : reason);
    }
    // The basic flow consumes synthetic IDs from the fixture. In live mode
    // without an *_ENTID env override, those IDs hit the live API and 4xx.
    Assumptions.assumeFalse(setup.syntheticOnly,
        "live entity test uses synthetic IDs from fixture — set THESMSWORKS_TEST_MESSAGE_ENTID JSON to run live");
    ThesmsworksSDK client = setup.client;

    // CREATE
    SdkEntity messageRef01Ent = client.message(null);
    Map<String, Object> messageRef01Data = Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.message"), "message_ref01"));

    Object messageRef01DataResult = messageRef01Ent.create(messageRef01Data, null);
    messageRef01Data = Helpers.toMapAny(messageRef01DataResult);
    assertNotNull(messageRef01Data, "expected create result to be a map");

    // LOAD
    Map<String, Object> messageRef01MatchDt0 = new LinkedHashMap<>();
    Object messageRef01DataDt0Loaded = messageRef01Ent.load(messageRef01MatchDt0, null);
    assertNotNull(messageRef01DataDt0Loaded, "expected load result to be non-null");

    // REMOVE
    Map<String, Object> messageRef01MatchRm0 = new LinkedHashMap<>();
    messageRef01MatchRm0.put("id", messageRef01Data.get("id"));
    messageRef01Ent.remove(messageRef01MatchRm0, null);

  }

  static RunnerSupport.EntityTestSetup messageBasicSetup(Map<String, Object> extra) {
    RunnerSupport.loadEnvLocal();

    Map<String, Object> entityData;
    try {
      String entityDataSource = Files.readString(Path.of(
          "..", ".sdk", "test", "entity", "message", "MessageTestData.json"));
      entityData = Helpers.toMapAny(Json.parse(entityDataSource));
    }
    catch (Exception e) {
      throw new AssertionError("failed to read message test data: " + e.getMessage(), e);
    }

    Map<String, Object> options = new LinkedHashMap<>();
    options.put("entity", entityData.get("existing"));

    ThesmsworksSDK client = ThesmsworksSDK.testSDK(options, extra);

    // Generate idmap via transform, matching TS pattern.
    List<Object> idnames = new ArrayList<>();
    idnames.add("message01");
    idnames.add("message02");
    idnames.add("message03");
    idnames.add("schedule01");
    idnames.add("schedule02");
    idnames.add("schedule03");
    Object idmap = Struct.transform(idnames, Json.parse(
        "{\"`$PACK`\": [\"\", {"
        + "\"`$KEY`\": \"`$COPY`\","
        + "\"`$VAL`\": [\"`$FORMAT`\", \"upper\", \"`$COPY`\"]"
        + "}]}"));

    // Detect ENTID env override before envOverride consumes it. When live
    // mode is on without a real override, the basic test runs against
    // synthetic IDs from the fixture and 4xx's. Surface this so the test
    // can skip.
    String entidEnvRaw = RunnerSupport.getenv("THESMSWORKS_TEST_MESSAGE_ENTID");
    boolean idmapOverridden = entidEnvRaw != null
        && entidEnvRaw.trim().startsWith("{");

    Map<String, Object> envm = new LinkedHashMap<>();
    envm.put("THESMSWORKS_TEST_MESSAGE_ENTID", idmap);
    envm.put("THESMSWORKS_TEST_LIVE", "FALSE");
    envm.put("THESMSWORKS_TEST_EXPLAIN", "FALSE");
    envm.put("THESMSWORKS_APIKEY", "NONE");
    Map<String, Object> env = RunnerSupport.envOverride(envm);

    Map<String, Object> idmapResolved = Helpers.toMapAny(env.get("THESMSWORKS_TEST_MESSAGE_ENTID"));
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
