<?php
declare(strict_types=1);

// OneTimePassword entity test

require_once __DIR__ . '/../thesmsworks_sdk.php';
require_once __DIR__ . '/Runner.php';

use PHPUnit\Framework\TestCase;
use Voxgig\Struct\Struct as Vs;

class OneTimePasswordEntityTest extends TestCase
{
    public function test_create_instance(): void
    {
        $testsdk = ThesmsworksSDK::test(null, null);
        $ent = $testsdk->OneTimePassword(null);
        $this->assertNotNull($ent);
    }

    public function test_basic_flow(): void
    {
        $setup = one_time_password_basic_setup(null);
        // Per-op sdk-test-control.json skip.
        $_live = !empty($setup["live"]);
        foreach (["create", "load"] as $_op) {
            [$_shouldSkip, $_reason] = Runner::is_control_skipped("entityOp", "one_time_password." . $_op, $_live ? "live" : "unit");
            if ($_shouldSkip) {
                $this->markTestSkipped($_reason ?? "skipped via sdk-test-control.json");
                return;
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live mode
        // without an *_ENTID env override, those IDs hit the live API and 4xx.
        if (!empty($setup["synthetic_only"])) {
            $this->markTestSkipped("live entity test uses synthetic IDs from fixture — set THESMSWORKS_TEST_ONE_TIME_PASSWORD_ENTID JSON to run live");
            return;
        }
        $client = $setup["client"];

        // CREATE
        $one_time_password_ref01_ent = $client->OneTimePassword(null);
        $one_time_password_ref01_data = Helpers::to_map(Vs::getprop(
            Vs::getpath($setup["data"], "new.one_time_password"), "one_time_password_ref01"));

        $one_time_password_ref01_data_result = $one_time_password_ref01_ent->create($one_time_password_ref01_data, null);
        $one_time_password_ref01_data = Helpers::to_map($one_time_password_ref01_data_result);
        $this->assertNotNull($one_time_password_ref01_data);

        // LOAD
        $one_time_password_ref01_match_dt0 = [];
        $one_time_password_ref01_data_dt0_loaded = $one_time_password_ref01_ent->load($one_time_password_ref01_match_dt0, null);
        $this->assertNotNull($one_time_password_ref01_data_dt0_loaded);

    }
}

function one_time_password_basic_setup($extra)
{
    Runner::load_env_local();

    $entity_data_file = __DIR__ . '/../../.sdk/test/entity/one_time_password/OneTimePasswordTestData.json';
    $entity_data_source = file_get_contents($entity_data_file);
    $entity_data = json_decode($entity_data_source, true);

    $options = [];
    $options["entity"] = $entity_data["existing"];

    $client = ThesmsworksSDK::test($options, $extra);

    // Generate idmap.
    $idmap = [];
    foreach (["one_time_password01", "one_time_password02", "one_time_password03", "otp01", "otp02", "otp03"] as $k) {
        $idmap[$k] = strtoupper($k);
    }

    // Detect ENTID env override before envOverride consumes it. When live
    // mode is on without a real override, the basic test runs against synthetic
    // IDs from the fixture and 4xx's. Surface this so the test can skip.
    $entid_env_raw = getenv("THESMSWORKS_TEST_ONE_TIME_PASSWORD_ENTID");
    $idmap_overridden = $entid_env_raw !== false && str_starts_with(trim($entid_env_raw), "{");

    $env = Runner::env_override([
        "THESMSWORKS_TEST_ONE_TIME_PASSWORD_ENTID" => $idmap,
        "THESMSWORKS_TEST_LIVE" => "FALSE",
        "THESMSWORKS_TEST_EXPLAIN" => "FALSE",
        "THESMSWORKS_APIKEY" => "NONE",
    ]);

    $idmap_resolved = Helpers::to_map(
        $env["THESMSWORKS_TEST_ONE_TIME_PASSWORD_ENTID"]);
    if ($idmap_resolved === null) {
        $idmap_resolved = Helpers::to_map($idmap);
    }

    if ($env["THESMSWORKS_TEST_LIVE"] === "TRUE") {
        $merged_opts = Vs::merge([
            [
                "apikey" => $env["THESMSWORKS_APIKEY"],
            ],
            $extra ?? [],
        ]);
        $client = new ThesmsworksSDK(Helpers::to_map($merged_opts));
    }

    $live = $env["THESMSWORKS_TEST_LIVE"] === "TRUE";
    return [
        "client" => $client,
        "data" => $entity_data,
        "idmap" => $idmap_resolved,
        "env" => $env,
        "explain" => $env["THESMSWORKS_TEST_EXPLAIN"] === "TRUE",
        "live" => $live,
        "synthetic_only" => $live && !$idmap_overridden,
        "now" => (int)(microtime(true) * 1000),
    ];
}
