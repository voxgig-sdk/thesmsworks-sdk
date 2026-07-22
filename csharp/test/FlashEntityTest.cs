// flash entity test - basic flow (generated from the API model).

using System.Text.Json;

using Voxgig.Struct;
using Xunit;

namespace ThesmsworksSdk.Test;

public class FlashEntityTest
{
    [Fact]
    public void Instance()
    {
        var testsdk = ThesmsworksSDK.TestSDK(null, null);
        var ent = testsdk.Flash();
        Assert.NotNull(ent);
    }

    [Fact]
    public void Basic()
    {
        var setup = FlashBasicSetup(null);
        // Per-op sdk-test-control.json skip - basic test exercises a flow
        // with multiple ops; skipping any op skips the whole flow.
        var _mode = setup.Live ? "live" : "unit";
        foreach (var _op in new[] {  })
        {
            var (_shouldSkip, _) = TestRunner.IsControlSkipped(
                "entityOp", "flash." + _op, _mode);
            if (_shouldSkip)
            {
                return; // skipped via sdk-test-control.json
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live
        // mode without an *_ENTID env override, those IDs hit the live API
        // and 4xx; set THESMSWORKS_TEST_FLASH_ENTID JSON to run live.
        if (setup.SyntheticOnly)
        {
            return;
        }
        // Bootstrap entity data from existing test data (no create step in flow).
        var flashRef01DataRaw = StructUtils.Items(
            Helpers.ToMapAny(StructUtils.GetPath(setup.Data, "existing.flash")));
        var flashRef01Data = flashRef01DataRaw.Count > 0
            ? Helpers.ToMapAny(flashRef01DataRaw[0][1])
            : null;

    }

    private static EntityTestSetup FlashBasicSetup(
        Dictionary<string, object?>? extra)
    {
        TestRunner.LoadEnvLocal();

        var entityDataFile = Path.Combine(TestRunner.TestDir(),
            "..", "..", ".sdk", "test", "entity", "flash",
            "FlashTestData.json");

        var entityDataEl = JsonSerializer.Deserialize<JsonElement>(
            File.ReadAllText(entityDataFile));
        var entityData = StructRunner.ConvertElement(entityDataEl)
            as Dictionary<string, object?>
            ?? throw new InvalidOperationException(
                "failed to parse flash test data");

        var options = new Dictionary<string, object?>
        {
            ["entity"] = entityData["existing"],
        };

        var client = ThesmsworksSDK.TestSDK(options, extra);

        // Generate idmap via transform, matching the TS pattern.
        var idmap = StructUtils.Transform(
            new List<object?> { "flash01", "flash02", "flash03" },
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
            "THESMSWORKS_TEST_FLASH_ENTID") ?? "";
        var idmapOverridden = entidEnvRaw != "" &&
            entidEnvRaw.Trim().StartsWith("{");

        var env = TestRunner.EnvOverride(new Dictionary<string, object?>
        {
            ["THESMSWORKS_TEST_FLASH_ENTID"] = idmap,
            ["THESMSWORKS_TEST_LIVE"] = "FALSE",
            ["THESMSWORKS_TEST_EXPLAIN"] = "FALSE",
            ["THESMSWORKS_APIKEY"] = "NONE",
        });

        var idmapResolved = Helpers.ToMapAny(env["THESMSWORKS_TEST_FLASH_ENTID"])
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
