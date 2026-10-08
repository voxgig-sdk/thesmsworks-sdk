"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const node_path_1 = __importDefault(require("node:path"));
const Fs = __importStar(require("node:fs"));
const node_test_1 = require("node:test");
const node_assert_1 = __importDefault(require("node:assert"));
const live_runner_1 = require("../../live-runner");
const live_entity_1 = require("../../live-entity");
const __1 = require("../../..");
const utility_1 = require("../../utility");
(0, utility_1.loadEnvLocal)(__dirname + '/../../../.env.local');
(0, node_test_1.describe)('MessageScheduleEntity', async () => {
    // Per-test live pacing. Delay is read from sdk-test-control.json's
    // `test.live.delayMs`; only sleeps when THESMSWORKS_TEST_LIVE=TRUE.
    (0, node_test_1.afterEach)((0, utility_1.liveDelay)('THESMSWORKS_TEST_LIVE'));
    (0, node_test_1.test)('instance', async () => {
        const testsdk = __1.ThesmsworksSDK.test();
        const ent = testsdk.MessageSchedule();
        (0, node_assert_1.default)(null != ent);
    });
    (0, node_test_1.test)('validate', async (t) => {
        if (null == __1.config.feature?.validate) {
            t.skip('feature not present in this SDK: validate');
            return;
        }
        const client = __1.ThesmsworksSDK.test(undefined, { feature: { validate: { active: true } } });
        await node_assert_1.default.rejects(client.MessageSchedule().load({ "id": 1 }), (err) => 'validate_failed' === err.code);
    });
    (0, node_test_1.test)('basic', async (t) => {
        const live = 'TRUE' === process.env.THESMSWORKS_TEST_LIVE;
        for (const op of ['load']) {
            if (!live && (0, utility_1.maybeSkipControl)(t, 'entityOp', 'message_schedule.' + op, live))
                return;
        }
        const setup = basicSetup();
        if (setup.live) {
            return (0, live_entity_1.runLiveEntity)(setup, { "active": true, "alias": { "field": {} }, "fields": { "id": { "a": true, "h": "Id", "n": "id", "r": false, "t": "`$STRING`", "key$": "id", "index$": 0 } }, "id": { "field": "id", "name": "id" }, "name": "message_schedule", "op": { "load": { "input": "data", "name": "load", "points": [{ "a": true, "co": { "id": "GET /messages/schedule", "source": "openapi3", "version": 2 }, "g": {}, "k": "http", "m": "GET", "o": "/messages/schedule", "q": { "$action": "schedule" }, "r": {}, "rs": { "kind": "json", "media": "application/json;charset=UTF-8" }, "s": [{ "lit": "messages" }, { "lit": "schedule" }], "t": { "req": "`reqdata`", "res": "`body`" }, "index$": 0 }], "key$": "load" }, "remove": { "input": "data", "name": "remove", "points": [{ "a": true, "co": { "id": "DELETE /messages/schedule/{messageid}", "source": "openapi3", "version": 2 }, "g": { "params": [{ "a": true, "k": "param", "n": "id", "or": "messageid", "r": true, "t": "`$STRING`", "index$": 0 }] }, "k": "http", "m": "DELETE", "o": "/messages/schedule/{messageid}", "q": { "exist": ["id"] }, "r": { "param": { "messageid": "id" } }, "rs": { "kind": "json", "media": "application/json;charset=UTF-8" }, "s": [{ "lit": "messages" }, { "lit": "schedule" }, { "var": "id" }], "t": { "req": "`reqdata`", "res": "`body`" }, "index$": 0 }], "key$": "remove" } }, "relations": { "ancestors": [] }, "key$": "message_schedule", "name__orig": "message_schedule", "Name": "MessageSchedule", "name_": "message_schedule", "name-": "message-schedule", "NAME": "MESSAGE_SCHEDULE", "index$": 5 }, { "active": true, "entity": "message_schedule", "key$": "BasicMessageScheduleFlow", "kind": "basic", "name": "BasicMessageScheduleFlow", "param": {}, "step": [{ "a": true, "d": {}, "i": { "ref": "message_schedule_ref01", "srcdatavar": "message_schedule_ref01_data", "suffix": "_dt0" }, "m": {}, "o": "load", "s": [], "v": [{ "apply": "TextFieldMark", "def": { "mark": "Mark01-message_schedule_ref01" } }], "index$": 0 }] }, 'MessageSchedule', { "GET /messages/schedule": { "protocol": "http", "parameters": [] }, "DELETE /messages/schedule/{messageid}": { "protocol": "http", "parameters": [{ "description": "The ID of the message you would like returned", "explode": false, "in": "path", "name": "messageid", "required": true, "schema": { "type": "string" }, "style": "simple", "index$": 0 }] } }, { strict: LIVE_STRICT, t });
        }
        const client = setup.client;
        const struct = setup.struct;
        const isempty = struct.isempty;
        const select = struct.select;
        let message_schedule_ref01_data = Object.values(setup.data.existing.message_schedule)[0];
        // LOAD
        const message_schedule_ref01_ent = client.MessageSchedule();
        const message_schedule_ref01_match_dt0 = {};
        message_schedule_ref01_match_dt0.id = message_schedule_ref01_data.id;
        const message_schedule_ref01_data_dt0 = (await message_schedule_ref01_ent.load(message_schedule_ref01_match_dt0)).data();
        (0, node_assert_1.default)(message_schedule_ref01_data_dt0.id === message_schedule_ref01_data.id);
    });
});
// main.kit.test.live.strict is true (the default is true): a live
// request that fails, or a live test missing an input it needs,
// fails the test.
// An account with no record for a test to read skips it either way.
const LIVE_STRICT = true;
function basicSetup(extra) {
    // TODO: fix test def options
    const options = {}; // null
    // TODO: needs test utility to resolve path
    const entityDataFile = node_path_1.default.resolve(__dirname, '../../../../.sdk/test/entity/message_schedule/MessageScheduleTestData.json');
    // TODO: file ready util needed?
    const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8');
    // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
    const entityData = JSON.parse(entityDataSource);
    options.entity = entityData.existing;
    let client = __1.ThesmsworksSDK.test(options, extra);
    const struct = client.utility().struct;
    const merge = struct.merge;
    const transform = struct.transform;
    let idmap = transform(['message_schedule01', 'message_schedule02', 'message_schedule03'], {
        '`$PACK`': ['', {
                '`$KEY`': '`$COPY`',
                '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
            }]
    });
    const env = (0, utility_1.envOverride)({
        'THESMSWORKS_TEST_MESSAGE_SCHEDULE_ENTID': idmap,
        'THESMSWORKS_TEST_LIVE': 'FALSE',
        'THESMSWORKS_TEST_EXPLAIN': 'FALSE',
        'THESMSWORKS_APIKEY': '',
    });
    idmap = env['THESMSWORKS_TEST_MESSAGE_SCHEDULE_ENTID'];
    const live = 'TRUE' === env.THESMSWORKS_TEST_LIVE;
    const transport = (0, live_runner_1.createLiveTransport)();
    if (live) {
        const rawIds = process.env['THESMSWORKS_TEST_MESSAGE_SCHEDULE_ENTID'];
        idmap = rawIds && rawIds.trim() ? JSON.parse(rawIds) : {};
        if (!idmap || Array.isArray(idmap) || typeof idmap !== 'object') {
            throw new Error('Live ENTID must be a JSON object');
        }
        client = new __1.ThesmsworksSDK(merge([
            // FIRST, so the generated fields below win: sdk-test-control.json's
            // test.client.options adds to the live client, it does not redirect it.
            (0, utility_1.liveClientOptions)(),
            {
                apikey: env.THESMSWORKS_APIKEY,
            },
            // 'extra || {}', not a bare 'extra': struct.merge returns UNDEFINED when the
            // last entry is undefined, and basicSetup is normally called with no
            // argument at all - so a bare 'extra' silently discarded the apikey
            // and server values above and handed the SDK undefined. Harmless
            // while there was nothing in that object; not harmless now.
            extra || {},
            { system: { fetch: transport.fetch } }
        ]));
    }
    const setup = {
        idmap,
        env,
        options,
        client,
        struct,
        data: entityData,
        explain: 'TRUE' === env.THESMSWORKS_TEST_EXPLAIN,
        live,
        transport,
        now: Date.now(),
    };
    return setup;
}
//# sourceMappingURL=MessageScheduleEntity.test.js.map