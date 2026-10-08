

import Path from 'node:path'
import * as Fs from 'node:fs'

import { test, describe, afterEach } from 'node:test'
import assert from 'node:assert'
import { createLiveTransport } from '../../live-runner'
import { runLiveEntity } from '../../live-entity'


import { ThesmsworksSDK, BaseFeature, config, stdutil } from '../../..'

import {
  envOverride,
  liveClientOptions,
  liveDelay,
  loadEnvLocal,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
  maybeSkipControl,
} from '../../utility'


loadEnvLocal(__dirname + '/../../../.env.local')


describe('MessageEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when THESMSWORKS_TEST_LIVE=TRUE.
  afterEach(liveDelay('THESMSWORKS_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = ThesmsworksSDK.test()
    const ent = testsdk.Message()
    assert(null != ent)
  })




  test('basic', async (t) => {

    const live = 'TRUE' === process.env.THESMSWORKS_TEST_LIVE
    for (const op of []) {
      if (!live && maybeSkipControl(t, 'entityOp', 'message.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{},"name":"message","op":{"create":{"input":"data","name":"create","points":[{"a":true,"bf":["credits","destination","from","keyword","limit","metadata","sender","skip","status","to","unread"],"co":{"id":"POST /messages/failed","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/messages/failed","q":{"$action":"failed"},"r":{},"rs":{"kind":"json","media":"application/json;charset=UTF-8"},"s":[{"lit":"messages"},{"lit":"failed"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0},{"a":true,"bf":["ai","content","deliveryreporturl","destination","metadata","responseemail","schedule","sender","tag","ttl","validity"],"co":{"id":"POST /message/flash","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/message/flash","q":{"$action":"flash"},"r":{},"rs":{"kind":"json","media":"application/json;charset=UTF-8"},"s":[{"lit":"message"},{"lit":"flash"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":1},{"a":true,"bf":["credits","destination","from","keyword","limit","metadata","sender","skip","status","to","unread"],"co":{"id":"POST /messages/inbox","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/messages/inbox","q":{"$action":"inbox"},"r":{},"rs":{"kind":"json","media":"application/json;charset=UTF-8"},"s":[{"lit":"messages"},{"lit":"inbox"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":2},{"a":true,"bf":["ai","content","deliveryreporturl","destination","metadata","responseemail","schedule","sender","tag","ttl","validity"],"co":{"id":"POST /message/schedule","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/message/schedule","q":{"$action":"schedule"},"r":{},"rs":{"kind":"json","media":"application/json;charset=UTF-8"},"s":[{"lit":"message"},{"lit":"schedule"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":3},{"a":true,"bf":["ai","content","deliveryreporturl","destination","metadata","responseemail","schedule","sender","tag","ttl","validity"],"co":{"id":"POST /message/send","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/message/send","q":{"$action":"send"},"r":{},"rs":{"kind":"json","media":"application/json;charset=UTF-8"},"s":[{"lit":"message"},{"lit":"send"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":4}],"key$":"create"}},"relations":{"ancestors":[]},"key$":"message","name__orig":"message","Name":"Message","name_":"message","name-":"message","NAME":"MESSAGE","index$":3}, {"active":true,"entity":"message","key$":"BasicMessageFlow","kind":"basic","name":"BasicMessageFlow","param":{},"step":[{"a":false,"d":{},"i":{"ref":"message_ref01"},"m":{},"o":"create","s":[],"v":[],"unreachable":true}]}, 'Message', {"POST /messages/failed":{"protocol":"http","requestBody":{"content":{"application/json":{"schema":{"description":"search parameters for querying the message database","example":{"metadata":[{"key":"myKey1","value":"myValue1"},{"key":"myKey2","value":"myValue2"}],"credits":2,"sender":"YourCompany","unread":true,"destination":"447777777777","limit":1000,"from":"Wed Jul 12 2017 20:26:28 GMT+0100 (BST)","skip":2000,"to":"Wed Jul 19 2017 20:26:28 GMT+0100 (BST)","keyword":"SKYWALKER","status":"SENT"},"properties":{"status":{"description":"The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING')","example":"SENT","type":"string","key$":"status"},"credits":{"description":"The number of credits used on the message. Floating point number.","example":2,"type":"number","key$":"credits"},"destination":{"description":"The phone number of the recipient. Start UK numbers with 44 and drop the leading 0.","example":"447777777777","type":"string","key$":"destination"},"sender":{"description":"The sender of the message (this can be the configured sender name for an outbound message or the senders phone number for an inbound message).","example":"YourCompany","type":"string","key$":"sender"},"keyword":{"description":"The keyword used in the inbound message","example":"SKYWALKER","type":"string","key$":"keyword"},"from":{"description":"The date-time from which you would like matching messages","example":"Wed Jul 12 2017 20:26:28 GMT+0100 (BST)","type":"string","key$":"from"},"to":{"description":"The date-time to which you would like matching messages","example":"Wed Jul 19 2017 20:26:28 GMT+0100 (BST)","type":"string","key$":"to"},"limit":{"description":"The maximum number of messages that you would like returned in this call. The default is 1000.","example":1000,"type":"number","key$":"limit"},"skip":{"description":"The number of results you would like to ignore before returning messages. In combination with the 'limit' parameter his can be used to page results, so that you can deal with a limited number in your logic at each time.","example":2000,"type":"number","key$":"skip"},"unread":{"description":"In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). Omit this parameter in other circumstances.","type":"boolean","key$":"unread"},"metadata":{"description":"An array of objects containing metadata key/value pairs that have been saved on messages.","example":[{"key":"myKey1","value":"myValue1"},{"key":"myKey2","value":"myValue2"}],"properties":{"schema":{"description":"Key/value pair that will be returned to you in the API call response.","properties":{"key":{},"value":{}},"type":"object","x-ref":"#/components/schemas/MetaData"}},"type":"object","x-ref":"#/components/schemas/Query_metadata","key$":"metadata"}},"type":"object","x-ref":"#/components/schemas/Query"}}},"required":true},"parameters":[]},"POST /message/flash":{"protocol":"http","requestBody":{"content":{"application/json":{"schema":{"description":"SMS message object","example":{"schedule":"Sun Sep 03 2020 15:34:23 GMT+0100 (BST)","metadata":[{"key":"myKey1","value":"myValue1"},{"key":"myKey2","value":"myValue2"}],"sender":"YourCompany","destination":"447777777777","ai":true,"responseemail":["my.email@mycompany.co.uk","my.other.email@mycompany.co.uk"],"tag":"SummerSpecial","validity":1440,"deliveryreporturl":"http://your.domain.com/delivery/report/path","ttl":10,"content":"Your super awesome message"},"properties":{"sender":{"description":"The sender of the message. Should be no longer than 11 characters for alphanumeric or 15 characters for numeric sender ID's. No spaces or special characters.","example":"YourCompany","type":"string"},"destination":{"description":"Telephone number of the recipient","example":"447777777777","type":"string"},"content":{"description":"Message to send to the recipient. Content can be up to 1280 characters in length. Messages of 160 characters or fewer are charged 1 credit. If your message is longer than 160 characters then it will be broken down in to chunks of 153 characters before being sent to the recipient's handset, and you will be charged 1 credit for each 153 characters. Messages sent to numbers registered outside the UK will be typically charged double credits, but for certain countries may be charged fractions of credits (e.g. 2.5). Please contact us for rates for each country.","example":"Your super awesome message","type":"string"},"deliveryreporturl":{"description":"The url to which we should POST delivery reports to for this message. If none is specified, we'll use the global delivery report URL that you've configured on your account page.","example":"http://your.domain.com/delivery/report/path","type":"string"},"schedule":{"description":"Date at which to send the message. This is only used by the message/schedule service and can be left empty for other services.","example":"Sun Sep 03 2020 15:34:23 GMT+0100 (BST)","type":"string"},"tag":{"description":"An identifying label for the message, which you can use to filter and report on messages you've sent later. Ideal for campaigns. A maximum of 280 characters.","example":"SummerSpecial","type":"string"},"ttl":{"description":"The optional number of minutes before the delivery report is deleted. Optional. Omit to prevent delivery report deletion. Integer.","example":10,"type":"number"},"responseemail":{"description":"An optional list of email addresses to forward responses to this specific message to. An SMS Works Reply Number is required to use this feature.","example":["my.email@mycompany.co.uk","my.other.email@mycompany.co.uk"],"items":{"type":"string"},"type":"array"},"metadata":{"example":[{"key":"myKey1","value":"myValue1"},{"key":"myKey2","value":"myValue2"}],"properties":{"schema":{"description":"Key/value pair that will be returned to you in the API call response.","properties":{"key":{},"value":{}},"type":"object","x-ref":"#/components/schemas/MetaData"}},"type":"object","x-ref":"#/components/schemas/Message_metadata"},"validity":{"description":"The optional number of minutes to attempt delivery before the message is marked as EXPIRED. Optional. The default is 2880 minutes. Integer.","example":1440,"maximum":2880,"minimum":1,"type":"number"},"ai":{"description":"Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. This setting overrides the AI Optimiser configuration on your SMS Works account.","type":"boolean"}},"required":["content","destination","sender"],"type":"object","x-ref":"#/components/schemas/Message"}}},"description":"Message properties","required":true},"parameters":[]},"POST /messages/inbox":{"protocol":"http","requestBody":{"content":{"application/json":{"schema":{"description":"search parameters for querying the message database","example":{"metadata":[{"key":"myKey1","value":"myValue1"},{"key":"myKey2","value":"myValue2"}],"credits":2,"sender":"YourCompany","unread":true,"destination":"447777777777","limit":1000,"from":"Wed Jul 12 2017 20:26:28 GMT+0100 (BST)","skip":2000,"to":"Wed Jul 19 2017 20:26:28 GMT+0100 (BST)","keyword":"SKYWALKER","status":"SENT"},"properties":{"status":{"description":"The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING')","example":"SENT","type":"string","key$":"status"},"credits":{"description":"The number of credits used on the message. Floating point number.","example":2,"type":"number","key$":"credits"},"destination":{"description":"The phone number of the recipient. Start UK numbers with 44 and drop the leading 0.","example":"447777777777","type":"string","key$":"destination"},"sender":{"description":"The sender of the message (this can be the configured sender name for an outbound message or the senders phone number for an inbound message).","example":"YourCompany","type":"string","key$":"sender"},"keyword":{"description":"The keyword used in the inbound message","example":"SKYWALKER","type":"string","key$":"keyword"},"from":{"description":"The date-time from which you would like matching messages","example":"Wed Jul 12 2017 20:26:28 GMT+0100 (BST)","type":"string","key$":"from"},"to":{"description":"The date-time to which you would like matching messages","example":"Wed Jul 19 2017 20:26:28 GMT+0100 (BST)","type":"string","key$":"to"},"limit":{"description":"The maximum number of messages that you would like returned in this call. The default is 1000.","example":1000,"type":"number","key$":"limit"},"skip":{"description":"The number of results you would like to ignore before returning messages. In combination with the 'limit' parameter his can be used to page results, so that you can deal with a limited number in your logic at each time.","example":2000,"type":"number","key$":"skip"},"unread":{"description":"In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). Omit this parameter in other circumstances.","type":"boolean","key$":"unread"},"metadata":{"description":"An array of objects containing metadata key/value pairs that have been saved on messages.","example":[{"key":"myKey1","value":"myValue1"},{"key":"myKey2","value":"myValue2"}],"properties":{"schema":{"description":"Key/value pair that will be returned to you in the API call response.","properties":{"key":{},"value":{}},"type":"object","x-ref":"#/components/schemas/MetaData"}},"type":"object","x-ref":"#/components/schemas/Query_metadata","key$":"metadata"}},"type":"object","x-ref":"#/components/schemas/Query"}}},"required":true},"parameters":[]},"POST /message/schedule":{"protocol":"http","requestBody":{"content":{"application/json":{"schema":{"description":"SMS message object","example":{"schedule":"Sun Sep 03 2020 15:34:23 GMT+0100 (BST)","metadata":[{"key":"myKey1","value":"myValue1"},{"key":"myKey2","value":"myValue2"}],"sender":"YourCompany","destination":"447777777777","ai":true,"responseemail":["my.email@mycompany.co.uk","my.other.email@mycompany.co.uk"],"tag":"SummerSpecial","validity":1440,"deliveryreporturl":"http://your.domain.com/delivery/report/path","ttl":10,"content":"Your super awesome message"},"properties":{"sender":{"description":"The sender of the message. Should be no longer than 11 characters for alphanumeric or 15 characters for numeric sender ID's. No spaces or special characters.","example":"YourCompany","type":"string"},"destination":{"description":"Telephone number of the recipient","example":"447777777777","type":"string"},"content":{"description":"Message to send to the recipient. Content can be up to 1280 characters in length. Messages of 160 characters or fewer are charged 1 credit. If your message is longer than 160 characters then it will be broken down in to chunks of 153 characters before being sent to the recipient's handset, and you will be charged 1 credit for each 153 characters. Messages sent to numbers registered outside the UK will be typically charged double credits, but for certain countries may be charged fractions of credits (e.g. 2.5). Please contact us for rates for each country.","example":"Your super awesome message","type":"string"},"deliveryreporturl":{"description":"The url to which we should POST delivery reports to for this message. If none is specified, we'll use the global delivery report URL that you've configured on your account page.","example":"http://your.domain.com/delivery/report/path","type":"string"},"schedule":{"description":"Date at which to send the message. This is only used by the message/schedule service and can be left empty for other services.","example":"Sun Sep 03 2020 15:34:23 GMT+0100 (BST)","type":"string"},"tag":{"description":"An identifying label for the message, which you can use to filter and report on messages you've sent later. Ideal for campaigns. A maximum of 280 characters.","example":"SummerSpecial","type":"string"},"ttl":{"description":"The optional number of minutes before the delivery report is deleted. Optional. Omit to prevent delivery report deletion. Integer.","example":10,"type":"number"},"responseemail":{"description":"An optional list of email addresses to forward responses to this specific message to. An SMS Works Reply Number is required to use this feature.","example":["my.email@mycompany.co.uk","my.other.email@mycompany.co.uk"],"items":{"type":"string"},"type":"array"},"metadata":{"example":[{"key":"myKey1","value":"myValue1"},{"key":"myKey2","value":"myValue2"}],"properties":{"schema":{"description":"Key/value pair that will be returned to you in the API call response.","properties":{"key":{},"value":{}},"type":"object","x-ref":"#/components/schemas/MetaData"}},"type":"object","x-ref":"#/components/schemas/Message_metadata"},"validity":{"description":"The optional number of minutes to attempt delivery before the message is marked as EXPIRED. Optional. The default is 2880 minutes. Integer.","example":1440,"maximum":2880,"minimum":1,"type":"number"},"ai":{"description":"Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. This setting overrides the AI Optimiser configuration on your SMS Works account.","type":"boolean"}},"required":["content","destination","sender"],"type":"object","x-ref":"#/components/schemas/Message"}}},"description":"Message properties","required":true},"parameters":[]},"POST /message/send":{"protocol":"http","requestBody":{"content":{"application/json":{"schema":{"description":"SMS message object","example":{"schedule":"Sun Sep 03 2020 15:34:23 GMT+0100 (BST)","metadata":[{"key":"myKey1","value":"myValue1"},{"key":"myKey2","value":"myValue2"}],"sender":"YourCompany","destination":"447777777777","ai":true,"responseemail":["my.email@mycompany.co.uk","my.other.email@mycompany.co.uk"],"tag":"SummerSpecial","validity":1440,"deliveryreporturl":"http://your.domain.com/delivery/report/path","ttl":10,"content":"Your super awesome message"},"properties":{"sender":{"description":"The sender of the message. Should be no longer than 11 characters for alphanumeric or 15 characters for numeric sender ID's. No spaces or special characters.","example":"YourCompany","type":"string"},"destination":{"description":"Telephone number of the recipient","example":"447777777777","type":"string"},"content":{"description":"Message to send to the recipient. Content can be up to 1280 characters in length. Messages of 160 characters or fewer are charged 1 credit. If your message is longer than 160 characters then it will be broken down in to chunks of 153 characters before being sent to the recipient's handset, and you will be charged 1 credit for each 153 characters. Messages sent to numbers registered outside the UK will be typically charged double credits, but for certain countries may be charged fractions of credits (e.g. 2.5). Please contact us for rates for each country.","example":"Your super awesome message","type":"string"},"deliveryreporturl":{"description":"The url to which we should POST delivery reports to for this message. If none is specified, we'll use the global delivery report URL that you've configured on your account page.","example":"http://your.domain.com/delivery/report/path","type":"string"},"schedule":{"description":"Date at which to send the message. This is only used by the message/schedule service and can be left empty for other services.","example":"Sun Sep 03 2020 15:34:23 GMT+0100 (BST)","type":"string"},"tag":{"description":"An identifying label for the message, which you can use to filter and report on messages you've sent later. Ideal for campaigns. A maximum of 280 characters.","example":"SummerSpecial","type":"string"},"ttl":{"description":"The optional number of minutes before the delivery report is deleted. Optional. Omit to prevent delivery report deletion. Integer.","example":10,"type":"number"},"responseemail":{"description":"An optional list of email addresses to forward responses to this specific message to. An SMS Works Reply Number is required to use this feature.","example":["my.email@mycompany.co.uk","my.other.email@mycompany.co.uk"],"items":{"type":"string"},"type":"array"},"metadata":{"example":[{"key":"myKey1","value":"myValue1"},{"key":"myKey2","value":"myValue2"}],"properties":{"schema":{"description":"Key/value pair that will be returned to you in the API call response.","properties":{"key":{},"value":{}},"type":"object","x-ref":"#/components/schemas/MetaData"}},"type":"object","x-ref":"#/components/schemas/Message_metadata"},"validity":{"description":"The optional number of minutes to attempt delivery before the message is marked as EXPIRED. Optional. The default is 2880 minutes. Integer.","example":1440,"maximum":2880,"minimum":1,"type":"number"},"ai":{"description":"Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. This setting overrides the AI Optimiser configuration on your SMS Works account.","type":"boolean"}},"required":["content","destination","sender"],"type":"object","x-ref":"#/components/schemas/Message"}}},"description":"Message properties","required":true},"parameters":[]}}, { strict: LIVE_STRICT, t })
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select

    let message_ref01_data = Object.values(setup.data.existing.message)[0] as any

  })
})



// main.kit.test.live.strict is true (the default is true): a live
// request that fails, or a live test missing an input it needs,
// fails the test.
// An account with no record for a test to read skips it either way.
const LIVE_STRICT = true

function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/message/MessageTestData.json')

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
    ['message01','message02','message03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'THESMSWORKS_TEST_MESSAGE_ENTID': idmap,
    'THESMSWORKS_TEST_LIVE': 'FALSE',
    'THESMSWORKS_TEST_EXPLAIN': 'FALSE',
    'THESMSWORKS_APIKEY': '',
  })

  idmap = env['THESMSWORKS_TEST_MESSAGE_ENTID']

  const live = 'TRUE' === env.THESMSWORKS_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['THESMSWORKS_TEST_MESSAGE_ENTID']
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
      // 'extra || {}', not a bare 'extra': struct.merge returns UNDEFINED when the
      // last entry is undefined, and basicSetup is normally called with no
      // argument at all - so a bare 'extra' silently discarded the apikey
      // and server values above and handed the SDK undefined. Harmless
      // while there was nothing in that object; not harmless now.
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
  
