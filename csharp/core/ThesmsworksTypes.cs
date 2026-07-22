// Typed reference models for the Thesmsworks SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels (source of truth: @voxgig/apidef VALID_CANON). Do
// not edit by hand.
//
// These records are documentation/DX reference shapes ONLY. The SDK ops take
// and return the loose object model (Dictionary<string, object?> / object?) at
// runtime, so these types are not wired into the op signatures — use them to
// describe a payload before converting it to a dictionary. Optional (req:false)
// keys are modelled as nullable properties.

namespace ThesmsworksSdk.Types;

public record Batch();

public record BatchLoadMatch
{
    public string id { get; init; }
}

public record BatchMessage
{
    public bool? ai { get; init; }
    public string content { get; init; }
    public string? deliveryreporturl { get; init; }
    public List<object?> destination { get; init; }
    public string? schedule { get; init; }
    public string sender { get; init; }
    public string? tag { get; init; }
    public double? ttl { get; init; }
    public double? validity { get; init; }
}

public record BatchMessageCreateData
{
    public bool? ai { get; init; }
    public string content { get; init; }
    public string? deliveryreporturl { get; init; }
    public List<object?> destination { get; init; }
    public string? schedule { get; init; }
    public string sender { get; init; }
    public string? tag { get; init; }
    public double? ttl { get; init; }
    public double? validity { get; init; }
}

public record BatchMessageRemoveMatch
{
    public string batchid { get; init; }
}

public record Credit();

public record CreditLoadMatch();

public record Flash();

public record Message
{
    public bool? ai { get; init; }
    public string content { get; init; }
    public double? credit { get; init; }
    public string? deliveryreporturl { get; init; }
    public string destination { get; init; }
    public string? from { get; init; }
    public string? keyword { get; init; }
    public double? limit { get; init; }
    public Dictionary<string, object?>? metadata { get; init; }
    public List<object?>? responseemail { get; init; }
    public string? schedule { get; init; }
    public string sender { get; init; }
    public double? skip { get; init; }
    public string? status { get; init; }
    public string? tag { get; init; }
    public string? to { get; init; }
    public double? ttl { get; init; }
    public bool? unread { get; init; }
    public double? validity { get; init; }
}

public record MessageLoadMatch
{
    public string id { get; init; }
}

public record MessageCreateData
{
    public bool? ai { get; init; }
    public string content { get; init; }
    public double? credit { get; init; }
    public string? deliveryreporturl { get; init; }
    public string destination { get; init; }
    public string? from { get; init; }
    public string? keyword { get; init; }
    public double? limit { get; init; }
    public Dictionary<string, object?>? metadata { get; init; }
    public List<object?>? responseemail { get; init; }
    public string? schedule { get; init; }
    public string sender { get; init; }
    public double? skip { get; init; }
    public string? status { get; init; }
    public string? tag { get; init; }
    public string? to { get; init; }
    public double? ttl { get; init; }
    public bool? unread { get; init; }
    public double? validity { get; init; }
}

public record MessageRemoveMatch
{
    public string? id { get; init; }
    public string? messageid { get; init; }
}

public record OneTimePassword
{
    public string? destination { get; init; }
    public Dictionary<string, object?>? length { get; init; }
    public Dictionary<string, object?>? metadata { get; init; }
    public string? passcode { get; init; }
    public string? sender { get; init; }
    public string? template { get; init; }
    public double? validity { get; init; }
}

public record OneTimePasswordLoadMatch
{
    public string messageid { get; init; }
}

public record OneTimePasswordCreateData
{
    public string? destination { get; init; }
    public Dictionary<string, object?>? length { get; init; }
    public Dictionary<string, object?>? metadata { get; init; }
    public string? passcode { get; init; }
    public string? sender { get; init; }
    public string? template { get; init; }
    public double? validity { get; init; }
}

public record Schedule();

public record Swagger();

public record Util();

public record UtilLoadMatch
{
    public string errorcode { get; init; }
}

