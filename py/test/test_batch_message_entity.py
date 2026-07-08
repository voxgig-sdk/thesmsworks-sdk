# BatchMessage entity test

import json
import os
import time

import pytest

from utility.voxgig_struct import voxgig_struct as vs
from thesmsworks_sdk import ThesmsworksSDK
from core import helpers

_TEST_DIR = os.path.dirname(os.path.abspath(__file__))
from test import runner


class TestBatchMessageEntity:

    def test_should_create_instance(self):
        testsdk = ThesmsworksSDK.test(None, None)
        ent = testsdk.BatchMessage(None)
        assert ent is not None

    def test_should_run_basic_flow(self):
        setup = _batch_message_basic_setup(None)
        # Per-op sdk-test-control.json skip — basic test exercises a flow with
        # multiple ops; skipping any one skips the whole flow (steps depend
        # on each other).
        _live = setup.get("live", False)
        for _op in ["create", "remove"]:
            _skip, _reason = runner.is_control_skipped("entityOp", "batch_message." + _op, "live" if _live else "unit")
            if _skip:
                pytest.skip(_reason or "skipped via sdk-test-control.json")
                return
        # The basic flow consumes synthetic IDs from the fixture. In live mode
        # without an *_ENTID env override, those IDs hit the live API and 4xx.
        if setup.get("synthetic_only"):
            pytest.skip("live entity test uses synthetic IDs from fixture — "
                        "set THESMSWORKS_TEST_BATCH_MESSAGE_ENTID JSON to run live")
        client = setup["client"]

        # CREATE
        batch_message_ref01_ent = client.BatchMessage(None)
        batch_message_ref01_data = helpers.to_map(vs.getprop(
            vs.getpath(setup["data"], "new.batch_message"), "batch_message_ref01"))

        batch_message_ref01_data = helpers.to_map(batch_message_ref01_ent.create(batch_message_ref01_data, None))
        assert batch_message_ref01_data is not None

        # REMOVE
        batch_message_ref01_match_rm0 = {
            "id": batch_message_ref01_data["id"],
        }
        batch_message_ref01_ent.remove(batch_message_ref01_match_rm0, None)



def _batch_message_basic_setup(extra):
    runner.load_env_local()

    entity_data_file = os.path.join(_TEST_DIR, "../../.sdk/test/entity/batch_message/BatchMessageTestData.json")
    with open(entity_data_file, "r") as f:
        entity_data_source = f.read()

    entity_data = json.loads(entity_data_source)

    options = {}
    options["entity"] = entity_data.get("existing")

    client = ThesmsworksSDK.test(options, extra)

    # Generate idmap via transform.
    idmap = vs.transform(
        ["batch_message01", "batch_message02", "batch_message03", "schedule01", "schedule02", "schedule03"],
        {
            "`$PACK`": ["", {
                "`$KEY`": "`$COPY`",
                "`$VAL`": ["`$FORMAT`", "upper", "`$COPY`"],
            }],
        }
    )

    # Detect ENTID env override before envOverride consumes it. When live
    # mode is on without a real override, the basic test runs against synthetic
    # IDs from the fixture and 4xx's. We surface this so the test can skip.
    _entid_env_raw = os.environ.get(
        "THESMSWORKS_TEST_BATCH_MESSAGE_ENTID")
    _idmap_overridden = _entid_env_raw is not None and _entid_env_raw.strip().startswith("{")

    env = runner.env_override({
        "THESMSWORKS_TEST_BATCH_MESSAGE_ENTID": idmap,
        "THESMSWORKS_TEST_LIVE": "FALSE",
        "THESMSWORKS_TEST_EXPLAIN": "FALSE",
        "THESMSWORKS_APIKEY": "NONE",
    })

    idmap_resolved = helpers.to_map(
        env.get("THESMSWORKS_TEST_BATCH_MESSAGE_ENTID"))
    if idmap_resolved is None:
        idmap_resolved = helpers.to_map(idmap)

    if env.get("THESMSWORKS_TEST_LIVE") == "TRUE":
        merged_opts = vs.merge([
            {
                "apikey": env.get("THESMSWORKS_APIKEY"),
            },
            extra or {},
        ])
        client = ThesmsworksSDK(helpers.to_map(merged_opts))

    _live = env.get("THESMSWORKS_TEST_LIVE") == "TRUE"
    return {
        "client": client,
        "data": entity_data,
        "idmap": idmap_resolved,
        "env": env,
        "explain": env.get("THESMSWORKS_TEST_EXPLAIN") == "TRUE",
        "live": _live,
        "synthetic_only": _live and not _idmap_overridden,
        "now": int(time.time() * 1000),
    }
