// ThesmsworksError - the SDK error type. Carries the pipeline error code,
// the originating context and cleaned result/spec snapshots.

namespace ThesmsworksSdk;

public class ThesmsworksError : Exception
{
    public bool IsThesmsworksError = true;
    public string Sdk = "Thesmsworks";
    public string Code;
    public Context? Ctx;
    public object? ResultVal;
    public object? SpecVal;

    public ThesmsworksError(string code, string msg, Context? ctx)
        : base(msg)
    {
        Code = code;
        Ctx = ctx;
    }
}
