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
	core.NewTestFeatureFunc = func() core.Feature {
		return feature.NewTestFeature()
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
	core.NewFlashEntityFunc = func(client *core.ThesmsworksSDK, entopts map[string]any) core.ThesmsworksEntity {
		return entity.NewFlashEntity(client, entopts)
	}
	core.NewMessageEntityFunc = func(client *core.ThesmsworksSDK, entopts map[string]any) core.ThesmsworksEntity {
		return entity.NewMessageEntity(client, entopts)
	}
	core.NewOneTimePasswordEntityFunc = func(client *core.ThesmsworksSDK, entopts map[string]any) core.ThesmsworksEntity {
		return entity.NewOneTimePasswordEntity(client, entopts)
	}
	core.NewScheduleEntityFunc = func(client *core.ThesmsworksSDK, entopts map[string]any) core.ThesmsworksEntity {
		return entity.NewScheduleEntity(client, entopts)
	}
	core.NewSwaggerEntityFunc = func(client *core.ThesmsworksSDK, entopts map[string]any) core.ThesmsworksEntity {
		return entity.NewSwaggerEntity(client, entopts)
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

// No-arg convenience constructors. Go has no default-argument syntax,
// so these aliases let callers write `sdk.New()` / `sdk.Test()`
// instead of `sdk.NewThesmsworksSDK(nil)` / `sdk.TestSDK(nil, nil)`
// for the common no-options case.
func New() *ThesmsworksSDK  { return NewThesmsworksSDK(nil) }
func Test() *ThesmsworksSDK { return TestSDK(nil, nil) }
var NewBaseFeature = feature.NewBaseFeature
var NewTestFeature = feature.NewTestFeature
