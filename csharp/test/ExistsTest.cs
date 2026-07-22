// Thesmsworks SDK exists test.

using Xunit;

using ThesmsworksSdk;

namespace ThesmsworksSdk.Test;

public class ExistsTest
{
    [Fact]
    public void TestMode()
    {
        var testsdk = ThesmsworksSDK.TestSDK(null, null);
        Assert.NotNull(testsdk);
    }
}
