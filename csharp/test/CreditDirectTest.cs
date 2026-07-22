// credit direct API tests (generated from the API model).

using System.Text.Json;

using Voxgig.Struct;
using Xunit;

namespace ThesmsworksSdk.Test;

public class CreditDirectTest
{
    [Fact]
    public void DirectLoad()
    {
        var setup = CreditDirectSetup(
            new Dictionary<string, object?> { ["id"] = "direct01" });
        var _mode = setup.Live ? "live" : "unit";
        var (_shouldSkip, _) = TestRunner.IsControlSkipped(
            "direct", "direct-load-credit", _mode);
        if (_shouldSkip)
        {
            return; // skipped via sdk-test-control.json
        }
        var client = setup.Client;


        var result = client.Direct(new Dictionary<string, object?>
        {
            ["path"] = "credits/balance",
            ["method"] = "GET",
            ["params"] = new Dictionary<string, object?>(),
        });
        if (setup.Live)
        {
            // Live mode is lenient: synthetic IDs frequently 4xx. Bail
            // rather than fail when the load endpoint isn't reachable.
            if (!Equals(result["ok"], true))
            {
                return;
            }
            var status = Helpers.ToInt(result["status"]);
            if (status < 200 || status >= 300)
            {
                return;
            }
            Assert.NotNull(result["data"]);
        }
        else
        {
            Assert.True(Equals(result["ok"], true),
                $"expected ok to be true, got {result.GetValueOrDefault("err")}");
            Assert.Equal(200, Helpers.ToInt(result["status"]));
            Assert.NotNull(result["data"]);
        }

        if (!setup.Live)
        {
            if (result["data"] is Dictionary<string, object?> dataMap)
            {
                Assert.True(Equals(dataMap["id"], "direct01"),
                    $"expected data.id to be direct01, got {dataMap["id"]}");
            }

            Assert.True(setup.Calls.Count == 1,
                $"expected 1 call, got {setup.Calls.Count}");
            var call = setup.Calls[0];
            var init = call["init"] as Dictionary<string, object?>;
            Assert.Equal("GET", init?["method"]);
            var url = call["url"] as string ?? "";
        }
    }

    private class CreditDirectSetupResult
    {
        public ThesmsworksSDK Client = null!;
        public List<Dictionary<string, object?>> Calls = new();
        public bool Live;
        public Dictionary<string, object?> Idmap = new();
    }

    private static CreditDirectSetupResult CreditDirectSetup(object? mockres)
    {
        TestRunner.LoadEnvLocal();

        var calls = new List<Dictionary<string, object?>>();

        var env = TestRunner.EnvOverride(new Dictionary<string, object?>
        {
            ["THESMSWORKS_TEST_CREDIT_ENTID"] = new Dictionary<string, object?>(),
            ["THESMSWORKS_TEST_LIVE"] = "FALSE",
            ["THESMSWORKS_APIKEY"] = "NONE",
        });

        var live = Equals(env["THESMSWORKS_TEST_LIVE"], "TRUE");

        if (live)
        {
            var liveClient = new ThesmsworksSDK(new Dictionary<string, object?>
            {
                ["apikey"] = env["THESMSWORKS_APIKEY"],
            });

            var idmap = new Dictionary<string, object?>();
            var entidRaw = env["THESMSWORKS_TEST_CREDIT_ENTID"];
            if (entidRaw is string entidStr && entidStr.StartsWith("{"))
            {
                try
                {
                    var el = JsonSerializer.Deserialize<JsonElement>(entidStr);
                    idmap = StructRunner.ConvertElement(el)
                        as Dictionary<string, object?> ?? idmap;
                }
                catch (JsonException)
                {
                }
            }
            else if (entidRaw is Dictionary<string, object?> entidMap)
            {
                idmap = entidMap;
            }

            return new CreditDirectSetupResult
            {
                Client = liveClient,
                Calls = calls,
                Live = true,
                Idmap = idmap,
            };
        }

        Func<string, Dictionary<string, object?>, Dictionary<string, object?>> mockFetch =
            (url, init) =>
            {
                calls.Add(new Dictionary<string, object?>
                {
                    ["url"] = url,
                    ["init"] = init,
                });
                return new Dictionary<string, object?>
                {
                    ["status"] = 200,
                    ["statusText"] = "OK",
                    ["headers"] = new Dictionary<string, object?>(),
                    ["json"] = (Func<object?>)(() =>
                        mockres ?? new Dictionary<string, object?> { ["id"] = "direct01" }),
                };
            };

        var client = new ThesmsworksSDK(new Dictionary<string, object?>
        {
            ["base"] = "http://localhost:8080",
            ["system"] = new Dictionary<string, object?>
            {
                ["fetch"] = mockFetch,
            },
        });

        return new CreditDirectSetupResult
        {
            Client = client,
            Calls = calls,
            Live = false,
            Idmap = new Dictionary<string, object?>(),
        };
    }
}
