// one_time_password entity test - basic flow (generated from the API model).

using System.Text.Json;

using Voxgig.Struct;
using Xunit;

namespace ThesmsworksSdk.Test;

public class OneTimePasswordEntityTest
{
    [Fact]
    public void Instance()
    {
        var testsdk = ThesmsworksSDK.TestSDK(null, null);
        var ent = testsdk.OneTimePassword();
        Assert.NotNull(ent);
    }

    [Fact]
    public void Basic()
    {
        var setup = OneTimePasswordBasicSetup(null);
        // Per-op sdk-test-control.json skip - basic test exercises a flow
        // with multiple ops; skipping any op skips the whole flow.
        var _mode = setup.Live ? "live" : "unit";
        foreach (var _op in new[] { "create", "load" })
        {
            var (_shouldSkip, _) = TestRunner.IsControlSkipped(
                "entityOp", "one_time_password." + _op, _mode);
            if (_shouldSkip)
            {
                return; // skipped via sdk-test-control.json
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live
        // mode without an *_ENTID env override, those IDs hit the live API
        // and 4xx; set THESMSWORKS_TEST_ONE_TIME_PASSWORD_ENTID JSON to run live.
        if (setup.SyntheticOnly)
        {
            return;
        }
        var client = setup.Client;

        // CREATE
        var oneTimePasswordRef01Ent = client.OneTimePassword();
        var oneTimePasswordRef01Data = Helpers.ToMapAny(StructUtils.GetProp(
            StructUtils.GetPath(setup.Data, StructUtils.Jt("new", "one_time_password")),
            "one_time_password_ref01"));

        var oneTimePasswordRef01DataResult = oneTimePasswordRef01Ent.Create(oneTimePasswordRef01Data, null);
        oneTimePasswordRef01Data = Helpers.ToMapAny(oneTimePasswordRef01DataResult);
        Assert.True(oneTimePasswordRef01Data != null, "expected create result to be a map");

        // LOAD
        var oneTimePasswordRef01MatchDt0 = new Dictionary<string, object?>();
        var oneTimePasswordRef01DataDt0Loaded = oneTimePasswordRef01Ent.Load(oneTimePasswordRef01MatchDt0, null);
        Assert.True(oneTimePasswordRef01DataDt0Loaded != null, "expected load result to be non-null");

    }

    private static EntityTestSetup OneTimePasswordBasicSetup(
        Dictionary<string, object?>? extra)
    {
        TestRunner.LoadEnvLocal();

        var entityDataFile = Path.Combine(TestRunner.TestDir(),
            "..", "..", ".sdk", "test", "entity", "one_time_password",
            "OneTimePasswordTestData.json");

        var entityDataEl = JsonSerializer.Deserialize<JsonElement>(
            File.ReadAllText(entityDataFile));
        var entityData = StructRunner.ConvertElement(entityDataEl)
            as Dictionary<string, object?>
            ?? throw new InvalidOperationException(
                "failed to parse one_time_password test data");

        var options = new Dictionary<string, object?>
        {
            ["entity"] = entityData["existing"],
        };

        var client = ThesmsworksSDK.TestSDK(options, extra);

        // Generate idmap via transform, matching the TS pattern.
        var idmap = StructUtils.Transform(
            new List<object?> { "one_time_password01", "one_time_password02", "one_time_password03", "otp01", "otp02", "otp03" },
            new Dictionary<string, object?>
            {
                ["`$PACK`"] = new List<object?>
                {
                    "",
                    new Dictionary<string, object?>
                    {
                        ["`$KEY`"] = "`$COPY`",
                        ["`$VAL`"] = new List<object?> { "`$FORMAT`", "upper", "`$COPY`" },
                    },
                },
            });

        // Detect ENTID env override before EnvOverride consumes it. When
        // live mode is on without a real override, the basic test runs
        // against synthetic IDs from the fixture and 4xx's.
        var entidEnvRaw = Environment.GetEnvironmentVariable(
            "THESMSWORKS_TEST_ONE_TIME_PASSWORD_ENTID") ?? "";
        var idmapOverridden = entidEnvRaw != "" &&
            entidEnvRaw.Trim().StartsWith("{");

        var env = TestRunner.EnvOverride(new Dictionary<string, object?>
        {
            ["THESMSWORKS_TEST_ONE_TIME_PASSWORD_ENTID"] = idmap,
            ["THESMSWORKS_TEST_LIVE"] = "FALSE",
            ["THESMSWORKS_TEST_EXPLAIN"] = "FALSE",
            ["THESMSWORKS_APIKEY"] = "NONE",
        });

        var idmapResolved = Helpers.ToMapAny(env["THESMSWORKS_TEST_ONE_TIME_PASSWORD_ENTID"])
            ?? Helpers.ToMapAny(idmap)
            ?? new Dictionary<string, object?>();

        if (Equals(env["THESMSWORKS_TEST_LIVE"], "TRUE"))
        {
            var mergedOpts = StructUtils.Merge(new List<object?>
            {
                new Dictionary<string, object?>
                {
                    ["apikey"] = env["THESMSWORKS_APIKEY"],
                },
                extra,
            });
            client = new ThesmsworksSDK(Helpers.ToMapAny(mergedOpts));
        }

        var live = Equals(env["THESMSWORKS_TEST_LIVE"], "TRUE");
        return new EntityTestSetup
        {
            Client = client,
            Data = entityData,
            Idmap = idmapResolved,
            Env = env,
            Explain = Equals(env["THESMSWORKS_TEST_EXPLAIN"], "TRUE"),
            Live = live,
            SyntheticOnly = live && !idmapOverridden,
            Now = DateTimeOffset.UtcNow.ToUnixTimeMilliseconds(),
        };
    }
}
