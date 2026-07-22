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
            },
            ["feature"] = new Dictionary<string, object?>
            {
                ["test"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                    },
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
                    ["flash"] = new Dictionary<string, object?>(),
                    ["message"] = new Dictionary<string, object?>(),
                    ["one_time_password"] = new Dictionary<string, object?>(),
                    ["schedule"] = new Dictionary<string, object?>(),
                    ["swagger"] = new Dictionary<string, object?>(),
                    ["util"] = new Dictionary<string, object?>(),
                },
            },
            ["entity"] = new Dictionary<string, object?>
            {
                ["batch"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>(),
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
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["active"] = true,
                                                ["kind"] = "param",
                                                ["name"] = "id",
                                                ["orig"] = "batchid",
                                                ["reqd"] = true,
                                                ["type"] = "`$STRING`",
                                                ["index$"] = 0,
                                            },
                                        },
                                    },
                                    ["method"] = "GET",
                                    ["orig"] = "/batch/{batchid}",
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
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 0,
                                },
                            },
                            ["key$"] = "load",
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
                            ["active"] = true,
                            ["name"] = "ai",
                            ["req"] = false,
                            ["type"] = "`$BOOLEAN`",
                            ["index$"] = 0,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "content",
                            ["req"] = true,
                            ["type"] = "`$STRING`",
                            ["index$"] = 1,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "deliveryreporturl",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 2,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "destination",
                            ["req"] = true,
                            ["type"] = "`$ARRAY`",
                            ["index$"] = 3,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "schedule",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 4,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "sender",
                            ["req"] = true,
                            ["type"] = "`$STRING`",
                            ["index$"] = 5,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "tag",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 6,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "ttl",
                            ["req"] = false,
                            ["type"] = "`$NUMBER`",
                            ["index$"] = 7,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "validity",
                            ["req"] = false,
                            ["type"] = "`$NUMBER`",
                            ["index$"] = 8,
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
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["method"] = "POST",
                                    ["orig"] = "/batch/any",
                                    ["parts"] = new List<object?>
                                    {
                                        "batch",
                                        "any",
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 0,
                                },
                                new Dictionary<string, object?>
                                {
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["method"] = "POST",
                                    ["orig"] = "/batch/schedule",
                                    ["parts"] = new List<object?>
                                    {
                                        "batch",
                                        "schedule",
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 1,
                                },
                                new Dictionary<string, object?>
                                {
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["method"] = "POST",
                                    ["orig"] = "/batch/send",
                                    ["parts"] = new List<object?>
                                    {
                                        "batch",
                                        "send",
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 2,
                                },
                            },
                            ["key$"] = "create",
                        },
                        ["remove"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "remove",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["active"] = true,
                                                ["kind"] = "param",
                                                ["name"] = "batchid",
                                                ["orig"] = "batchid",
                                                ["reqd"] = true,
                                                ["type"] = "`$STRING`",
                                                ["index$"] = 0,
                                            },
                                        },
                                    },
                                    ["method"] = "DELETE",
                                    ["orig"] = "/batches/schedule/{batchid}",
                                    ["parts"] = new List<object?>
                                    {
                                        "batches",
                                        "schedule",
                                        "{batchid}",
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "batchid",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 0,
                                },
                            },
                            ["key$"] = "remove",
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>
                        {
                            new List<object?>
                            {
                                "schedule",
                            },
                        },
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
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["method"] = "GET",
                                    ["orig"] = "/credits/balance",
                                    ["parts"] = new List<object?>
                                    {
                                        "credits",
                                        "balance",
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "balance",
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 0,
                                },
                            },
                            ["key$"] = "load",
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["flash"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>(),
                    ["name"] = "flash",
                    ["op"] = new Dictionary<string, object?>(),
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
                            ["active"] = true,
                            ["name"] = "ai",
                            ["req"] = false,
                            ["type"] = "`$BOOLEAN`",
                            ["index$"] = 0,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "content",
                            ["req"] = true,
                            ["type"] = "`$STRING`",
                            ["index$"] = 1,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "credit",
                            ["req"] = false,
                            ["type"] = "`$NUMBER`",
                            ["index$"] = 2,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "deliveryreporturl",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 3,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "destination",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["create"] = new Dictionary<string, object?>
                                {
                                    ["req"] = false,
                                    ["type"] = "`$STRING`",
                                },
                            },
                            ["req"] = true,
                            ["type"] = "`$STRING`",
                            ["index$"] = 4,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "from",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 5,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "keyword",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 6,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "limit",
                            ["req"] = false,
                            ["type"] = "`$NUMBER`",
                            ["index$"] = 7,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "metadata",
                            ["req"] = false,
                            ["type"] = "`$OBJECT`",
                            ["index$"] = 8,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "responseemail",
                            ["req"] = false,
                            ["type"] = "`$ARRAY`",
                            ["index$"] = 9,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "schedule",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 10,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "sender",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["create"] = new Dictionary<string, object?>
                                {
                                    ["req"] = false,
                                    ["type"] = "`$STRING`",
                                },
                            },
                            ["req"] = true,
                            ["type"] = "`$STRING`",
                            ["index$"] = 11,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "skip",
                            ["req"] = false,
                            ["type"] = "`$NUMBER`",
                            ["index$"] = 12,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "status",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 13,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "tag",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 14,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "to",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 15,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "ttl",
                            ["req"] = false,
                            ["type"] = "`$NUMBER`",
                            ["index$"] = 16,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "unread",
                            ["req"] = false,
                            ["type"] = "`$BOOLEAN`",
                            ["index$"] = 17,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "validity",
                            ["req"] = false,
                            ["type"] = "`$NUMBER`",
                            ["index$"] = 18,
                        },
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
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["method"] = "POST",
                                    ["orig"] = "/message/flash",
                                    ["parts"] = new List<object?>
                                    {
                                        "message",
                                        "flash",
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "flash",
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 0,
                                },
                                new Dictionary<string, object?>
                                {
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["method"] = "POST",
                                    ["orig"] = "/message/schedule",
                                    ["parts"] = new List<object?>
                                    {
                                        "message",
                                        "schedule",
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "schedule",
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 1,
                                },
                                new Dictionary<string, object?>
                                {
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["method"] = "POST",
                                    ["orig"] = "/message/send",
                                    ["parts"] = new List<object?>
                                    {
                                        "message",
                                        "send",
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "send",
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 2,
                                },
                                new Dictionary<string, object?>
                                {
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["method"] = "POST",
                                    ["orig"] = "/messages",
                                    ["parts"] = new List<object?>
                                    {
                                        "messages",
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 3,
                                },
                                new Dictionary<string, object?>
                                {
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["method"] = "POST",
                                    ["orig"] = "/messages/failed",
                                    ["parts"] = new List<object?>
                                    {
                                        "messages",
                                        "failed",
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "failed",
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 4,
                                },
                                new Dictionary<string, object?>
                                {
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["method"] = "POST",
                                    ["orig"] = "/messages/inbox",
                                    ["parts"] = new List<object?>
                                    {
                                        "messages",
                                        "inbox",
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "inbox",
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 5,
                                },
                            },
                            ["key$"] = "create",
                        },
                        ["load"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "load",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["active"] = true,
                                                ["kind"] = "param",
                                                ["name"] = "id",
                                                ["orig"] = "messageid",
                                                ["reqd"] = true,
                                                ["type"] = "`$STRING`",
                                                ["index$"] = 0,
                                            },
                                        },
                                    },
                                    ["method"] = "GET",
                                    ["orig"] = "/messages/{messageid}",
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
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 0,
                                },
                                new Dictionary<string, object?>
                                {
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["method"] = "GET",
                                    ["orig"] = "/messages/schedule",
                                    ["parts"] = new List<object?>
                                    {
                                        "messages",
                                        "schedule",
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "schedule",
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 1,
                                },
                            },
                            ["key$"] = "load",
                        },
                        ["remove"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "remove",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["active"] = true,
                                                ["kind"] = "param",
                                                ["name"] = "id",
                                                ["orig"] = "messageid",
                                                ["reqd"] = true,
                                                ["type"] = "`$STRING`",
                                                ["index$"] = 0,
                                            },
                                        },
                                    },
                                    ["method"] = "DELETE",
                                    ["orig"] = "/messages/{messageid}",
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
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 0,
                                },
                                new Dictionary<string, object?>
                                {
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["active"] = true,
                                                ["kind"] = "param",
                                                ["name"] = "messageid",
                                                ["orig"] = "messageid",
                                                ["reqd"] = true,
                                                ["type"] = "`$STRING`",
                                                ["index$"] = 0,
                                            },
                                        },
                                    },
                                    ["method"] = "DELETE",
                                    ["orig"] = "/messages/schedule/{messageid}",
                                    ["parts"] = new List<object?>
                                    {
                                        "messages",
                                        "schedule",
                                        "{messageid}",
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "messageid",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 1,
                                },
                            },
                            ["key$"] = "remove",
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>
                        {
                            new List<object?>
                            {
                                "schedule",
                            },
                        },
                    },
                },
                ["one_time_password"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "destination",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 0,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "length",
                            ["req"] = false,
                            ["type"] = "`$OBJECT`",
                            ["index$"] = 1,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "metadata",
                            ["req"] = false,
                            ["type"] = "`$OBJECT`",
                            ["index$"] = 2,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "passcode",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 3,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "sender",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 4,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "template",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 5,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "validity",
                            ["req"] = false,
                            ["type"] = "`$NUMBER`",
                            ["index$"] = 6,
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
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["method"] = "POST",
                                    ["orig"] = "/otp/send",
                                    ["parts"] = new List<object?>
                                    {
                                        "otp",
                                        "send",
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 0,
                                },
                                new Dictionary<string, object?>
                                {
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["method"] = "POST",
                                    ["orig"] = "/otp/verify",
                                    ["parts"] = new List<object?>
                                    {
                                        "otp",
                                        "verify",
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 1,
                                },
                            },
                            ["key$"] = "create",
                        },
                        ["load"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "load",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["active"] = true,
                                                ["kind"] = "param",
                                                ["name"] = "messageid",
                                                ["orig"] = "messageid",
                                                ["reqd"] = true,
                                                ["type"] = "`$STRING`",
                                                ["index$"] = 0,
                                            },
                                        },
                                    },
                                    ["method"] = "GET",
                                    ["orig"] = "/otp/{messageid}",
                                    ["parts"] = new List<object?>
                                    {
                                        "otp",
                                        "{messageid}",
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "messageid",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 0,
                                },
                            },
                            ["key$"] = "load",
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>
                        {
                            new List<object?>
                            {
                                "otp",
                            },
                        },
                    },
                },
                ["schedule"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>(),
                    ["name"] = "schedule",
                    ["op"] = new Dictionary<string, object?>(),
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["swagger"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>(),
                    ["name"] = "swagger",
                    ["op"] = new Dictionary<string, object?>(),
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
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["active"] = true,
                                                ["kind"] = "param",
                                                ["name"] = "errorcode",
                                                ["orig"] = "errorcode",
                                                ["reqd"] = true,
                                                ["type"] = "`$STRING`",
                                                ["index$"] = 0,
                                            },
                                        },
                                    },
                                    ["method"] = "GET",
                                    ["orig"] = "/utils/errors/{errorcode}",
                                    ["parts"] = new List<object?>
                                    {
                                        "utils",
                                        "errors",
                                        "{errorcode}",
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "errorcode",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 0,
                                },
                                new Dictionary<string, object?>
                                {
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["method"] = "GET",
                                    ["orig"] = "/utils/test",
                                    ["parts"] = new List<object?>
                                    {
                                        "utils",
                                        "test",
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "test",
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 1,
                                },
                            },
                            ["key$"] = "load",
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>
                        {
                            new List<object?>
                            {
                                "error",
                            },
                        },
                    },
                },
            },
        };
    }

    public static Feature.BaseFeature MakeFeature(string name)
    {
        switch (name)
        {
            case "test":
                return new Feature.TestFeature();
            default:
                return new Feature.BaseFeature();
        }
    }
}
