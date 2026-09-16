

import Path from 'node:path'
import * as Fs from 'node:fs'

import { test, describe, afterEach } from 'node:test'
import assert from 'node:assert'
import { createLiveTransport } from '../../live-runner'
import { runLiveEntity } from '../../live-entity'


import { ThesmsworksSDK, BaseFeature, stdutil } from '../../..'

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


// AFTER the imports on purpose: TypeScript hoists `import` above any
// statement in the emitted CommonJS, so a loader placed above them would
// run only after every imported module had already been evaluated - and
// anything reading process.env at module scope would miss these values.
loadEnvLocal(__dirname + '/../../../.env.local')


describe('OneTimePasswordEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when THESMSWORKS_TEST_LIVE=TRUE.
  afterEach(liveDelay('THESMSWORKS_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = ThesmsworksSDK.test()
    const ent = testsdk.OneTimePassword()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.THESMSWORKS_TEST_LIVE
    for (const op of ['create', 'load']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'one_time_password.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":[{"active":true,"name":"destination","req":false,"short":"The phone number of the recipient.","type":"`$STRING`","index$":0},{"active":true,"name":"length","req":false,"short":"The length of the generated passcode.","type":"`$OBJECT`","index$":1},{"active":true,"name":"metadata","req":false,"short":"A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application.","type":"`$OBJECT`","index$":2},{"active":true,"name":"passcode","req":false,"short":"A passcode you supply for use in the message template.","type":"`$STRING`","index$":3},{"active":true,"name":"sender","req":false,"short":"The sender of the message.","type":"`$STRING`","index$":4},{"active":true,"name":"template","req":false,"short":"A template to use as the content for the message.","type":"`$STRING`","index$":5},{"active":true,"name":"validity","req":false,"short":"The length of time in seconds for which the generated passcode should be valid.","type":"`$NUMBER`","index$":6}],"name":"one_time_password","op":{"create":{"input":"data","name":"create","points":[{"active":true,"args":{},"contract":{"id":"POST /otp/send","json":"{\"parameters\":[],\"protocol\":\"http\",\"requestBody\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"Parameters for the generation and sending of One-Time Passwords\",\"example\":{\"destination\":\"7777777777\",\"length\":\"{}\",\"metadata\":{\"cart_id\":\"XYZ789\",\"customer_id\":\"ABC123\"},\"passcode\":\"123456\",\"sender\":\"YourCompany\",\"template\":\"This is your one-time passcode - {{passcode}}\",\"validity\":300},\"properties\":{\"destination\":{\"description\":\"The phone number of the recipient.\",\"example\":\"7777777777\",\"type\":\"string\"},\"length\":{\"description\":\"The length of the generated passcode. The default length is 6 characters, which will apply if this parameter is omitted. All generated passcodes are numeric. Optional.\",\"type\":\"object\"},\"metadata\":{\"description\":\"A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application. This will be returned when you verify the passcode.\",\"example\":{\"cart_id\":\"XYZ789\",\"customer_id\":\"ABC123\"},\"properties\":{},\"type\":\"object\"},\"passcode\":{\"description\":\"A passcode you supply for use in the message template. This will be stored on the OTP record in our system for later verification. Optional.\",\"example\":\"123456\",\"type\":\"string\"},\"sender\":{\"description\":\"The sender of the message. Should be no longer than 11 characters for alphanumeric or 15 characters for numeric sender ID's. No spaces or special characters.\",\"example\":\"YourCompany\",\"type\":\"string\"},\"template\":{\"description\":\"A template to use as the content for the message. You must include the '{{passcode}}' placeholder, which will be replaced by the generated passcode when the message is sent. Optional.\",\"example\":\"This is your one-time passcode - {{passcode}}\",\"type\":\"string\"},\"validity\":{\"description\":\"The length of time in seconds for which the generated passcode should be valid. Optional.\",\"example\":300,\"type\":\"number\"}},\"type\":\"object\"}}},\"description\":\"OTP properties\",\"required\":true},\"responses\":{\"201\":{\"content\":{\"application/json;charset=UTF-8\":{\"schema\":{\"description\":\"Response schema for the /otp/send method\",\"example\":{\"credits\":561,\"creditsUsed\":1,\"messageid\":\"52692416-ce9e-45ad-aa1e-14fcee8fa662\",\"messageparts\":1,\"status\":\"SENT\"},\"properties\":{\"credits\":{\"description\":\"The credit balance on your account\",\"example\":561,\"type\":\"number\"},\"creditsUsed\":{\"description\":\"The number of credits used to send this message\",\"example\":1,\"type\":\"number\"},\"messageid\":{\"description\":\"The messageid of the SMS used to send the OTP. Save this in your application to use when verifying passcodes.\",\"example\":\"52692416-ce9e-45ad-aa1e-14fcee8fa662\",\"type\":\"string\"},\"messageparts\":{\"description\":\"The number of message parts used to send this message\",\"example\":1,\"type\":\"number\"},\"status\":{\"description\":\"The initial status of the OTP message.\",\"example\":\"SENT\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Success\"},\"default\":{\"content\":{\"application/json;charset=UTF-8\":{\"schema\":{\"properties\":{\"message\":{\"type\":\"string\"}},\"required\":[\"message\"],\"type\":\"object\"}}},\"description\":\"Error\"}},\"security\":[{\"JWT\":[]}],\"securitySchemes\":{\"JWT\":{\"in\":\"header\",\"name\":\"Authorization\",\"type\":\"apiKey\"}},\"securitySource\":\"operation\"}","source":"openapi3","version":1},"kind":"http","method":"POST","orig":"/otp/send","segments":[{"lit":"otp"},{"lit":"send"}],"select":{},"transform":{"req":"`reqdata`","res":"`body`"},"index$":0},{"active":true,"args":{},"contract":{"id":"POST /otp/verify","json":"{\"parameters\":[],\"protocol\":\"http\",\"requestBody\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"Schema for the /oyp/verify method\",\"example\":{\"passcode\":\"123456\"},\"properties\":{\"passcode\":{\"description\":\"One-Time Passcode submitted to your application\",\"example\":\"123456\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"One-Time Password\",\"required\":true},\"responses\":{\"200\":{\"content\":{\"application/json;charset=UTF-8\":{\"schema\":{\"description\":\"Response schema for the /otp/verify method\",\"example\":{\"created\":\"Tue Apr 25 2023 16:47:00 GMT+0100 (British Summer Time)\",\"destination\":\"447777000000\",\"expires\":\"Tue Apr 25 2023 16:57:00 GMT+0100 (British Summer Time)\",\"metadata\":{\"cart_id\":\"XYZ789\",\"customer_id\":\"ABC123\"},\"modified\":\"Tue Apr 25 2023 16:49:20 GMT+0100 (British Summer Time)\",\"passcode\":123456,\"status\":\"VERIFIED\",\"validity\":300},\"properties\":{\"created\":{\"description\":\"The ISO 8601 date/time at which this OTP was created\",\"example\":\"Tue Apr 25 2023 16:47:00 GMT+0100 (British Summer Time)\",\"type\":\"string\"},\"destination\":{\"description\":\"The mobile number that the OTP was sent to\",\"example\":\"447777000000\",\"type\":\"string\"},\"expires\":{\"description\":\"The ISO 8601 date/time at which this OTP expires\",\"example\":\"Tue Apr 25 2023 16:57:00 GMT+0100 (British Summer Time)\",\"type\":\"string\"},\"metadata\":{\"description\":\"A JSON object storing data supplied when this passcode was generated, for use in your application.\",\"example\":{\"cart_id\":\"XYZ789\",\"customer_id\":\"ABC123\"},\"properties\":{},\"type\":\"object\"},\"modified\":{\"description\":\"The ISO 8601 date/time at which this OTP was modified (typically when it was verified)\",\"example\":\"Tue Apr 25 2023 16:49:20 GMT+0100 (British Summer Time)\",\"type\":\"string\"},\"passcode\":{\"description\":\"The passcode used.\",\"example\":123456,\"type\":\"number\"},\"status\":{\"description\":\"The status of the OTP. If the passcode is used within the validity period then this will be 'VERIFIED', otherwise it will be 'EXPIRED'\",\"example\":\"VERIFIED\",\"type\":\"string\"},\"validity\":{\"description\":\"The length of time in seconds for which the generated passcode is valid.\",\"example\":300,\"type\":\"number\"}},\"type\":\"object\"}}},\"description\":\"Success\"},\"404\":{\"content\":{\"application/json;charset=UTF-8\":{\"schema\":{\"properties\":{\"message\":{\"type\":\"string\"}},\"required\":[\"message\"],\"type\":\"object\"}}},\"description\":\"Error\"},\"default\":{\"content\":{\"application/json;charset=UTF-8\":{\"schema\":{\"properties\":{\"message\":{\"type\":\"string\"}},\"required\":[\"message\"],\"type\":\"object\"}}},\"description\":\"Error\"}},\"security\":[{\"JWT\":[]}],\"securitySchemes\":{\"JWT\":{\"in\":\"header\",\"name\":\"Authorization\",\"type\":\"apiKey\"}},\"securitySource\":\"operation\"}","source":"openapi3","version":1},"kind":"http","method":"POST","orig":"/otp/verify","segments":[{"lit":"otp"},{"lit":"verify"}],"select":{},"transform":{"req":"`reqdata`","res":"`body`"},"index$":1}],"key$":"create"},"load":{"input":"data","name":"load","points":[{"active":true,"args":{"params":[{"active":true,"kind":"param","name":"messageid","orig":"messageid","reqd":true,"type":"`$STRING`","index$":0}]},"contract":{"id":"GET /otp/{messageid}","json":"{\"parameters\":[{\"description\":\"The ID of the OTP you would like returned\",\"explode\":false,\"in\":\"path\",\"name\":\"messageid\",\"required\":true,\"schema\":{\"type\":\"string\"},\"style\":\"simple\"}],\"protocol\":\"http\",\"responses\":{\"200\":{\"content\":{\"application/json;charset=UTF-8\":{\"schema\":{\"description\":\"Response schema for the /otp/verify method\",\"example\":{\"created\":\"Tue Apr 25 2023 16:47:00 GMT+0100 (British Summer Time)\",\"destination\":\"447777000000\",\"expires\":\"Tue Apr 25 2023 16:57:00 GMT+0100 (British Summer Time)\",\"metadata\":{\"cart_id\":\"XYZ789\",\"customer_id\":\"ABC123\"},\"modified\":\"Tue Apr 25 2023 16:49:20 GMT+0100 (British Summer Time)\",\"passcode\":123456,\"status\":\"VERIFIED\",\"validity\":300},\"properties\":{\"created\":{\"description\":\"The ISO 8601 date/time at which this OTP was created\",\"example\":\"Tue Apr 25 2023 16:47:00 GMT+0100 (British Summer Time)\",\"type\":\"string\"},\"destination\":{\"description\":\"The mobile number that the OTP was sent to\",\"example\":\"447777000000\",\"type\":\"string\"},\"expires\":{\"description\":\"The ISO 8601 date/time at which this OTP expires\",\"example\":\"Tue Apr 25 2023 16:57:00 GMT+0100 (British Summer Time)\",\"type\":\"string\"},\"metadata\":{\"description\":\"A JSON object storing data supplied when this passcode was generated, for use in your application.\",\"example\":{\"cart_id\":\"XYZ789\",\"customer_id\":\"ABC123\"},\"properties\":{},\"type\":\"object\"},\"modified\":{\"description\":\"The ISO 8601 date/time at which this OTP was modified (typically when it was verified)\",\"example\":\"Tue Apr 25 2023 16:49:20 GMT+0100 (British Summer Time)\",\"type\":\"string\"},\"passcode\":{\"description\":\"The passcode used.\",\"example\":123456,\"type\":\"number\"},\"status\":{\"description\":\"The status of the OTP. If the passcode is used within the validity period then this will be 'VERIFIED', otherwise it will be 'EXPIRED'\",\"example\":\"VERIFIED\",\"type\":\"string\"},\"validity\":{\"description\":\"The length of time in seconds for which the generated passcode is valid.\",\"example\":300,\"type\":\"number\"}},\"type\":\"object\"}}},\"description\":\"Success\"},\"404\":{\"content\":{\"application/json;charset=UTF-8\":{\"schema\":{\"properties\":{\"message\":{\"type\":\"string\"}},\"required\":[\"message\"],\"type\":\"object\"}}},\"description\":\"Error\"},\"default\":{\"content\":{\"application/json;charset=UTF-8\":{\"schema\":{\"properties\":{\"message\":{\"type\":\"string\"}},\"required\":[\"message\"],\"type\":\"object\"}}},\"description\":\"Error\"}},\"security\":[{\"JWT\":[]}],\"securitySchemes\":{\"JWT\":{\"in\":\"header\",\"name\":\"Authorization\",\"type\":\"apiKey\"}},\"securitySource\":\"operation\"}","source":"openapi3","version":1},"kind":"http","method":"GET","orig":"/otp/{messageid}","segments":[{"lit":"otp"},{"var":"messageid"}],"select":{"exist":["messageid"]},"transform":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"load"}},"relations":{"ancestors":[["otp"]]},"key$":"one_time_password","name__orig":"one_time_password","Name":"OneTimePassword","name_":"one_time_password","name-":"one-time-password","NAME":"ONE_TIME_PASSWORD","index$":5}, {"active":true,"entity":"one_time_password","key$":"BasicOneTimePasswordFlow","kind":"basic","name":"BasicOneTimePasswordFlow","param":{},"step":[{"active":true,"data":{},"input":{"ref":"one_time_password_ref01"},"match":{},"op":"create","spec":[],"valid":[],"index$":0},{"active":true,"data":{},"input":{"ref":"one_time_password_ref01","srcdatavar":"one_time_password_ref01_data","suffix":"_dt0"},"match":{"id":"one_time_password01"},"op":"load","spec":[],"valid":[{"apply":"TextFieldMark","def":{"mark":"Mark01-one_time_password_ref01"}}],"index$":1}]}, 'OneTimePassword')
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const one_time_password_ref01_ent = client.OneTimePassword()
    let one_time_password_ref01_data = setup.data.new.one_time_password['one_time_password_ref01']

    one_time_password_ref01_data = (await one_time_password_ref01_ent.create(one_time_password_ref01_data)).data()
    assert(null != one_time_password_ref01_data)



  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/one_time_password/OneTimePasswordTestData.json')

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
    ['one_time_password01','one_time_password02','one_time_password03','otp01','otp02','otp03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'THESMSWORKS_TEST_ONE_TIME_PASSWORD_ENTID': idmap,
    'THESMSWORKS_TEST_LIVE': 'FALSE',
    'THESMSWORKS_TEST_EXPLAIN': 'FALSE',
    'THESMSWORKS_APIKEY': '',
  })

  idmap = env['THESMSWORKS_TEST_ONE_TIME_PASSWORD_ENTID']

  const live = 'TRUE' === env.THESMSWORKS_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['THESMSWORKS_TEST_ONE_TIME_PASSWORD_ENTID']
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
  
