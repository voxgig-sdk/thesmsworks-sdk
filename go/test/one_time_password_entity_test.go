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

func TestOneTimePasswordEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.OneTimePassword(nil)
		if ent == nil {
			t.Fatal("expected non-nil OneTimePasswordEntity")
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := one_time_passwordBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"create", "load"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "one_time_password." + _op, _mode); _shouldSkip {
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
			t.Skip("live entity test uses synthetic IDs from fixture — set THESMSWORKS_TEST_ONE_TIME_PASSWORD_ENTID JSON to run live")
			return
		}
		client := setup.client

		// CREATE
		oneTimePasswordRef01Ent := client.OneTimePassword(nil)
		oneTimePasswordRef01Data := core.ToMapAny(vs.GetProp(
			vs.GetPath([]any{"new", "one_time_password"}, setup.data), "one_time_password_ref01"))

		oneTimePasswordRef01DataResult, err := oneTimePasswordRef01Ent.Create(oneTimePasswordRef01Data, nil)
		if err != nil {
			t.Fatalf("create failed: %v", err)
		}
		oneTimePasswordRef01Data = core.ToMapAny(oneTimePasswordRef01DataResult)
		if oneTimePasswordRef01Data == nil {
			t.Fatal("expected create result to be a map")
		}

		// LOAD
		oneTimePasswordRef01MatchDt0 := map[string]any{}
		oneTimePasswordRef01DataDt0Loaded, err := oneTimePasswordRef01Ent.Load(oneTimePasswordRef01MatchDt0, nil)
		if err != nil {
			t.Fatalf("load failed: %v", err)
		}
		if oneTimePasswordRef01DataDt0Loaded == nil {
			t.Fatal("expected load result to be non-nil")
		}

	})
}

func one_time_passwordBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "one_time_password", "OneTimePasswordTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read one_time_password test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse one_time_password test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"one_time_password01", "one_time_password02", "one_time_password03", "otp01", "otp02", "otp03"},
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
	entidEnvRaw := os.Getenv("THESMSWORKS_TEST_ONE_TIME_PASSWORD_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"THESMSWORKS_TEST_ONE_TIME_PASSWORD_ENTID": idmap,
		"THESMSWORKS_TEST_LIVE":      "FALSE",
		"THESMSWORKS_TEST_EXPLAIN":   "FALSE",
		"THESMSWORKS_APIKEY":         "NONE",
	})

	idmapResolved := core.ToMapAny(env["THESMSWORKS_TEST_ONE_TIME_PASSWORD_ENTID"])
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
