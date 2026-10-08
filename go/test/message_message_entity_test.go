package sdktest

import (
	"encoding/json"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"testing"
	"time"

	sdk "github.com/voxgig-sdk/thesmsworks-sdk/go"
	"github.com/voxgig-sdk/thesmsworks-sdk/go/core"

	vs "github.com/voxgig-sdk/thesmsworks-sdk/go/utility/struct"
)

// main.kit.test.live.strict is true (the default is true): a live
// request that fails, or a live test missing an input it needs,
// fails the test.
// An account with no record for a test to read skips it either way.
const message_messageEntityLiveStrict = true


func TestMessageMessageEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.MessageMessage(nil)
		if ent == nil {
			t.Fatal("expected non-nil MessageMessageEntity")
		}
	})

	t.Run("validate", func(t *testing.T) {
		if !fhHasFeature("validate") {
			t.Skip("feature not present in this SDK: validate")
		}
		client := sdk.TestSDK(nil, map[string]any{
			"feature": map[string]any{"validate": map[string]any{"active": true}},
		})
		_, err := client.MessageMessage(nil).Load(map[string]any{"id": 1}, nil)
		if sdkerr, ok := err.(*core.ThesmsworksError); !ok || "validate_failed" != sdkerr.Code {
			t.Fatalf("expected validate_failed, got %v", err)
		}
	})

	t.Run("basic", func(tt *testing.T) {
		var t testing.TB = tt
		setup := message_messageBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"create", "load", "remove"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "message_message." + _op, _mode); _shouldSkip {
				if _reason == "" {
					_reason = "skipped via sdk-test-control.json"
				}
				t.Skip(_reason)
				return
			}
		}
		client := setup.client

		// CREATE
		messageMessageRef01Ent := client.MessageMessage(nil)
		messageMessageRef01Data := core.ToMapAny(vs.GetProp(
			vs.GetPath(setup.data, []any{"new", "message_message"}), "message_message_ref01"))

		messageMessageRef01DataResult, err := messageMessageRef01Ent.Create(messageMessageRef01Data, nil)
		if err != nil {
			t.Fatalf("create failed: %v", err)
		}
		messageMessageRef01Data = core.ToMapAny(entityData(messageMessageRef01DataResult))
		if messageMessageRef01Data == nil {
			t.Fatal("expected create result to be a map")
		}
		if messageMessageRef01Data["id"] == nil {
			t.Fatal("expected created entity to have an id")
		}

		// LOAD
		messageMessageRef01MatchDt0 := map[string]any{
			"id": messageMessageRef01Data["id"],
		}
		messageMessageRef01DataDt0Loaded, err := messageMessageRef01Ent.Load(messageMessageRef01MatchDt0, nil)
		if err != nil {
			t.Fatalf("load failed: %v", err)
		}
		messageMessageRef01DataDt0LoadResult := core.ToMapAny(entityData(messageMessageRef01DataDt0Loaded))
		if messageMessageRef01DataDt0LoadResult == nil {
			t.Fatal("expected load result to be a map")
		}
		if messageMessageRef01DataDt0LoadResult["id"] != messageMessageRef01Data["id"] {
			t.Fatal("expected load result id to match")
		}

		// REMOVE
		messageMessageRef01MatchRm0 := map[string]any{
			"id": messageMessageRef01Data["id"],
		}
		_, err = messageMessageRef01Ent.Remove(messageMessageRef01MatchRm0, nil)
		if err != nil {
			t.Fatalf("remove failed: %v", err)
		}

	})
}

func message_messageBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "message_message", "MessageMessageTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read message_message test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse message_message test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap, _ := vs.Transform(
		[]any{"message_message01", "message_message02", "message_message03"},
		map[string]any{
			"`$PACK`": []any{"", map[string]any{
				"`$KEY`": "`$COPY`",
				"`$VAL`": []any{"`$FORMAT`", "upper", "`$COPY`"},
			}},
		},
	)

	// Whether *_ENTID supplied the idmap, read before envOverride consumes it:
	// without it, the ids a live flow binds are the fixture's synthetic ones.
	entidEnvRaw := os.Getenv("THESMSWORKS_TEST_MESSAGE_MESSAGE_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"THESMSWORKS_TEST_MESSAGE_MESSAGE_ENTID": idmap,
		"THESMSWORKS_TEST_LIVE":      "FALSE",
		"THESMSWORKS_TEST_EXPLAIN":   "FALSE",
		"THESMSWORKS_APIKEY":         "",
	})

	idmapResolved := core.ToMapAny(env["THESMSWORKS_TEST_MESSAGE_MESSAGE_ENTID"])
	if idmapResolved == nil {
		idmapResolved = core.ToMapAny(idmap)
	}

	if env["THESMSWORKS_TEST_LIVE"] == "TRUE" {
		// An empty map, not a nil one: Merge returns nil when its last entry
		// is nil, and BasicSetup is normally called with no extras - so a
		// bare nil silently discarded the apikey and server values below.
		extraOpts := extra
		if extraOpts == nil {
			extraOpts = map[string]any{}
		}

		mergedOpts := vs.Merge([]any{
			// liveClientOptions() FIRST, so the generated fields below win:
			// sdk-test-control.json's test.client.options adds to the live
			// client, it does not redirect it.
			liveClientOptions(),
			map[string]any{
				"apikey": env["THESMSWORKS_APIKEY"],
			},
			extraOpts,
		})
		client = sdk.NewThesmsworksSDK(core.ToMapAny(mergedOpts))
	}

	live := env["THESMSWORKS_TEST_LIVE"] == "TRUE"
	return &entityTestSetup{
		client:        client,
		data:          entityData,
		idmap:         idmapResolved,
		env:           env,
		explain:       env["THESMSWORKS_TEST_EXPLAIN"] == "TRUE",
		live:          live,
		syntheticOnly: live && !idmapOverridden,
		now:           time.Now().UnixMilli(),
	}
}
