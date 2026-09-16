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
// AFTER the imports on purpose: TypeScript hoists `import` above any
// statement in the emitted CommonJS, so a loader placed above them would
// run only after every imported module had already been evaluated - and
// anything reading process.env at module scope would miss these values.
(0, utility_1.loadEnvLocal)(__dirname + '/../../../.env.local');
(0, node_test_1.describe)('BatchMessageEntity', async () => {
    // Per-test live pacing. Delay is read from sdk-test-control.json's
    // `test.live.delayMs`; only sleeps when THESMSWORKS_TEST_LIVE=TRUE.
    (0, node_test_1.afterEach)((0, utility_1.liveDelay)('THESMSWORKS_TEST_LIVE'));
    (0, node_test_1.test)('instance', async () => {
        const testsdk = __1.ThesmsworksSDK.test();
        const ent = testsdk.BatchMessage();
        (0, node_assert_1.default)(null != ent);
    });
    (0, node_test_1.test)('basic', async (t) => {
        const live = 'TRUE' === process.env.THESMSWORKS_TEST_LIVE;
        for (const op of ['create', 'remove']) {
            if (!live && (0, utility_1.maybeSkipControl)(t, 'entityOp', 'batch_message.' + op, live))
                return;
        }
        const setup = basicSetup();
        if (setup.live) {
            return (0, live_entity_1.runLiveEntity)(setup, { "active": true, "alias": { "field": {} }, "fields": [{ "active": true, "name": "ai", "req": false, "short": "Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary.", "type": "`$BOOLEAN`", "index$": 0 }, { "active": true, "name": "content", "req": true, "short": "Message to send to the recipient", "type": "`$STRING`", "index$": 1 }, { "active": true, "name": "deliveryreporturl", "req": false, "short": "The url to which we should POST delivery reports to for this message.", "type": "`$STRING`", "index$": 2 }, { "active": true, "name": "destinations", "req": true, "short": "Telephone numbers of each of the recipients", "type": "`$ARRAY`", "index$": 3 }, { "active": true, "name": "schedule", "req": false, "short": "Date-time at which to send the batch.", "type": "`$STRING`", "index$": 4 }, { "active": true, "name": "sender", "req": true, "short": "The sender of the message.", "type": "`$STRING`", "index$": 5 }, { "active": true, "name": "tag", "req": false, "short": "An identifying label for the message, which you can use to filter and report on messages you've sent later.", "type": "`$STRING`", "index$": 6 }, { "active": true, "name": "ttl", "req": false, "short": "The number of minutes before the delivery report is deleted.", "type": "`$NUMBER`", "index$": 7 }, { "active": true, "name": "validity", "req": false, "short": "The optional number of minutes to attempt delivery before the message is marked as EXPIRED.", "type": "`$NUMBER`", "index$": 8 }], "name": "batch_message", "op": { "create": { "input": "data", "name": "create", "points": [{ "active": true, "args": {}, "contract": { "id": "POST /batch/any", "json": "{\"parameters\":[],\"protocol\":\"http\",\"requestBody\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"An array of Messages\",\"type\":\"object\"}}},\"description\":\"An array of messages\",\"required\":true},\"responses\":{\"201\":{\"content\":{\"application/json;charset=UTF-8\":{\"schema\":{\"example\":{\"batchid\":\"2586749\",\"status\":\"SCHEDULED\"},\"properties\":{\"batchid\":{\"example\":\"2586749\",\"type\":\"string\"},\"status\":{\"example\":\"SCHEDULED\",\"type\":\"string\"}},\"required\":[\"batchid\",\"status\"],\"type\":\"object\"}}},\"description\":\"Success\"},\"402\":{\"content\":{\"application/json;charset=UTF-8\":{\"schema\":{\"allOf\":[{\"properties\":{\"message\":{\"type\":\"string\"}},\"required\":[\"message\"],\"type\":\"object\"},{\"properties\":{\"errorCode\":{\"description\":\"Numeric code used to identify the error. Integer.\",\"type\":\"number\"},\"permanent\":{\"type\":\"boolean\"},\"status\":{\"type\":\"string\"}},\"required\":[\"errorCode\",\"status\"],\"type\":\"object\"}]}}},\"description\":\"Error\"},\"default\":{\"content\":{\"application/json;charset=UTF-8\":{\"schema\":{\"allOf\":[{\"properties\":{\"message\":{\"type\":\"string\"}},\"required\":[\"message\"],\"type\":\"object\"},{\"properties\":{\"errorCode\":{\"description\":\"Numeric code used to identify the error. Integer.\",\"type\":\"number\"},\"permanent\":{\"type\":\"boolean\"},\"status\":{\"type\":\"string\"}},\"required\":[\"errorCode\",\"status\"],\"type\":\"object\"}]}}},\"description\":\"Error\"}},\"security\":[{\"JWT\":[]}],\"securitySchemes\":{\"JWT\":{\"in\":\"header\",\"name\":\"Authorization\",\"type\":\"apiKey\"}},\"securitySource\":\"operation\"}", "source": "openapi3", "version": 1 }, "kind": "http", "method": "POST", "orig": "/batch/any", "segments": [{ "lit": "batch" }, { "lit": "any" }], "select": {}, "transform": { "req": "`reqdata`", "res": "`body`" }, "index$": 0 }, { "active": true, "args": {}, "contract": { "id": "POST /batch/schedule", "json": "{\"parameters\":[],\"protocol\":\"http\",\"requestBody\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"SMS Message Batch\",\"example\":{\"ai\":true,\"content\":\"My super awesome batch message\",\"deliveryreporturl\":\"http://your.domain.com/delivery/report/path\",\"destinations\":[\"447777777777\",\"447777777778\",\"447777777779\"],\"schedule\":\"Wed Jul 19 2017 20:26:28 GMT+0100 (BST)\",\"sender\":\"YourCompany\",\"tag\":\"SummerSpecial\",\"ttl\":10,\"validity\":1440},\"properties\":{\"ai\":{\"description\":\"Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. This setting overrides the AI Optimiser configuration on your SMS Works account.\",\"type\":\"boolean\"},\"content\":{\"description\":\"Message to send to the recipient\",\"example\":\"My super awesome batch message\",\"type\":\"string\"},\"deliveryreporturl\":{\"description\":\"The url to which we should POST delivery reports to for this message. If none is specified, we'll use the global delivery report URL that you've configured on your account page.\",\"example\":\"http://your.domain.com/delivery/report/path\",\"type\":\"string\"},\"destinations\":{\"description\":\"Telephone numbers of each of the recipients\",\"example\":[\"447777777777\",\"447777777778\",\"447777777779\"],\"items\":{\"type\":\"string\"},\"type\":\"array\"},\"schedule\":{\"description\":\"Date-time at which to send the batch. This is only used by the batch/schedule service.\",\"example\":\"Wed Jul 19 2017 20:26:28 GMT+0100 (BST)\",\"type\":\"string\"},\"sender\":{\"description\":\"The sender of the message. Should be no longer than 11 characters for alphanumeric or 15 characters for numeric sender ID's. No spaces or special characters.\",\"example\":\"YourCompany\",\"type\":\"string\"},\"tag\":{\"description\":\"An identifying label for the message, which you can use to filter and report on messages you've sent later. Ideal for campaigns. A maximum of 280 characters.\",\"example\":\"SummerSpecial\",\"type\":\"string\"},\"ttl\":{\"description\":\"The number of minutes before the delivery report is deleted. Optional. Omit to prevent delivery report deletion. Integer.\",\"example\":10,\"type\":\"number\"},\"validity\":{\"description\":\"The optional number of minutes to attempt delivery before the message is marked as EXPIRED. Optional. The default is 2880 minutes. Integer.\",\"example\":1440,\"maximum\":2880,\"minimum\":1,\"type\":\"number\"}},\"required\":[\"content\",\"destinations\",\"sender\"],\"type\":\"object\"}}},\"description\":\"Message properties\",\"required\":true},\"responses\":{\"201\":{\"content\":{\"application/json;charset=UTF-8\":{\"schema\":{\"example\":{\"batchid\":\"3200562\",\"status\":\"SCHEDULED\"},\"properties\":{\"batchid\":{\"example\":\"3200562\",\"type\":\"string\"},\"status\":{\"example\":\"SCHEDULED\",\"type\":\"string\"}},\"required\":[\"batchid\",\"status\"],\"type\":\"object\"}}},\"description\":\"Success\"},\"402\":{\"content\":{\"application/json;charset=UTF-8\":{\"schema\":{\"allOf\":[{\"properties\":{\"message\":{\"type\":\"string\"}},\"required\":[\"message\"],\"type\":\"object\"},{\"properties\":{\"errorCode\":{\"description\":\"Numeric code used to identify the error. Integer.\",\"type\":\"number\"},\"permanent\":{\"type\":\"boolean\"},\"status\":{\"type\":\"string\"}},\"required\":[\"errorCode\",\"status\"],\"type\":\"object\"}]}}},\"description\":\"Error\"},\"default\":{\"content\":{\"application/json;charset=UTF-8\":{\"schema\":{\"allOf\":[{\"properties\":{\"message\":{\"type\":\"string\"}},\"required\":[\"message\"],\"type\":\"object\"},{\"properties\":{\"errorCode\":{\"description\":\"Numeric code used to identify the error. Integer.\",\"type\":\"number\"},\"permanent\":{\"type\":\"boolean\"},\"status\":{\"type\":\"string\"}},\"required\":[\"errorCode\",\"status\"],\"type\":\"object\"}]}}},\"description\":\"Error\"}},\"security\":[{\"JWT\":[]}],\"securitySchemes\":{\"JWT\":{\"in\":\"header\",\"name\":\"Authorization\",\"type\":\"apiKey\"}},\"securitySource\":\"operation\"}", "source": "openapi3", "version": 1 }, "kind": "http", "method": "POST", "orig": "/batch/schedule", "segments": [{ "lit": "batch" }, { "lit": "schedule" }], "select": {}, "transform": { "req": "`reqdata`", "res": "`body`" }, "index$": 1 }, { "active": true, "args": {}, "contract": { "id": "POST /batch/send", "json": "{\"parameters\":[],\"protocol\":\"http\",\"requestBody\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"SMS Message Batch\",\"example\":{\"ai\":true,\"content\":\"My super awesome batch message\",\"deliveryreporturl\":\"http://your.domain.com/delivery/report/path\",\"destinations\":[\"447777777777\",\"447777777778\",\"447777777779\"],\"schedule\":\"Wed Jul 19 2017 20:26:28 GMT+0100 (BST)\",\"sender\":\"YourCompany\",\"tag\":\"SummerSpecial\",\"ttl\":10,\"validity\":1440},\"properties\":{\"ai\":{\"description\":\"Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. This setting overrides the AI Optimiser configuration on your SMS Works account.\",\"type\":\"boolean\"},\"content\":{\"description\":\"Message to send to the recipient\",\"example\":\"My super awesome batch message\",\"type\":\"string\"},\"deliveryreporturl\":{\"description\":\"The url to which we should POST delivery reports to for this message. If none is specified, we'll use the global delivery report URL that you've configured on your account page.\",\"example\":\"http://your.domain.com/delivery/report/path\",\"type\":\"string\"},\"destinations\":{\"description\":\"Telephone numbers of each of the recipients\",\"example\":[\"447777777777\",\"447777777778\",\"447777777779\"],\"items\":{\"type\":\"string\"},\"type\":\"array\"},\"schedule\":{\"description\":\"Date-time at which to send the batch. This is only used by the batch/schedule service.\",\"example\":\"Wed Jul 19 2017 20:26:28 GMT+0100 (BST)\",\"type\":\"string\"},\"sender\":{\"description\":\"The sender of the message. Should be no longer than 11 characters for alphanumeric or 15 characters for numeric sender ID's. No spaces or special characters.\",\"example\":\"YourCompany\",\"type\":\"string\"},\"tag\":{\"description\":\"An identifying label for the message, which you can use to filter and report on messages you've sent later. Ideal for campaigns. A maximum of 280 characters.\",\"example\":\"SummerSpecial\",\"type\":\"string\"},\"ttl\":{\"description\":\"The number of minutes before the delivery report is deleted. Optional. Omit to prevent delivery report deletion. Integer.\",\"example\":10,\"type\":\"number\"},\"validity\":{\"description\":\"The optional number of minutes to attempt delivery before the message is marked as EXPIRED. Optional. The default is 2880 minutes. Integer.\",\"example\":1440,\"maximum\":2880,\"minimum\":1,\"type\":\"number\"}},\"required\":[\"content\",\"destinations\",\"sender\"],\"type\":\"object\"}}},\"description\":\"Message properties\",\"required\":true},\"responses\":{\"201\":{\"content\":{\"application/json;charset=UTF-8\":{\"schema\":{\"example\":{\"batchid\":\"2586749\",\"status\":\"SCHEDULED\"},\"properties\":{\"batchid\":{\"example\":\"2586749\",\"type\":\"string\"},\"status\":{\"example\":\"SCHEDULED\",\"type\":\"string\"}},\"required\":[\"batchid\",\"status\"],\"type\":\"object\"}}},\"description\":\"Success\"},\"402\":{\"content\":{\"application/json;charset=UTF-8\":{\"schema\":{\"allOf\":[{\"properties\":{\"message\":{\"type\":\"string\"}},\"required\":[\"message\"],\"type\":\"object\"},{\"properties\":{\"errorCode\":{\"description\":\"Numeric code used to identify the error. Integer.\",\"type\":\"number\"},\"permanent\":{\"type\":\"boolean\"},\"status\":{\"type\":\"string\"}},\"required\":[\"errorCode\",\"status\"],\"type\":\"object\"}]}}},\"description\":\"Error\"},\"default\":{\"content\":{\"application/json;charset=UTF-8\":{\"schema\":{\"allOf\":[{\"properties\":{\"message\":{\"type\":\"string\"}},\"required\":[\"message\"],\"type\":\"object\"},{\"properties\":{\"errorCode\":{\"description\":\"Numeric code used to identify the error. Integer.\",\"type\":\"number\"},\"permanent\":{\"type\":\"boolean\"},\"status\":{\"type\":\"string\"}},\"required\":[\"errorCode\",\"status\"],\"type\":\"object\"}]}}},\"description\":\"Error\"}},\"security\":[{\"JWT\":[]}],\"securitySchemes\":{\"JWT\":{\"in\":\"header\",\"name\":\"Authorization\",\"type\":\"apiKey\"}},\"securitySource\":\"operation\"}", "source": "openapi3", "version": 1 }, "kind": "http", "method": "POST", "orig": "/batch/send", "segments": [{ "lit": "batch" }, { "lit": "send" }], "select": {}, "transform": { "req": "`reqdata`", "res": "`body`" }, "index$": 2 }], "key$": "create" }, "remove": { "input": "data", "name": "remove", "points": [{ "active": true, "args": { "params": [{ "active": true, "kind": "param", "name": "batchid", "orig": "batchid", "reqd": true, "type": "`$STRING`", "index$": 0 }] }, "contract": { "id": "DELETE /batches/schedule/{batchid}", "json": "{\"parameters\":[{\"description\":\"The ID of the batch you would like returned\",\"explode\":false,\"in\":\"path\",\"name\":\"batchid\",\"required\":true,\"schema\":{\"type\":\"string\"},\"style\":\"simple\"}],\"protocol\":\"http\",\"responses\":{\"200\":{\"content\":{\"application/json;charset=UTF-8\":{\"schema\":{\"example\":{\"messageid\":\"5620320\",\"status\":\"CANCELLED\"},\"properties\":{\"messageid\":{\"example\":\"5620320\",\"type\":\"string\"},\"status\":{\"example\":\"CANCELLED\",\"type\":\"string\"}},\"required\":[\"messageid\",\"status\"],\"type\":\"object\"}}},\"description\":\"Success\"},\"default\":{\"content\":{\"application/json;charset=UTF-8\":{\"schema\":{\"allOf\":[{\"properties\":{\"message\":{\"type\":\"string\"}},\"required\":[\"message\"],\"type\":\"object\"},{\"properties\":{\"errorCode\":{\"description\":\"Numeric code used to identify the error. Integer.\",\"type\":\"number\"},\"permanent\":{\"type\":\"boolean\"},\"status\":{\"type\":\"string\"}},\"required\":[\"errorCode\",\"status\"],\"type\":\"object\"}]}}},\"description\":\"Error\"}},\"security\":[{\"JWT\":[]}],\"securitySchemes\":{\"JWT\":{\"in\":\"header\",\"name\":\"Authorization\",\"type\":\"apiKey\"}},\"securitySource\":\"operation\"}", "source": "openapi3", "version": 1 }, "kind": "http", "method": "DELETE", "orig": "/batches/schedule/{batchid}", "segments": [{ "lit": "batches" }, { "lit": "schedule" }, { "var": "batchid" }], "select": { "exist": ["batchid"] }, "transform": { "req": "`reqdata`", "res": "`body`" }, "index$": 0 }], "key$": "remove" } }, "relations": { "ancestors": [["schedule"]] }, "key$": "batch_message", "name__orig": "batch_message", "Name": "BatchMessage", "name_": "batch_message", "name-": "batch-message", "NAME": "BATCH_MESSAGE", "index$": 1 }, { "active": true, "entity": "batch_message", "key$": "BasicBatchMessageFlow", "kind": "basic", "name": "BasicBatchMessageFlow", "param": {}, "step": [{ "active": true, "data": {}, "input": { "ref": "batch_message_ref01" }, "match": {}, "op": "create", "spec": [], "valid": [], "index$": 0 }, { "active": true, "data": {}, "input": { "ref": "batch_message_ref01", "suffix": "_rm0" }, "match": { "id": "batch_message01" }, "op": "remove", "spec": [], "valid": [], "index$": 1 }] }, 'BatchMessage');
        }
        const client = setup.client;
        const struct = setup.struct;
        const isempty = struct.isempty;
        const select = struct.select;
        // CREATE
        const batch_message_ref01_ent = client.BatchMessage();
        let batch_message_ref01_data = setup.data.new.batch_message['batch_message_ref01'];
        batch_message_ref01_data = (await batch_message_ref01_ent.create(batch_message_ref01_data)).data();
        (0, node_assert_1.default)(null != batch_message_ref01_data);
    });
});
function basicSetup(extra) {
    // TODO: fix test def options
    const options = {}; // null
    // TODO: needs test utility to resolve path
    const entityDataFile = node_path_1.default.resolve(__dirname, '../../../../.sdk/test/entity/batch_message/BatchMessageTestData.json');
    // TODO: file ready util needed?
    const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8');
    // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
    const entityData = JSON.parse(entityDataSource);
    options.entity = entityData.existing;
    let client = __1.ThesmsworksSDK.test(options, extra);
    const struct = client.utility().struct;
    const merge = struct.merge;
    const transform = struct.transform;
    let idmap = transform(['batch_message01', 'batch_message02', 'batch_message03', 'schedule01', 'schedule02', 'schedule03'], {
        '`$PACK`': ['', {
                '`$KEY`': '`$COPY`',
                '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
            }]
    });
    const env = (0, utility_1.envOverride)({
        'THESMSWORKS_TEST_BATCH_MESSAGE_ENTID': idmap,
        'THESMSWORKS_TEST_LIVE': 'FALSE',
        'THESMSWORKS_TEST_EXPLAIN': 'FALSE',
        'THESMSWORKS_APIKEY': '',
    });
    idmap = env['THESMSWORKS_TEST_BATCH_MESSAGE_ENTID'];
    const live = 'TRUE' === env.THESMSWORKS_TEST_LIVE;
    const transport = (0, live_runner_1.createLiveTransport)();
    if (live) {
        const rawIds = process.env['THESMSWORKS_TEST_BATCH_MESSAGE_ENTID'];
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
//# sourceMappingURL=BatchMessageEntity.test.js.map