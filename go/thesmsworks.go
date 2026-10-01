package voxgigthesmsworkssdk

import (
	"github.com/voxgig-sdk/thesmsworks-sdk/go/core"
	"github.com/voxgig-sdk/thesmsworks-sdk/go/entity"
	"github.com/voxgig-sdk/thesmsworks-sdk/go/feature"
	_ "github.com/voxgig-sdk/thesmsworks-sdk/go/utility"
)

// Type aliases preserve external API.
type ThesmsworksSDK = core.ThesmsworksSDK
type Context = core.Context
type Utility = core.Utility
type Feature = core.Feature
type Entity = core.Entity
type ThesmsworksEntity = core.ThesmsworksEntity
type FetcherFunc = core.FetcherFunc
type Spec = core.Spec
type Result = core.Result
type Response = core.Response
type Operation = core.Operation
type Control = core.Control
type ThesmsworksError = core.ThesmsworksError

// BaseFeature from feature package.
type BaseFeature = feature.BaseFeature

func init() {
	core.NewBaseFeatureFunc = func() core.Feature {
		return feature.NewBaseFeature()
	}
	core.NewAuditFeatureFunc = func() core.Feature {
		return feature.NewAuditFeature()
	}
	core.NewCacheFeatureFunc = func() core.Feature {
		return feature.NewCacheFeature()
	}
	core.NewClienttrackFeatureFunc = func() core.Feature {
		return feature.NewClienttrackFeature()
	}
	core.NewCostFeatureFunc = func() core.Feature {
		return feature.NewCostFeature()
	}
	core.NewDebugFeatureFunc = func() core.Feature {
		return feature.NewDebugFeature()
	}
	core.NewIdempotencyFeatureFunc = func() core.Feature {
		return feature.NewIdempotencyFeature()
	}
	core.NewLogFeatureFunc = func() core.Feature {
		return feature.NewLogFeature()
	}
	core.NewMetricsFeatureFunc = func() core.Feature {
		return feature.NewMetricsFeature()
	}
	core.NewNetsimFeatureFunc = func() core.Feature {
		return feature.NewNetsimFeature()
	}
	core.NewPagingFeatureFunc = func() core.Feature {
		return feature.NewPagingFeature()
	}
	core.NewProxyFeatureFunc = func() core.Feature {
		return feature.NewProxyFeature()
	}
	core.NewRatelimitFeatureFunc = func() core.Feature {
		return feature.NewRatelimitFeature()
	}
	core.NewRbacFeatureFunc = func() core.Feature {
		return feature.NewRbacFeature()
	}
	core.NewRetryFeatureFunc = func() core.Feature {
		return feature.NewRetryFeature()
	}
	core.NewSecretsFeatureFunc = func() core.Feature {
		return feature.NewSecretsFeature()
	}
	core.NewStreamingFeatureFunc = func() core.Feature {
		return feature.NewStreamingFeature()
	}
	core.NewTelemetryFeatureFunc = func() core.Feature {
		return feature.NewTelemetryFeature()
	}
	core.NewTestFeatureFunc = func() core.Feature {
		return feature.NewTestFeature()
	}
	core.NewTimeoutFeatureFunc = func() core.Feature {
		return feature.NewTimeoutFeature()
	}
	core.NewValidateFeatureFunc = func() core.Feature {
		return feature.NewValidateFeature()
	}
	core.NewBatchEntityFunc = func(client *core.ThesmsworksSDK, entopts map[string]any) core.ThesmsworksEntity {
		return entity.NewBatchEntity(client, entopts)
	}
	core.NewBatchMessageEntityFunc = func(client *core.ThesmsworksSDK, entopts map[string]any) core.ThesmsworksEntity {
		return entity.NewBatchMessageEntity(client, entopts)
	}
	core.NewCreditEntityFunc = func(client *core.ThesmsworksSDK, entopts map[string]any) core.ThesmsworksEntity {
		return entity.NewCreditEntity(client, entopts)
	}
	core.NewMessageEntityFunc = func(client *core.ThesmsworksSDK, entopts map[string]any) core.ThesmsworksEntity {
		return entity.NewMessageEntity(client, entopts)
	}
	core.NewOneTimePasswordEntityFunc = func(client *core.ThesmsworksSDK, entopts map[string]any) core.ThesmsworksEntity {
		return entity.NewOneTimePasswordEntity(client, entopts)
	}
	core.NewUtilEntityFunc = func(client *core.ThesmsworksSDK, entopts map[string]any) core.ThesmsworksEntity {
		return entity.NewUtilEntity(client, entopts)
	}
}

// Constructor re-exports.
var NewThesmsworksSDK = core.NewThesmsworksSDK
var TestSDK = core.TestSDK
var NewContext = core.NewContext
var NewSpec = core.NewSpec
var NewResult = core.NewResult
var NewResponse = core.NewResponse
var NewOperation = core.NewOperation
var MakeConfig = core.MakeConfig
var SharedConfig = core.SharedConfig

// No-arg convenience constructors. Go has no default-argument syntax,
// so these aliases let callers write `sdk.New()` / `sdk.Test()`
// instead of `sdk.NewThesmsworksSDK(nil)` / `sdk.TestSDK(nil, nil)`
// for the common no-options case.
func New() *ThesmsworksSDK  { return NewThesmsworksSDK(nil) }
func Test() *ThesmsworksSDK { return TestSDK(nil, nil) }
var NewBaseFeature = feature.NewBaseFeature
var NewAuditFeature = feature.NewAuditFeature
var NewCacheFeature = feature.NewCacheFeature
var NewClienttrackFeature = feature.NewClienttrackFeature
var NewCostFeature = feature.NewCostFeature
var NewDebugFeature = feature.NewDebugFeature
var NewIdempotencyFeature = feature.NewIdempotencyFeature
var NewLogFeature = feature.NewLogFeature
var NewMetricsFeature = feature.NewMetricsFeature
var NewNetsimFeature = feature.NewNetsimFeature
var NewPagingFeature = feature.NewPagingFeature
var NewProxyFeature = feature.NewProxyFeature
var NewRatelimitFeature = feature.NewRatelimitFeature
var NewRbacFeature = feature.NewRbacFeature
var NewRetryFeature = feature.NewRetryFeature
var NewSecretsFeature = feature.NewSecretsFeature
var NewStreamingFeature = feature.NewStreamingFeature
var NewTelemetryFeature = feature.NewTelemetryFeature
var NewTestFeature = feature.NewTestFeature
var NewTimeoutFeature = feature.NewTimeoutFeature
var NewValidateFeature = feature.NewValidateFeature
