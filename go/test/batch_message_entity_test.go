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

func TestBatchMessageEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.BatchMessage(nil)
		if ent == nil {
			t.Fatal("expected non-nil BatchMessageEntity")
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := batch_messageBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"create", "remove"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "batch_message." + _op, _mode); _shouldSkip {
				if _reason == "" {
					_reason = "skipped via sdk-test-control.json"
				}
				t.Skip(_reason)
				return
			}
		}
		// The basic flow consumes synthetic IDs from the fixture. In live mode
		// without an *_ENTID env override, those IDs hit the live API and 4xx.
		if setup.syntheticOnly {
			t.Skip("live entity test uses synthetic IDs from fixture — set THESMSWORKS_TEST_BATCH_MESSAGE_ENTID JSON to run live")
			return
		}
		client := setup.client

		// CREATE
		batchMessageRef01Ent := client.BatchMessage(nil)
		batchMessageRef01Data := core.ToMapAny(vs.GetProp(
			vs.GetPath([]any{"new", "batch_message"}, setup.data), "batch_message_ref01"))

		batchMessageRef01DataResult, err := batchMessageRef01Ent.Create(batchMessageRef01Data, nil)
		if err != nil {
			t.Fatalf("create failed: %v", err)
		}
		batchMessageRef01Data = core.ToMapAny(batchMessageRef01DataResult)
		if batchMessageRef01Data == nil {
			t.Fatal("expected create result to be a map")
		}

		// REMOVE
		batchMessageRef01MatchRm0 := map[string]any{
			"id": batchMessageRef01Data["id"],
		}
		_, err = batchMessageRef01Ent.Remove(batchMessageRef01MatchRm0, nil)
		if err != nil {
			t.Fatalf("remove failed: %v", err)
		}

	})
}

func batch_messageBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "batch_message", "BatchMessageTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read batch_message test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse batch_message test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"batch_message01", "batch_message02", "batch_message03", "schedule01", "schedule02", "schedule03"},
		map[string]any{
			"`$PACK`": []any{"", map[string]any{
				"`$KEY`": "`$COPY`",
				"`$VAL`": []any{"`$FORMAT`", "upper", "`$COPY`"},
			}},
		},
	)

	// Detect ENTID env override before envOverride consumes it. When live
	// mode is on without a real override, the basic test runs against synthetic
	// IDs from the fixture and 4xx's. Surface this so the test can skip.
	entidEnvRaw := os.Getenv("THESMSWORKS_TEST_BATCH_MESSAGE_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"THESMSWORKS_TEST_BATCH_MESSAGE_ENTID": idmap,
		"THESMSWORKS_TEST_LIVE":      "FALSE",
		"THESMSWORKS_TEST_EXPLAIN":   "FALSE",
		"THESMSWORKS_APIKEY":         "NONE",
	})

	idmapResolved := core.ToMapAny(env["THESMSWORKS_TEST_BATCH_MESSAGE_ENTID"])
	if idmapResolved == nil {
		idmapResolved = core.ToMapAny(idmap)
	}

	if env["THESMSWORKS_TEST_LIVE"] == "TRUE" {
		mergedOpts := vs.Merge([]any{
			map[string]any{
				"apikey": env["THESMSWORKS_APIKEY"],
			},
			extra,
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
