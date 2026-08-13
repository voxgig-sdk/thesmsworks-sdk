// Generated basic-flow test for the swagger entity (model-driven;
// mirrors the go TestEntity generator).

#![allow(unused_variables, unused_mut, unused_imports)]

mod common;

use std::rc::Rc;

use common::*;

use thesmsworks_sdk::core::helpers::{getp, getpath, ja, jo, now_ms, setp, to_map};
use thesmsworks_sdk::utility::voxgigstruct as vs;
use thesmsworks_sdk::{test_sdk, Entity, ThesmsworksEntity, ThesmsworksSDK, Value};

#[test]
fn swagger_entity_instance() {
    let testsdk = test_sdk(Value::Noval, Value::Noval);
    let ent = testsdk.swagger(Value::Noval);
    assert_eq!(ent.get_name(), "swagger");
}

#[test]
fn swagger_entity_basic() {
    let setup = swagger_basic_setup(Value::Noval);
    // The basic flow consumes synthetic IDs from the fixture. In live mode
    // without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup.synthetic_only {
        eprintln!("skip: live entity test uses synthetic IDs from fixture — set THESMSWORKS_TEST_SWAGGER_ENTID JSON to run live");
        return;
    }

    // Bootstrap entity data from existing test data (no create step in flow).
    let swagger_ref01_data_raw = vs::items(&to_map(&getpath(&["existing", "swagger"], &setup.data)));
    let swagger_ref01_data = to_map(&vs::get_elem(
        &vs::get_elem(&swagger_ref01_data_raw, &Value::Num(0.0), Value::Noval),
        &Value::Num(1.0),
        Value::Noval,
    ));
}

fn swagger_basic_setup(extra: Value) -> EntityTestSetup {
    load_env_local();

    let mut entity_data_file = manifest_dir();
    entity_data_file.push("..");
    entity_data_file.push(".sdk");
    entity_data_file.push("test");
    entity_data_file.push("entity");
    entity_data_file.push("swagger");
    entity_data_file.push("SwaggerTestData.json");

    let entity_data = read_json(&entity_data_file);

    let options = jo(vec![("entity", getp(&entity_data, "existing"))]);

    let client = test_sdk(options, extra.clone());

    // Generate idmap via transform, matching the TS pattern.
    let idmap = vs::transform(
        &ja(vec![Value::str("swagger01"), Value::str("swagger02"), Value::str("swagger03")]),
        &jo(vec![(
            "`$PACK`",
            ja(vec![
                Value::str(""),
                jo(vec![
                    ("`$KEY`", Value::str("`$COPY`")),
                    (
                        "`$VAL`",
                        ja(vec![
                            Value::str("`$FORMAT`"),
                            Value::str("upper"),
                            Value::str("`$COPY`"),
                        ]),
                    ),
                ]),
            ]),
        )]),
        None,
    )
    .unwrap_or_else(|_| Value::empty_map());

    // Detect ENTID env override before env_override consumes it. When live
    // mode is on without a real override, the basic test runs against
    // synthetic IDs from the fixture and 4xx's.
    let entid_env_raw = std::env::var("THESMSWORKS_TEST_SWAGGER_ENTID").unwrap_or_default();
    let idmap_overridden =
        !entid_env_raw.trim().is_empty() && entid_env_raw.trim().starts_with('{');

    let env = env_override(jo(vec![
        ("THESMSWORKS_TEST_SWAGGER_ENTID", idmap.clone()),
        ("THESMSWORKS_TEST_LIVE", Value::str("FALSE")),
        ("THESMSWORKS_TEST_EXPLAIN", Value::str("FALSE")),
        ("THESMSWORKS_APIKEY", Value::str("NONE")),
    ]));

    let idmap_resolved = match to_map(&getp(&env, "THESMSWORKS_TEST_SWAGGER_ENTID")) {
        Value::Map(m) => Value::Map(m),
        _ => to_map(&idmap),
    };

    let live = getp(&env, "THESMSWORKS_TEST_LIVE") == Value::str("TRUE");

    let client = if live {
        let merged = vs::merge(
            &ja(vec![jo(vec![("apikey", getp(&env, "THESMSWORKS_APIKEY"))]), extra]),
            None,
        );
        ThesmsworksSDK::new(to_map(&merged))
    } else {
        client
    };

    EntityTestSetup {
        client,
        data: entity_data,
        idmap: idmap_resolved,
        env: env.clone(),
        explain: getp(&env, "THESMSWORKS_TEST_EXPLAIN") == Value::str("TRUE"),
        live,
        synthetic_only: live && !idmap_overridden,
        now: now_ms(),
    }
}
