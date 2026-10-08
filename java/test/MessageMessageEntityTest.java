package voxgig.thesmsworkssdk.sdktest;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
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

import voxgig.thesmsworkssdk.core.Config;
import voxgig.thesmsworkssdk.core.Context;
import voxgig.thesmsworkssdk.core.Helpers;
import voxgig.thesmsworkssdk.core.SdkEntity;
import voxgig.thesmsworkssdk.core.SdkError;
import voxgig.thesmsworkssdk.core.ThesmsworksSDK;
import voxgig.thesmsworkssdk.feature.BaseFeature;
import voxgig.thesmsworkssdk.utility.Json;
import voxgig.thesmsworkssdk.utility.struct.Struct;

@SuppressWarnings({"unchecked", "unused"})
public class MessageMessageEntityTest {

  // main.kit.test.live.strict is true (the default is true): a live
  // request that fails, or a live test missing an input it needs,
  // fails the test.
  // An account with no record for a test to read skips it either way.
  static final boolean LIVE_STRICT = true;

  @Test
  public void instance() {
    ThesmsworksSDK testsdk = ThesmsworksSDK.testSDK();
    SdkEntity ent = testsdk.messageMessage(null);
    assertNotNull(ent, "expected non-null message_message entity");
  }

  @Test
  public void basic() {
    RunnerSupport.EntityTestSetup setup = messageMessageBasicSetup(null);
    // Per-op sdk-test-control.json skip — basic test exercises a flow
    // with multiple ops; skipping any op skips the whole flow.
    String mode = setup.live ? "live" : "unit";
    for (String op : new String[] { "create", "load", "remove" }) {
      String reason = RunnerSupport.skipReason("entityOp", "message_message." + op, mode);
      Assumptions.assumeTrue(reason == null,
          reason == null || "".equals(reason)
              ? "skipped via sdk-test-control.json" : reason);
    }
    ThesmsworksSDK client = setup.client;

    // CREATE
    SdkEntity messageMessageRef01Ent = client.messageMessage(null);
    Map<String, Object> messageMessageRef01Data = Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.message_message"), "message_message_ref01"));

    Object messageMessageRef01DataResult = messageMessageRef01Ent.create(messageMessageRef01Data, null);
    messageMessageRef01Data = Helpers.toMapAny(messageMessageRef01DataResult instanceof SdkEntity ? ((SdkEntity) messageMessageRef01DataResult).data() : messageMessageRef01DataResult);
    assertNotNull(messageMessageRef01Data, "expected create result to be a map");
    assertNotNull(messageMessageRef01Data.get("id"), "expected created entity to have an id");

    // LOAD
    Map<String, Object> messageMessageRef01MatchDt0 = new LinkedHashMap<>();
    messageMessageRef01MatchDt0.put("id", messageMessageRef01Data.get("id"));
    Object messageMessageRef01DataDt0Loaded = messageMessageRef01Ent.load(messageMessageRef01MatchDt0, null);
    Map<String, Object> messageMessageRef01DataDt0LoadResult = Helpers.toMapAny(messageMessageRef01DataDt0Loaded instanceof SdkEntity ? ((SdkEntity) messageMessageRef01DataDt0Loaded).data() : messageMessageRef01DataDt0Loaded);
    assertNotNull(messageMessageRef01DataDt0LoadResult, "expected load result to be a map");
    assertEquals(messageMessageRef01Data.get("id"), messageMessageRef01DataDt0LoadResult.get("id"),
        "expected load result id to match");

    // REMOVE
    Map<String, Object> messageMessageRef01MatchRm0 = new LinkedHashMap<>();
    messageMessageRef01MatchRm0.put("id", messageMessageRef01Data.get("id"));
    messageMessageRef01Ent.remove(messageMessageRef01MatchRm0, null);

  }

  static boolean hasFeature(String name) {
    Map<String, Object> fm = Helpers.toMapAny(Config.makeConfig().get("feature"));
    return fm != null && fm.get(name) != null;
  }

  @Test
  public void validate() {
    Assumptions.assumeTrue(hasFeature("validate"), "feature not present in this SDK: validate");
    ThesmsworksSDK client = ThesmsworksSDK.testSDK(null,
        Struct.jm("feature", Struct.jm("validate", Struct.jm("active", true))));
    SdkError err = assertThrows(SdkError.class, () ->
        client.messageMessage(null).load(Struct.jm("id", 1), null));
    assertEquals("validate_failed", err.code);
  }

  static RunnerSupport.EntityTestSetup messageMessageBasicSetup(Map<String, Object> extra) {
    RunnerSupport.loadEnvLocal();

    Map<String, Object> entityData;
    try {
      String entityDataSource = Files.readString(Path.of(
          "..", ".sdk", "test", "entity", "message_message", "MessageMessageTestData.json"));
      entityData = Helpers.toMapAny(Json.parse(entityDataSource));
    }
    catch (Exception e) {
      throw new AssertionError("failed to read message_message test data: " + e.getMessage(), e);
    }

    Map<String, Object> options = new LinkedHashMap<>();
    options.put("entity", entityData.get("existing"));

    ThesmsworksSDK client = ThesmsworksSDK.testSDK(options, extra);

    // Generate idmap via transform, matching TS pattern.
    List<Object> idnames = new ArrayList<>();
    idnames.add("message_message01");
    idnames.add("message_message02");
    idnames.add("message_message03");
    Object idmap = Struct.transform(idnames, Json.parse(
        "{\"`$PACK`\": [\"\", {"
        + "\"`$KEY`\": \"`$COPY`\","
        + "\"`$VAL`\": [\"`$FORMAT`\", \"upper\", \"`$COPY`\"]"
        + "}]}"));

    // Whether *_ENTID supplied the idmap, read before envOverride consumes
    // it: without it, the ids a live flow binds are the fixture's synthetic ones.
    String entidEnvRaw = RunnerSupport.getenv("THESMSWORKS_TEST_MESSAGE_MESSAGE_ENTID");
    boolean idmapOverridden = entidEnvRaw != null
        && entidEnvRaw.trim().startsWith("{");

    Map<String, Object> envm = new LinkedHashMap<>();
    envm.put("THESMSWORKS_TEST_MESSAGE_MESSAGE_ENTID", idmap);
    envm.put("THESMSWORKS_TEST_LIVE", "FALSE");
    envm.put("THESMSWORKS_TEST_EXPLAIN", "FALSE");
    envm.put("THESMSWORKS_APIKEY", "");
    Map<String, Object> env = RunnerSupport.envOverride(envm);

    Map<String, Object> idmapResolved = Helpers.toMapAny(env.get("THESMSWORKS_TEST_MESSAGE_MESSAGE_ENTID"));
    if (idmapResolved == null) {
      idmapResolved = Helpers.toMapAny(idmap);
    }

    boolean live = "TRUE".equals(env.get("THESMSWORKS_TEST_LIVE"));
    if (live) {
      // sdk-test-control.json's test.client.options seeds the live
      // client; the generated fields below overwrite anything they name.
      Map<String, Object> liveOpts =
          new LinkedHashMap<>(RunnerSupport.liveClientOptions());
      liveOpts.put("apikey", env.get("THESMSWORKS_APIKEY"));
      // An empty map, not a null one: merge answers null when its last
      // entry is null, and basicSetup is normally called with no extras -
      // so a bare null silently discarded the apikey and server values
      // above.
      Map<String, Object> extraOpts =
          extra == null ? new LinkedHashMap<>() : extra;
      Object mergedOpts = Struct.merge(Struct.jt(liveOpts, extraOpts));
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
