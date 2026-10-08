
const envlocal = __dirname + '/../../../.env.local'
require('../../utility').loadEnvLocal(envlocal)

const Path = require('node:path')
const Fs = require('node:fs')

const { test, describe, afterEach } = require('node:test')
const assert = require('node:assert')
const { createLiveTransport } = require('../../live-runner')
const { runLiveEntity } = require('../../live-entity')


const { ThesmsworksSDK, BaseFeature, stdutil, config } = require('../../..')

const {
  envOverride,
  liveClientOptions,
  liveDelay,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
} = require('../../utility')


describe('MessageMessageEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when THESMSWORKS_TEST_LIVE=TRUE.
  afterEach(liveDelay('THESMSWORKS_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = ThesmsworksSDK.test()
    const ent = testsdk.MessageMessage()
    assert(null != ent)
  })


  test('validate', async (t) => {
    if (null == config.feature?.validate) {
      t.skip('feature not present in this SDK: validate')
      return
    }
    const client = ThesmsworksSDK.test(undefined, { feature: { validate: { active: true } } })
    await assert.rejects(client.MessageMessage().load({"id":1}),
      (err) => 'validate_failed' === err.code)
  })



  test('basic', async (t) => {

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"credits":{"a":true,"h":"Credits","n":"credits","r":false,"sh":"The number of credits used on the message.","t":"`$NUMBER`","key$":"credits","index$":0},"destination":{"a":true,"h":"Destination","n":"destination","r":false,"sh":"The phone number of the recipient.","t":"`$STRING`","key$":"destination","index$":1},"from":{"a":true,"h":"From","n":"from","r":false,"sh":"The date-time from which you would like matching messages","t":"`$STRING`","key$":"from","index$":2},"id":{"a":true,"h":"Id","n":"id","r":false,"t":"`$STRING`","key$":"id","index$":3},"keyword":{"a":true,"h":"Keyword","n":"keyword","r":false,"sh":"The keyword used in the inbound message","t":"`$STRING`","key$":"keyword","index$":4},"limit":{"a":true,"h":"Limit","n":"limit","r":false,"sh":"The maximum number of messages that you would like returned in this call.","t":"`$NUMBER`","key$":"limit","index$":5},"metadata":{"a":true,"h":"Metadata","n":"metadata","r":false,"sh":"An array of objects containing metadata key/value pairs that have been saved on messages.","t":"`$OBJECT`","key$":"metadata","index$":6},"sender":{"a":true,"h":"Sender","n":"sender","r":false,"sh":"The sender of the message (this can be the configured sender name for an outbound message or the senders phone number for an inbound message).","t":"`$STRING`","key$":"sender","index$":7},"skip":{"a":true,"h":"Skip","n":"skip","r":false,"sh":"The number of results you would like to ignore before returning messages.","t":"`$NUMBER`","key$":"skip","index$":8},"status":{"a":true,"h":"Status","n":"status","r":false,"sh":"The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING')","t":"`$STRING`","key$":"status","index$":9},"to":{"a":true,"h":"To","n":"to","r":false,"sh":"The date-time to which you would like matching messages","t":"`$STRING`","key$":"to","index$":10},"unread":{"a":true,"h":"Unread","n":"unread","r":false,"sh":"In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false).","t":"`$BOOLEAN`","key$":"unread","index$":11}},"id":{"field":"id","name":"id"},"name":"message_message","op":{"create":{"input":"data","name":"create","points":[{"a":true,"bf":["credits","destination","from","keyword","limit","metadata","sender","skip","status","to","unread"],"co":{"id":"POST /messages","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/messages","q":{},"r":{},"rs":{"kind":"json","media":"application/json;charset=UTF-8"},"s":[{"lit":"messages"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"create"},"load":{"input":"data","name":"load","points":[{"a":true,"co":{"id":"GET /messages/{messageid}","source":"openapi3","version":2},"g":{"params":[{"a":true,"k":"param","n":"id","or":"messageid","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"GET","o":"/messages/{messageid}","q":{"exist":["id"]},"r":{"param":{"messageid":"id"}},"rs":{"kind":"json","media":"application/json;charset=UTF-8"},"s":[{"lit":"messages"},{"var":"id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"load"},"remove":{"input":"data","name":"remove","points":[{"a":true,"co":{"id":"DELETE /messages/{messageid}","source":"openapi3","version":2},"g":{"params":[{"a":true,"k":"param","n":"id","or":"messageid","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"DELETE","o":"/messages/{messageid}","q":{"exist":["id"]},"r":{"param":{"messageid":"id"}},"rs":{"kind":"json","media":"application/json;charset=UTF-8"},"s":[{"lit":"messages"},{"var":"id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"remove"}},"relations":{"ancestors":[]},"key$":"message_message","name__orig":"message_message","Name":"MessageMessage","name_":"message_message","name-":"message-message","NAME":"MESSAGE_MESSAGE","index$":4}, {"active":true,"entity":"message_message","key$":"BasicMessageMessageFlow","kind":"basic","name":"BasicMessageMessageFlow","param":{},"step":[{"a":true,"d":{},"i":{"ref":"message_message_ref01"},"m":{},"o":"create","s":[],"v":[],"index$":0},{"a":true,"d":{},"i":{"ref":"message_message_ref01","srcdatavar":"message_message_ref01_data","suffix":"_dt0"},"m":{"id":"message_message01"},"o":"load","s":[],"v":[{"apply":"TextFieldMark","def":{"mark":"Mark01-message_message_ref01"}}],"index$":1},{"a":true,"d":{},"i":{"ref":"message_message_ref01","suffix":"_rm0"},"m":{"id":"message_message01"},"o":"remove","s":[],"v":[],"index$":2}]}, 'MessageMessage', {"POST /messages":{"protocol":"http","requestBody":{"content":{"application/json":{"schema":{"description":"search parameters for querying the message database","example":{"metadata":[{"key":"myKey1","value":"myValue1"},{"key":"myKey2","value":"myValue2"}],"credits":2,"sender":"YourCompany","unread":true,"destination":"447777777777","limit":1000,"from":"Wed Jul 12 2017 20:26:28 GMT+0100 (BST)","skip":2000,"to":"Wed Jul 19 2017 20:26:28 GMT+0100 (BST)","keyword":"SKYWALKER","status":"SENT"},"properties":{"status":{"description":"The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING')","example":"SENT","type":"string","key$":"status"},"credits":{"description":"The number of credits used on the message. Floating point number.","example":2,"type":"number","key$":"credits"},"destination":{"description":"The phone number of the recipient. Start UK numbers with 44 and drop the leading 0.","example":"447777777777","type":"string","key$":"destination"},"sender":{"description":"The sender of the message (this can be the configured sender name for an outbound message or the senders phone number for an inbound message).","example":"YourCompany","type":"string","key$":"sender"},"keyword":{"description":"The keyword used in the inbound message","example":"SKYWALKER","type":"string","key$":"keyword"},"from":{"description":"The date-time from which you would like matching messages","example":"Wed Jul 12 2017 20:26:28 GMT+0100 (BST)","type":"string","key$":"from"},"to":{"description":"The date-time to which you would like matching messages","example":"Wed Jul 19 2017 20:26:28 GMT+0100 (BST)","type":"string","key$":"to"},"limit":{"description":"The maximum number of messages that you would like returned in this call. The default is 1000.","example":1000,"type":"number","key$":"limit"},"skip":{"description":"The number of results you would like to ignore before returning messages. In combination with the 'limit' parameter his can be used to page results, so that you can deal with a limited number in your logic at each time.","example":2000,"type":"number","key$":"skip"},"unread":{"description":"In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). Omit this parameter in other circumstances.","type":"boolean","key$":"unread"},"metadata":{"description":"An array of objects containing metadata key/value pairs that have been saved on messages.","example":[{"key":"myKey1","value":"myValue1"},{"key":"myKey2","value":"myValue2"}],"properties":{"schema":{"description":"Key/value pair that will be returned to you in the API call response.","properties":{"key":{},"value":{}},"type":"object","x-ref":"#/components/schemas/MetaData"}},"type":"object","x-ref":"#/components/schemas/Query_metadata","key$":"metadata"}},"type":"object","x-ref":"#/components/schemas/Query","index$":1}}},"required":true},"parameters":[]},"GET /messages/{messageid}":{"protocol":"http","parameters":[{"description":"The ID of the message you would like returned","explode":false,"in":"path","name":"messageid","required":true,"schema":{"type":"string"},"style":"simple","index$":0}]},"DELETE /messages/{messageid}":{"protocol":"http","parameters":[{"description":"The ID of the message you would like returned","explode":false,"in":"path","name":"messageid","required":true,"schema":{"type":"string"},"style":"simple","index$":0}]}}, { strict: LIVE_STRICT, t })
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const message_message_ref01_ent = client.MessageMessage()
    let message_message_ref01_data = setup.data.new.message_message['message_message_ref01']

    message_message_ref01_data = (await message_message_ref01_ent.create(message_message_ref01_data)).data()
    assert(null != message_message_ref01_data.id)


    // LOAD
    const message_message_ref01_match_dt0 = {}
    message_message_ref01_match_dt0.id = message_message_ref01_data.id
    const message_message_ref01_data_dt0 = (await message_message_ref01_ent.load(message_message_ref01_match_dt0)).data()
    assert(message_message_ref01_data_dt0.id === message_message_ref01_data.id)


    // REMOVE
    const message_message_ref01_match_rm0 = {}
    message_message_ref01_match_rm0.id = message_message_ref01_data.id
    await message_message_ref01_ent.remove(message_message_ref01_match_rm0)
  

  })
})



// main.kit.test.live.strict is true (the default is true): a live
// request that fails, or a live test missing an input it needs,
// fails the test.
// An account with no record for a test to read skips it either way.
const LIVE_STRICT = true

function basicSetup(extra) {
  // TODO: fix test def options
  const options = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname,
      '../../../../.sdk/test/entity/message_message/MessageMessageTestData.json')

  // TODO: file ready util needed?
  const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8')

  // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
  const entityData = JSON.parse(entityDataSource)

  options.entity = entityData.existing

  let client = ThesmsworksSDK.test(options, extra)
  const struct = client.utility().struct
  const merge = struct.merge
  const transform = struct.transform

  let idmap = transform(
    ['message_message01','message_message02','message_message03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'THESMSWORKS_TEST_MESSAGE_MESSAGE_ENTID': idmap,
    'THESMSWORKS_TEST_LIVE': 'FALSE',
    'THESMSWORKS_TEST_EXPLAIN': 'FALSE',
    'THESMSWORKS_APIKEY': '',
  })

  idmap = env['THESMSWORKS_TEST_MESSAGE_MESSAGE_ENTID']

  const live = 'TRUE' === env.THESMSWORKS_TEST_LIVE
  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['THESMSWORKS_TEST_MESSAGE_MESSAGE_ENTID']
    idmap = rawIds && rawIds.trim() ? JSON.parse(rawIds) : {}
    if (!idmap || Array.isArray(idmap) || typeof idmap !== 'object') {
      throw new Error('Live ENTID must be a JSON object')
    }
    client = new ThesmsworksSDK(merge([
      // FIRST, so the generated fields below win: sdk-test-control.json's
      // test.client.options adds to the live client, it does not redirect it.
      liveClientOptions(),
      {
        apikey: env.THESMSWORKS_APIKEY,
      },
      // 'extra || {}', not a bare 'extra': struct.merge returns UNDEFINED when
      // the last entry is undefined, and basicSetup is normally called with no
      // argument at all - so a bare 'extra' silently discarded the apikey and
      // server values above and handed the SDK undefined.
      extra || {},
      { system: { fetch: transport.fetch } }
    ]))
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
  }

  return setup
}
  
