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
(0, node_test_1.describe)('OneTimePasswordEntity', async () => {
    // Per-test live pacing. Delay is read from sdk-test-control.json's
    // `test.live.delayMs`; only sleeps when THESMSWORKS_TEST_LIVE=TRUE.
    (0, node_test_1.afterEach)((0, utility_1.liveDelay)('THESMSWORKS_TEST_LIVE'));
    (0, node_test_1.test)('instance', async () => {
        const testsdk = __1.ThesmsworksSDK.test();
        const ent = testsdk.OneTimePassword();
        (0, node_assert_1.default)(null != ent);
    });
    (0, node_test_1.test)('validate', async (t) => {
        if (null == __1.config.feature?.validate) {
            t.skip('feature not present in this SDK: validate');
            return;
        }
        const client = __1.ThesmsworksSDK.test(undefined, { feature: { validate: { active: true } } });
        await node_assert_1.default.rejects(client.OneTimePassword().load({ "messageid": 1 }), (err) => 'validate_failed' === err.code);
    });
    (0, node_test_1.test)('basic', async (t) => {
        const live = 'TRUE' === process.env.THESMSWORKS_TEST_LIVE;
        for (const op of ['create']) {
            if (!live && (0, utility_1.maybeSkipControl)(t, 'entityOp', 'one_time_password.' + op, live))
                return;
        }
        const setup = basicSetup();
        if (setup.live) {
            return (0, live_entity_1.runLiveEntity)(setup, { "active": true, "alias": { "field": {} }, "fields": { "destination": { "a": true, "h": "Destination", "n": "destination", "r": false, "sh": "The phone number of the recipient.", "t": "`$STRING`", "key$": "destination", "index$": 0 }, "length": { "a": true, "h": "Length", "n": "length", "r": false, "sh": "The length of the generated passcode.", "t": "`$OBJECT`", "key$": "length", "index$": 1 }, "metadata": { "a": true, "h": "Metadata", "n": "metadata", "r": false, "sh": "A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application.", "t": "`$OBJECT`", "key$": "metadata", "index$": 2 }, "passcode": { "a": true, "h": "Passcode", "n": "passcode", "r": false, "sh": "A passcode you supply for use in the message template.", "t": "`$STRING`", "key$": "passcode", "index$": 3 }, "sender": { "a": true, "h": "Sender", "n": "sender", "r": false, "sh": "The sender of the message.", "t": "`$STRING`", "key$": "sender", "index$": 4 }, "template": { "a": true, "h": "Template", "n": "template", "r": false, "sh": "A template to use as the content for the message.", "t": "`$STRING`", "key$": "template", "index$": 5 }, "validity": { "a": true, "h": "Validity", "n": "validity", "r": false, "sh": "The length of time in seconds for which the generated passcode should be valid.", "t": "`$NUMBER`", "key$": "validity", "index$": 6 } }, "name": "one_time_password", "op": { "create": { "input": "data", "name": "create", "points": [{ "a": true, "bf": ["destination", "length", "metadata", "passcode", "sender", "template", "validity"], "co": { "id": "POST /otp/send", "source": "openapi3", "version": 2 }, "g": {}, "k": "http", "m": "POST", "o": "/otp/send", "q": {}, "r": {}, "rs": { "kind": "json", "media": "application/json;charset=UTF-8" }, "s": [{ "lit": "otp" }, { "lit": "send" }], "t": { "req": "`reqdata`", "res": "`body`" }, "index$": 0 }, { "a": true, "bf": ["passcode"], "co": { "id": "POST /otp/verify", "source": "openapi3", "version": 2 }, "g": {}, "k": "http", "m": "POST", "o": "/otp/verify", "q": {}, "r": {}, "rs": { "kind": "json", "media": "application/json;charset=UTF-8" }, "s": [{ "lit": "otp" }, { "lit": "verify" }], "t": { "req": "`reqdata`", "res": "`body`" }, "index$": 1 }], "key$": "create" }, "load": { "input": "data", "name": "load", "points": [{ "a": true, "co": { "id": "GET /otp/{messageid}", "source": "openapi3", "version": 2 }, "g": { "params": [{ "a": true, "k": "param", "n": "messageid", "or": "messageid", "r": true, "t": "`$STRING`", "index$": 0 }] }, "k": "http", "m": "GET", "o": "/otp/{messageid}", "q": { "exist": ["messageid"] }, "r": {}, "rs": { "kind": "json", "media": "application/json;charset=UTF-8" }, "s": [{ "lit": "otp" }, { "var": "messageid" }], "t": { "req": "`reqdata`", "res": "`body`" }, "index$": 0 }], "key$": "load" } }, "relations": { "ancestors": [] }, "key$": "one_time_password", "name__orig": "one_time_password", "Name": "OneTimePassword", "name_": "one_time_password", "name-": "one-time-password", "NAME": "ONE_TIME_PASSWORD", "index$": 5 }, { "active": true, "entity": "one_time_password", "key$": "BasicOneTimePasswordFlow", "kind": "basic", "name": "BasicOneTimePasswordFlow", "param": {}, "step": [{ "a": true, "d": {}, "i": { "ref": "one_time_password_ref01" }, "m": {}, "o": "create", "s": [], "v": [], "index$": 0 }, { "a": false, "d": {}, "i": { "ref": "one_time_password_ref01", "srcdatavar": "one_time_password_ref01_data", "suffix": "_dt0" }, "m": { "id": "one_time_password01" }, "o": "load", "s": [], "v": [{ "apply": "TextFieldMark", "def": { "mark": "Mark01-one_time_password_ref01" } }], "unreachable": true }] }, 'OneTimePassword', { "POST /otp/send": { "protocol": "http", "requestBody": { "content": { "application/json": { "schema": { "description": "Parameters for the generation and sending of One-Time Passwords", "example": { "template": "This is your one-time passcode - {{passcode}}", "metadata": { "customer_id": "ABC123", "cart_id": "XYZ789" }, "sender": "YourCompany", "destination": "7777777777", "length": "{}", "validity": 300, "passcode": "123456" }, "properties": { "sender": { "description": "The sender of the message. Should be no longer than 11 characters for alphanumeric or 15 characters for numeric sender ID's. No spaces or special characters.", "example": "YourCompany", "type": "string", "key$": "sender" }, "destination": { "description": "The phone number of the recipient.", "example": "7777777777", "type": "string", "key$": "destination" }, "length": { "description": "The length of the generated passcode. The default length is 6 characters, which will apply if this parameter is omitted. All generated passcodes are numeric. Optional.", "type": "object", "key$": "length" }, "template": { "description": "A template to use as the content for the message. You must include the '{{passcode}}' placeholder, which will be replaced by the generated passcode when the message is sent. Optional.", "example": "This is your one-time passcode - {{passcode}}", "type": "string", "key$": "template" }, "validity": { "description": "The length of time in seconds for which the generated passcode should be valid. Optional.", "example": 300, "type": "number", "key$": "validity" }, "passcode": { "description": "A passcode you supply for use in the message template. This will be stored on the OTP record in our system for later verification. Optional.", "example": "123456", "type": "string", "key$": "passcode" }, "metadata": { "description": "A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application. This will be returned when you verify the passcode.", "example": { "customer_id": "ABC123", "cart_id": "XYZ789" }, "properties": {}, "type": "object", "key$": "metadata" } }, "type": "object", "x-ref": "#/components/schemas/OTP", "index$": 1 } } }, "description": "OTP properties", "required": true }, "parameters": [] }, "POST /otp/verify": { "protocol": "http", "requestBody": { "content": { "application/json": { "schema": { "description": "Schema for the /oyp/verify method", "example": { "passcode": "123456" }, "properties": { "passcode": { "description": "One-Time Passcode submitted to your application", "example": "123456", "type": "string", "key$": "passcode" } }, "type": "object", "x-ref": "#/components/schemas/OTPVerify", "index$": 1 } } }, "description": "One-Time Password", "required": true }, "parameters": [] }, "GET /otp/{messageid}": { "protocol": "http", "parameters": [{ "description": "The ID of the OTP you would like returned", "explode": false, "in": "path", "name": "messageid", "required": true, "schema": { "type": "string" }, "style": "simple", "index$": 0 }] } }, { strict: LIVE_STRICT, t });
        }
        const client = setup.client;
        const struct = setup.struct;
        const isempty = struct.isempty;
        const select = struct.select;
        // CREATE
        const one_time_password_ref01_ent = client.OneTimePassword();
        let one_time_password_ref01_data = setup.data.new.one_time_password['one_time_password_ref01'];
        one_time_password_ref01_data = (await one_time_password_ref01_ent.create(one_time_password_ref01_data)).data();
        (0, node_assert_1.default)(null != one_time_password_ref01_data);
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
    const entityDataFile = node_path_1.default.resolve(__dirname, '../../../../.sdk/test/entity/one_time_password/OneTimePasswordTestData.json');
    // TODO: file ready util needed?
    const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8');
    // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
    const entityData = JSON.parse(entityDataSource);
    options.entity = entityData.existing;
    let client = __1.ThesmsworksSDK.test(options, extra);
    const struct = client.utility().struct;
    const merge = struct.merge;
    const transform = struct.transform;
    let idmap = transform(['one_time_password01', 'one_time_password02', 'one_time_password03'], {
        '`$PACK`': ['', {
                '`$KEY`': '`$COPY`',
                '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
            }]
    });
    const env = (0, utility_1.envOverride)({
        'THESMSWORKS_TEST_ONE_TIME_PASSWORD_ENTID': idmap,
        'THESMSWORKS_TEST_LIVE': 'FALSE',
        'THESMSWORKS_TEST_EXPLAIN': 'FALSE',
        'THESMSWORKS_APIKEY': '',
    });
    idmap = env['THESMSWORKS_TEST_ONE_TIME_PASSWORD_ENTID'];
    const live = 'TRUE' === env.THESMSWORKS_TEST_LIVE;
    const transport = (0, live_runner_1.createLiveTransport)();
    if (live) {
        const rawIds = process.env['THESMSWORKS_TEST_ONE_TIME_PASSWORD_ENTID'];
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
//# sourceMappingURL=OneTimePasswordEntity.test.js.map