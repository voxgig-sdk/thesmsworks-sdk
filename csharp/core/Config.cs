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
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["kind"] = "param",
                                                ["name"] = "id",
                                                ["orig"] = "batchid",
                                                ["reqd"] = true,
                                                ["type"] = "`$STRING`",
                                            },
                                        },
                                    },
                                    ["kind"] = "http",
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
                            ["type"] = "`$BOOLEAN`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "content",
                            ["req"] = true,
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "deliveryreporturl",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "destinations",
                            ["req"] = true,
                            ["type"] = "`$ARRAY`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "schedule",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "sender",
                            ["req"] = true,
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "tag",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "ttl",
                            ["type"] = "`$NUMBER`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "validity",
                            ["type"] = "`$NUMBER`",
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
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["kind"] = "http",
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
                                },
                                new Dictionary<string, object?>
                                {
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["kind"] = "http",
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
                                },
                                new Dictionary<string, object?>
                                {
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["kind"] = "http",
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
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["kind"] = "param",
                                                ["name"] = "batchid",
                                                ["orig"] = "batchid",
                                                ["reqd"] = true,
                                                ["type"] = "`$STRING`",
                                            },
                                        },
                                    },
                                    ["kind"] = "http",
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
                                },
                            },
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
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["kind"] = "http",
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
                                },
                            },
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
                            ["name"] = "ai",
                            ["type"] = "`$BOOLEAN`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "content",
                            ["req"] = true,
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "credits",
                            ["type"] = "`$NUMBER`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "deliveryreporturl",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "destination",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["create"] = new Dictionary<string, object?>
                                {
                                    ["type"] = "`$STRING`",
                                },
                            },
                            ["req"] = true,
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "from",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "keyword",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "limit",
                            ["type"] = "`$NUMBER`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "metadata",
                            ["type"] = "`$OBJECT`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "responseemail",
                            ["type"] = "`$ARRAY`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "schedule",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "sender",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["create"] = new Dictionary<string, object?>
                                {
                                    ["type"] = "`$STRING`",
                                },
                            },
                            ["req"] = true,
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "skip",
                            ["type"] = "`$NUMBER`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "status",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "tag",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "to",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "ttl",
                            ["type"] = "`$NUMBER`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "unread",
                            ["type"] = "`$BOOLEAN`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "validity",
                            ["type"] = "`$NUMBER`",
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
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["kind"] = "http",
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
                                },
                                new Dictionary<string, object?>
                                {
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["kind"] = "http",
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
                                },
                                new Dictionary<string, object?>
                                {
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["kind"] = "http",
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
                                },
                                new Dictionary<string, object?>
                                {
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["kind"] = "http",
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
                                },
                                new Dictionary<string, object?>
                                {
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["kind"] = "http",
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
                                },
                                new Dictionary<string, object?>
                                {
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["kind"] = "http",
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
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["kind"] = "param",
                                                ["name"] = "id",
                                                ["orig"] = "messageid",
                                                ["reqd"] = true,
                                                ["type"] = "`$STRING`",
                                            },
                                        },
                                    },
                                    ["kind"] = "http",
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
                                },
                                new Dictionary<string, object?>
                                {
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["kind"] = "http",
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
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["kind"] = "param",
                                                ["name"] = "id",
                                                ["orig"] = "messageid",
                                                ["reqd"] = true,
                                                ["type"] = "`$STRING`",
                                            },
                                        },
                                    },
                                    ["kind"] = "http",
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
                                },
                                new Dictionary<string, object?>
                                {
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["kind"] = "param",
                                                ["name"] = "messageid",
                                                ["orig"] = "messageid",
                                                ["reqd"] = true,
                                                ["type"] = "`$STRING`",
                                            },
                                        },
                                    },
                                    ["kind"] = "http",
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
                                },
                            },
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
                            ["name"] = "destination",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "length",
                            ["type"] = "`$OBJECT`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "metadata",
                            ["type"] = "`$OBJECT`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "passcode",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "sender",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "template",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "validity",
                            ["type"] = "`$NUMBER`",
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
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["kind"] = "http",
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
                                },
                                new Dictionary<string, object?>
                                {
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["kind"] = "http",
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
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["kind"] = "param",
                                                ["name"] = "messageid",
                                                ["orig"] = "messageid",
                                                ["reqd"] = true,
                                                ["type"] = "`$STRING`",
                                            },
                                        },
                                    },
                                    ["kind"] = "http",
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
                                },
                            },
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
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["kind"] = "param",
                                                ["name"] = "errorcode",
                                                ["orig"] = "errorcode",
                                                ["reqd"] = true,
                                                ["type"] = "`$STRING`",
                                            },
                                        },
                                    },
                                    ["kind"] = "http",
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
                                },
                                new Dictionary<string, object?>
                                {
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["kind"] = "http",
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
                                },
                            },
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
