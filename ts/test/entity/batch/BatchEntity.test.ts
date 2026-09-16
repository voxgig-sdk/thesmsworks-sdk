

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


describe('BatchEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when THESMSWORKS_TEST_LIVE=TRUE.
  afterEach(liveDelay('THESMSWORKS_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = ThesmsworksSDK.test()
    const ent = testsdk.Batch()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.THESMSWORKS_TEST_LIVE
    for (const op of ['load']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'batch.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":[{"active":true,"name":"id","req":false,"type":"`$STRING`","index$":0}],"id":{"field":"id","name":"id"},"name":"batch","op":{"load":{"input":"data","name":"load","points":[{"active":true,"args":{"params":[{"active":true,"kind":"param","name":"id","orig":"batchid","reqd":true,"type":"`$STRING`","index$":0}]},"contract":{"id":"GET /batch/{batchid}","json":"{\"parameters\":[{\"description\":\"The ID of the batch you would like returned\",\"explode\":false,\"in\":\"path\",\"name\":\"batchid\",\"required\":true,\"schema\":{\"type\":\"string\"},\"style\":\"simple\"}],\"protocol\":\"http\",\"responses\":{\"200\":{\"content\":{\"application/json;charset=UTF-8\":{\"schema\":{\"items\":{\"example\":{\"batchid\":\"2586749\",\"content\":\"My super awesome message\",\"created\":\"Wed Jul 19 2017 20:53:46 GMT+0100 (BST)\",\"customerid\":\"0fca8c3c-6cbc-11e7-8154-a6006ad3dba0\",\"deliveryreporturl\":\"https://your.domain.com/delivery/report/path\",\"destination\":447777777777,\"failurereason\":{\"code\":34,\"details\":\"Handset error\",\"permanent\":false},\"id\":\"123456789\",\"identifier\":\"7777777777\",\"keyword\":\"CALRISSIAN\",\"messageid\":\"123456789\",\"modified\":\"Wed Jul 19 2017 20:53:49 GMT+0100 (BST)\",\"schedule\":\"Wed Jul 19 2017 20:53:45 GMT+0100 (BST)\",\"sender\":\"YourCompany\",\"status\":\"DELIVERED\",\"tag\":\"campaign2\"},\"properties\":{\"batchid\":{\"example\":\"2586749\",\"type\":\"string\"},\"content\":{\"example\":\"My super awesome message\",\"type\":\"string\"},\"created\":{\"example\":\"Wed Jul 19 2017 20:53:46 GMT+0100 (BST)\",\"type\":\"string\"},\"customerid\":{\"example\":\"0fca8c3c-6cbc-11e7-8154-a6006ad3dba0\",\"type\":\"string\"},\"deliveryreporturl\":{\"example\":\"https://your.domain.com/delivery/report/path\",\"type\":\"string\"},\"destination\":{\"example\":447777777777,\"type\":\"number\"},\"failurereason\":{\"example\":{\"code\":34,\"details\":\"Handset error\",\"permanent\":false},\"properties\":{\"code\":{\"description\":\"Numeric code that defines the error. Integer.\",\"example\":34,\"type\":\"number\"},\"details\":{\"example\":\"Handset error\",\"type\":\"string\"},\"permanent\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"},\"id\":{\"example\":\"123456789\",\"type\":\"string\"},\"identifier\":{\"example\":\"7777777777\",\"type\":\"string\"},\"keyword\":{\"example\":\"CALRISSIAN\",\"type\":\"string\"},\"messageid\":{\"example\":\"123456789\",\"type\":\"string\"},\"modified\":{\"example\":\"Wed Jul 19 2017 20:53:49 GMT+0100 (BST)\",\"type\":\"string\"},\"schedule\":{\"example\":\"Wed Jul 19 2017 20:53:45 GMT+0100 (BST)\",\"type\":\"string\"},\"sender\":{\"example\":\"YourCompany\",\"type\":\"string\"},\"status\":{\"example\":\"DELIVERED\",\"type\":\"string\"},\"tag\":{\"example\":\"campaign2\",\"type\":\"string\"}},\"required\":[\"content\",\"created\",\"customerid\",\"destination\",\"messageid\",\"modified\",\"schedule\",\"sender\",\"status\",\"tag\"],\"type\":\"object\"},\"type\":\"array\"}}},\"description\":\"Success\"},\"404\":{\"content\":{\"application/json;charset=UTF-8\":{\"schema\":{\"properties\":{\"message\":{\"type\":\"string\"}},\"required\":[\"message\"],\"type\":\"object\"}}},\"description\":\"Error\"},\"default\":{\"content\":{\"application/json;charset=UTF-8\":{\"schema\":{\"properties\":{\"message\":{\"type\":\"string\"}},\"required\":[\"message\"],\"type\":\"object\"}}},\"description\":\"Error\"}},\"security\":[{\"JWT\":[]}],\"securitySchemes\":{\"JWT\":{\"in\":\"header\",\"name\":\"Authorization\",\"type\":\"apiKey\"}},\"securitySource\":\"operation\"}","source":"openapi3","version":1},"kind":"http","method":"GET","orig":"/batch/{batchid}","rename":{"param":{"batchid":"id"}},"segments":[{"lit":"batch"},{"var":"id"}],"select":{"exist":["id"]},"transform":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"load"}},"relations":{"ancestors":[]},"key$":"batch","name__orig":"batch","Name":"Batch","name_":"batch","name-":"batch","NAME":"BATCH","index$":0}, {"active":true,"entity":"batch","key$":"BasicBatchFlow","kind":"basic","name":"BasicBatchFlow","param":{},"step":[{"active":true,"data":{},"input":{"ref":"batch_ref01","srcdatavar":"batch_ref01_data","suffix":"_dt0"},"match":{"id":"batch01"},"op":"load","spec":[],"valid":[{"apply":"TextFieldMark","def":{"mark":"Mark01-batch_ref01"}}],"index$":0}]}, 'Batch')
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select

    let batch_ref01_data = Object.values(setup.data.existing.batch)[0] as any

    // LOAD
    const batch_ref01_ent = client.Batch()
    const batch_ref01_match_dt0: any = {}
    batch_ref01_match_dt0.id = batch_ref01_data.id
    const batch_ref01_data_dt0 = (await batch_ref01_ent.load(batch_ref01_match_dt0)).data()
    assert(batch_ref01_data_dt0.id === batch_ref01_data.id)


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/batch/BatchTestData.json')

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
    ['batch01','batch02','batch03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'THESMSWORKS_TEST_BATCH_ENTID': idmap,
    'THESMSWORKS_TEST_LIVE': 'FALSE',
    'THESMSWORKS_TEST_EXPLAIN': 'FALSE',
    'THESMSWORKS_APIKEY': '',
  })

  idmap = env['THESMSWORKS_TEST_BATCH_ENTID']

  const live = 'TRUE' === env.THESMSWORKS_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['THESMSWORKS_TEST_BATCH_ENTID']
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
  
