// Thesmsworks SDK - generated model configuration and feature
// factory. GENERATED from the API model - do not edit by hand.

namespace ThesmsworksSdk;

public static class SdkConfig
{
    public static Dictionary<string, object?> MakeConfig()
    {
        return new Dictionary<string, object?>
        {
            ["main"] = new Dictionary<string, object?>
            {
                ["name"] = "Thesmsworks",
                ["slug"] = "thesmsworks",
                ["version"] = "0.1.1",
                ["target"] = "csharp",
            },
            ["feature"] = new Dictionary<string, object?>
            {
                ["audit"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["actor"] = "anonymous",
                        ["max"] = 1000,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["now"] = "`$FUNCTION`",
                        ["sink"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["cache"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["max"] = 256,
                        ["methods"] = new List<object?>
                        {
                            "GET",
                        },
                        ["ttl"] = 5000,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["now"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "wrap",
                },
                ["clienttrack"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["clientVersion"] = "0.0.1",
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["clientName"] = "`$STRING`",
                        ["clientVersion"] = "`$STRING`",
                        ["headers"] = "`$MAP`",
                        ["idgen"] = "`$FUNCTION`",
                        ["sessionId"] = "`$STRING`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["cost"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["budget"] = 0,
                        ["currency"] = "USD",
                        ["header"] = "",
                        ["onBudget"] = "warn",
                        ["path"] = "",
                        ["perUnit"] = 0,
                        ["rates"] = new Dictionary<string, object?>(),
                        ["unit"] = 0,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["actor"] = "`$STRING`",
                        ["sink"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "wrap",
                },
                ["debug"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["max"] = 100,
                        ["redact"] = new List<object?>
                        {
                            "authorization",
                            "cookie",
                            "set-cookie",
                            "api-key",
                            "apikey",
                            "x-api-key",
                            "idempotency-key",
                        },
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["now"] = "`$FUNCTION`",
                        ["onEntry"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["idempotency"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["header"] = "Idempotency-Key",
                        ["methods"] = new List<object?>
                        {
                            "POST",
                            "PUT",
                            "PATCH",
                            "DELETE",
                        },
                        ["ops"] = new List<object?>
                        {
                            "create",
                            "update",
                            "remove",
                        },
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["keygen"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["log"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = true,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["level"] = "`$STRING`",
                        ["logger"] = "`$ANY`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["metrics"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["now"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["netsim"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["errorTimes"] = 0,
                        ["failEvery"] = 0,
                        ["failRate"] = 0,
                        ["failStatus"] = 503,
                        ["failTimes"] = 0,
                        ["latency"] = 0,
                        ["offline"] = false,
                        ["rateLimitTimes"] = 0,
                        ["retryAfter"] = 0,
                        ["seed"] = 1,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["latency"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$MAP`",
                        },
                        ["sleep"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "wrap",
                },
                ["paging"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["afterVar"] = "after",
                        ["cursorParam"] = "cursor",
                        ["firstVar"] = "first",
                        ["limitParam"] = "limit",
                        ["pageParam"] = "page",
                        ["startPage"] = 1,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["limit"] = "`$NUMBER`",
                        ["ops"] = "`$LIST`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["proxy"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["fromEnv"] = false,
                        ["noProxy"] = new List<object?>(),
                        ["url"] = "",
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["agent"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "wrap",
                },
                ["ratelimit"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["burst"] = 5,
                        ["rate"] = 5,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["now"] = "`$FUNCTION`",
                        ["sleep"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "wrap",
                },
                ["rbac"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["deny"] = false,
                        ["permissions"] = new List<object?>(),
                        ["rules"] = new Dictionary<string, object?>(),
                    },
                    ["optspec"] = new Dictionary<string, object?>(),
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["retry"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["factor"] = 2,
                        ["maxDelay"] = 2000,
                        ["minDelay"] = 50,
                        ["retries"] = 2,
                        ["statuses"] = new List<object?>
                        {
                            408,
                            425,
                            429,
                            500,
                            502,
                            503,
                            504,
                        },
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["jitter"] = "`$BOOLEAN`",
                        ["sleep"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "wrap",
                },
                ["secrets"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["cache"] = true,
                        ["exchange"] = new Dictionary<string, object?>
                        {
                            ["active"] = false,
                            ["method"] = "POST",
                            ["path"] = "auth/token",
                            ["refresh"] = "",
                            ["request"] = "refresh_token",
                            ["response"] = "access_token",
                            ["retries"] = 1,
                            ["statuses"] = new List<object?>
                            {
                                401,
                            },
                        },
                        ["name"] = "apikey",
                        ["providers"] = new List<object?>(),
                    },
                    ["optspec"] = new Dictionary<string, object?>(),
                    ["strict"] = false,
                    ["transport"] = "wrap",
                },
                ["streaming"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["chunkDelay"] = 0,
                        ["chunkSize"] = 0,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["ops"] = "`$LIST`",
                        ["sleep"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["telemetry"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["exporter"] = "`$FUNCTION`",
                        ["headers"] = "`$MAP`",
                        ["idgen"] = "`$FUNCTION`",
                        ["now"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["test"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["entity"] = "`$MAP`",
                        ["net"] = "`$MAP`",
                    },
                    ["strict"] = false,
                    ["transport"] = "base",
                },
                ["timeout"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["ms"] = 30000,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["clearTimer"] = "`$FUNCTION`",
                        ["setTimer"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "wrap",
                },
                ["validate"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["mode"] = "throw",
                        ["request"] = true,
                        ["response"] = false,
                        ["strict"] = false,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["mode"] = new List<object?>
                        {
                            "`$ONE`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "throw",
                            },
                            new List<object?>
                            {
                                "`$EXACT`",
                                "report",
                            },
                        },
                        ["onInvalid"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
            },
            ["options"] = new Dictionary<string, object?>
            {
                ["base"] = "https://api.thesmsworks.co.uk/v1",
                ["auth"] = new Dictionary<string, object?>
                {
                    ["prefix"] = "",
                },
                ["headers"] = new Dictionary<string, object?>
                {
                    ["content-type"] = "application/json",
                },
                ["entity"] = new Dictionary<string, object?>
                {
                    ["batch"] = new Dictionary<string, object?>(),
                    ["batch_message"] = new Dictionary<string, object?>(),
                    ["credit"] = new Dictionary<string, object?>(),
                    ["message"] = new Dictionary<string, object?>(),
                    ["one_time_password"] = new Dictionary<string, object?>(),
                    ["util"] = new Dictionary<string, object?>(),
                },
            },
            ["entity"] = new Dictionary<string, object?>
            {
                ["batch"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "id",
                            ["title"] = "Id",
                            ["type"] = "`$STRING`",
                        },
                    },
                    ["id"] = new Dictionary<string, object?>
                    {
                        ["field"] = "id",
                        ["name"] = "id",
                    },
                    ["name"] = "batch",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["load"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "load",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/batch/{batchid}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "batch",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "batch",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["batchid"] = "id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "batchid",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["batch_message"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "ai",
                            ["title"] = "Ai",
                            ["type"] = "`$BOOLEAN`",
                            ["short"] = "Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "content",
                            ["title"] = "Content",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                            ["short"] = "Message to send to the recipient",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "deliveryreporturl",
                            ["title"] = "Deliveryreporturl",
                            ["type"] = "`$STRING`",
                            ["short"] = "The url to which we should POST delivery reports to for this message.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "destinations",
                            ["title"] = "Destinations",
                            ["type"] = "`$ARRAY`",
                            ["req"] = true,
                            ["short"] = "Telephone numbers of each of the recipients",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "schedule",
                            ["title"] = "Schedule",
                            ["type"] = "`$STRING`",
                            ["short"] = "Date-time at which to send the batch.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "sender",
                            ["title"] = "Sender",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                            ["short"] = "The sender of the message.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "tag",
                            ["title"] = "Tag",
                            ["type"] = "`$STRING`",
                            ["short"] = "An identifying label for the message, which you can use to filter and report on messages you've sent later.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "ttl",
                            ["title"] = "Ttl",
                            ["type"] = "`$NUMBER`",
                            ["short"] = "The number of minutes before the delivery report is deleted.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "validity",
                            ["title"] = "Validity",
                            ["type"] = "`$NUMBER`",
                            ["short"] = "The optional number of minutes to attempt delivery before the message is marked as EXPIRED.",
                        },
                    },
                    ["name"] = "batch_message",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/batch/any",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "batch",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "any",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "batch",
                                        "any",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/batch/schedule",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "batch",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "schedule",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "batch",
                                        "schedule",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/batch/send",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "batch",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "send",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "batch",
                                        "send",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                },
                            },
                        },
                        ["remove"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "remove",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "DELETE",
                                    ["orig"] = "/batches/schedule/{batchid}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "batches",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "schedule",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "batchid",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "batches",
                                        "schedule",
                                        "{batchid}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "batchid",
                                                ["orig"] = "batchid",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "batchid",
                                        },
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["credit"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>(),
                    ["name"] = "credit",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["load"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "load",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/credits/balance",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "credits",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "balance",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "credits",
                                        "balance",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "balance",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["message"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "credits",
                            ["title"] = "Credits",
                            ["type"] = "`$NUMBER`",
                            ["short"] = "The number of credits used on the message.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "destination",
                            ["title"] = "Destination",
                            ["type"] = "`$STRING`",
                            ["short"] = "The phone number of the recipient.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "from",
                            ["title"] = "From",
                            ["type"] = "`$STRING`",
                            ["short"] = "The date-time from which you would like matching messages",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "id",
                            ["title"] = "Id",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "keyword",
                            ["title"] = "Keyword",
                            ["type"] = "`$STRING`",
                            ["short"] = "The keyword used in the inbound message",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "limit",
                            ["title"] = "Limit",
                            ["type"] = "`$NUMBER`",
                            ["short"] = "The maximum number of messages that you would like returned in this call.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "metadata",
                            ["title"] = "Metadata",
                            ["type"] = "`$OBJECT`",
                            ["short"] = "An array of objects containing metadata key/value pairs that have been saved on messages.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "sender",
                            ["title"] = "Sender",
                            ["type"] = "`$STRING`",
                            ["short"] = "The sender of the message (this can be the configured sender name for an outbound message or the senders phone number for an inbound message).",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "skip",
                            ["title"] = "Skip",
                            ["type"] = "`$NUMBER`",
                            ["short"] = "The number of results you would like to ignore before returning messages.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "status",
                            ["title"] = "Status",
                            ["type"] = "`$STRING`",
                            ["short"] = "The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING')",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "to",
                            ["title"] = "To",
                            ["type"] = "`$STRING`",
                            ["short"] = "The date-time to which you would like matching messages",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "unread",
                            ["title"] = "Unread",
                            ["type"] = "`$BOOLEAN`",
                            ["short"] = "In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false).",
                        },
                    },
                    ["id"] = new Dictionary<string, object?>
                    {
                        ["field"] = "id",
                        ["name"] = "id",
                    },
                    ["name"] = "message",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/message/flash",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "message",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "flash",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "message",
                                        "flash",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "flash",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/message/schedule",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "message",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "schedule",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "message",
                                        "schedule",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "schedule",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/message/send",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "message",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "send",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "message",
                                        "send",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "send",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/messages",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "messages",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "messages",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/messages/failed",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "messages",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "failed",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "messages",
                                        "failed",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "failed",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/messages/inbox",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "messages",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "inbox",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "messages",
                                        "inbox",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "inbox",
                                    },
                                },
                            },
                        },
                        ["load"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "load",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/messages/{messageid}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "messages",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "messages",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["messageid"] = "id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "messageid",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/messages/schedule",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "messages",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "schedule",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "messages",
                                        "schedule",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "schedule",
                                    },
                                },
                            },
                        },
                        ["remove"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "remove",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "DELETE",
                                    ["orig"] = "/messages/{messageid}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "messages",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "messages",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["messageid"] = "id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "messageid",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "DELETE",
                                    ["orig"] = "/messages/schedule/{messageid}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "messages",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "schedule",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "messageid",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "messages",
                                        "schedule",
                                        "{messageid}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "messageid",
                                                ["orig"] = "messageid",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "messageid",
                                        },
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["one_time_password"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "destination",
                            ["title"] = "Destination",
                            ["type"] = "`$STRING`",
                            ["short"] = "The phone number of the recipient.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "length",
                            ["title"] = "Length",
                            ["type"] = "`$OBJECT`",
                            ["short"] = "The length of the generated passcode.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "metadata",
                            ["title"] = "Metadata",
                            ["type"] = "`$OBJECT`",
                            ["short"] = "A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "passcode",
                            ["title"] = "Passcode",
                            ["type"] = "`$STRING`",
                            ["short"] = "A passcode you supply for use in the message template.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "sender",
                            ["title"] = "Sender",
                            ["type"] = "`$STRING`",
                            ["short"] = "The sender of the message.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "template",
                            ["title"] = "Template",
                            ["type"] = "`$STRING`",
                            ["short"] = "A template to use as the content for the message.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "validity",
                            ["title"] = "Validity",
                            ["type"] = "`$NUMBER`",
                            ["short"] = "The length of time in seconds for which the generated passcode should be valid.",
                        },
                    },
                    ["name"] = "one_time_password",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/otp/send",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "otp",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "send",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "otp",
                                        "send",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/otp/verify",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "otp",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "verify",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "otp",
                                        "verify",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                },
                            },
                        },
                        ["load"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "load",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/otp/{messageid}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "otp",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "messageid",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "otp",
                                        "{messageid}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "messageid",
                                                ["orig"] = "messageid",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "messageid",
                                        },
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["util"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>(),
                    ["name"] = "util",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["load"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "load",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/utils/errors/{errorcode}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "utils",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "errors",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "errorcode",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "utils",
                                        "errors",
                                        "{errorcode}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "errorcode",
                                                ["orig"] = "errorcode",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "errorcode",
                                        },
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/utils/test",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "utils",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "test",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "utils",
                                        "test",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "test",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
            },
        };
    }

    private static readonly Lazy<Dictionary<string, object?>> SharedConfigVal =
        new(MakeConfig);

    // The process-wide config, built once on first use.
    //
    // The returned dictionary is SHARED: treat it as read-only. Callers that
    // need to mutate should use MakeConfig, which always returns a fresh copy.
    public static Dictionary<string, object?> SharedConfig()
    {
        return SharedConfigVal.Value;
    }

    public static List<object?> FeaturePlugins(string name)
    {
        switch (name)
        {
            default:
                return new List<object?>();
        }
    }

    public static Feature.BaseFeature MakeFeature(string name)
    {
        switch (name)
        {
            case "audit":
                return new Feature.AuditFeature();
            case "cache":
                return new Feature.CacheFeature();
            case "clienttrack":
                return new Feature.ClienttrackFeature();
            case "cost":
                return new Feature.CostFeature();
            case "debug":
                return new Feature.DebugFeature();
            case "idempotency":
                return new Feature.IdempotencyFeature();
            case "log":
                return new Feature.LogFeature();
            case "metrics":
                return new Feature.MetricsFeature();
            case "netsim":
                return new Feature.NetsimFeature();
            case "paging":
                return new Feature.PagingFeature();
            case "proxy":
                return new Feature.ProxyFeature();
            case "ratelimit":
                return new Feature.RatelimitFeature();
            case "rbac":
                return new Feature.RbacFeature();
            case "retry":
                return new Feature.RetryFeature();
            case "secrets":
                return new Feature.SecretsFeature();
            case "streaming":
                return new Feature.StreamingFeature();
            case "telemetry":
                return new Feature.TelemetryFeature();
            case "test":
                return new Feature.TestFeature();
            case "timeout":
                return new Feature.TimeoutFeature();
            case "validate":
                return new Feature.ValidateFeature();
            default:
                return new Feature.BaseFeature();
        }
    }
}
