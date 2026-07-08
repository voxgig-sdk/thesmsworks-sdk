package core

var UtilityRegistrar func(u *Utility)

var NewBaseFeatureFunc func() Feature

var NewTestFeatureFunc func() Feature

var NewBatchEntityFunc func(client *ThesmsworksSDK, entopts map[string]any) ThesmsworksEntity

var NewBatchMessageEntityFunc func(client *ThesmsworksSDK, entopts map[string]any) ThesmsworksEntity

var NewCreditEntityFunc func(client *ThesmsworksSDK, entopts map[string]any) ThesmsworksEntity

var NewFlashEntityFunc func(client *ThesmsworksSDK, entopts map[string]any) ThesmsworksEntity

var NewMessageEntityFunc func(client *ThesmsworksSDK, entopts map[string]any) ThesmsworksEntity

var NewOneTimePasswordEntityFunc func(client *ThesmsworksSDK, entopts map[string]any) ThesmsworksEntity

var NewScheduleEntityFunc func(client *ThesmsworksSDK, entopts map[string]any) ThesmsworksEntity

var NewSwaggerEntityFunc func(client *ThesmsworksSDK, entopts map[string]any) ThesmsworksEntity

var NewUtilEntityFunc func(client *ThesmsworksSDK, entopts map[string]any) ThesmsworksEntity

