package core

var UtilityRegistrar func(u *Utility)

var NewBaseFeatureFunc func() Feature

var NewAuditFeatureFunc func() Feature

var NewCacheFeatureFunc func() Feature

var NewClienttrackFeatureFunc func() Feature

var NewCostFeatureFunc func() Feature

var NewDebugFeatureFunc func() Feature

var NewIdempotencyFeatureFunc func() Feature

var NewLogFeatureFunc func() Feature

var NewMetricsFeatureFunc func() Feature

var NewNetsimFeatureFunc func() Feature

var NewPagingFeatureFunc func() Feature

var NewProxyFeatureFunc func() Feature

var NewRatelimitFeatureFunc func() Feature

var NewRbacFeatureFunc func() Feature

var NewRetryFeatureFunc func() Feature

var NewSecretsFeatureFunc func() Feature

var NewStreamingFeatureFunc func() Feature

var NewTelemetryFeatureFunc func() Feature

var NewTestFeatureFunc func() Feature

var NewTimeoutFeatureFunc func() Feature

var NewValidateFeatureFunc func() Feature

var NewBatchEntityFunc func(client *ThesmsworksSDK, entopts map[string]any) ThesmsworksEntity

var NewBatchMessageEntityFunc func(client *ThesmsworksSDK, entopts map[string]any) ThesmsworksEntity

var NewCreditEntityFunc func(client *ThesmsworksSDK, entopts map[string]any) ThesmsworksEntity

var NewMessageEntityFunc func(client *ThesmsworksSDK, entopts map[string]any) ThesmsworksEntity

var NewMessageScheduleEntityFunc func(client *ThesmsworksSDK, entopts map[string]any) ThesmsworksEntity

var NewOneTimePasswordEntityFunc func(client *ThesmsworksSDK, entopts map[string]any) ThesmsworksEntity

var NewScheduleEntityFunc func(client *ThesmsworksSDK, entopts map[string]any) ThesmsworksEntity

var NewUtilEntityFunc func(client *ThesmsworksSDK, entopts map[string]any) ThesmsworksEntity

