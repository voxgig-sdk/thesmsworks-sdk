

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


describe('CreditEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when THESMSWORKS_TEST_LIVE=TRUE.
  afterEach(liveDelay('THESMSWORKS_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = ThesmsworksSDK.test()
    const ent = testsdk.Credit()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.THESMSWORKS_TEST_LIVE
    for (const op of ['load']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'credit.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":[],"name":"credit","op":{"load":{"input":"data","name":"load","points":[{"active":true,"args":{},"contract":{"id":"GET /credits/balance","json":"{\"parameters\":[],\"protocol\":\"http\",\"responses\":{\"200\":{\"content\":{\"application/json;charset=UTF-8\":{\"schema\":{\"example\":{\"credits\":180},\"properties\":{\"credits\":{\"description\":\"The number of remaining credits on your SMS Works account. Floating point number.\",\"example\":180,\"type\":\"number\"}},\"required\":[\"credits\"],\"type\":\"object\"}}},\"description\":\"Success\"},\"default\":{\"content\":{\"application/json;charset=UTF-8\":{\"schema\":{\"properties\":{\"message\":{\"type\":\"string\"}},\"required\":[\"message\"],\"type\":\"object\"}}},\"description\":\"Error\"}},\"security\":[{\"JWT\":[]}],\"securitySchemes\":{\"JWT\":{\"in\":\"header\",\"name\":\"Authorization\",\"type\":\"apiKey\"}},\"securitySource\":\"operation\"}","source":"openapi3","version":1},"kind":"http","method":"GET","orig":"/credits/balance","segments":[{"lit":"credits"},{"lit":"balance"}],"select":{"$action":"balance"},"transform":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"load"}},"relations":{"ancestors":[]},"key$":"credit","name__orig":"credit","Name":"Credit","name_":"credit","name-":"credit","NAME":"CREDIT","index$":2}, {"active":true,"entity":"credit","key$":"BasicCreditFlow","kind":"basic","name":"BasicCreditFlow","param":{},"step":[{"active":true,"data":{},"input":{"ref":"credit_ref01","srcdatavar":"credit_ref01_data","suffix":"_dt0"},"match":{},"op":"load","spec":[],"valid":[{"apply":"TextFieldMark","def":{"mark":"Mark01-credit_ref01"}}],"index$":0}]}, 'Credit')
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select

    let credit_ref01_data = Object.values(setup.data.existing.credit)[0] as any

    // LOAD
    const credit_ref01_ent = client.Credit()
    const credit_ref01_match_dt0: any = {}
    const credit_ref01_data_dt0 = (await credit_ref01_ent.load(credit_ref01_match_dt0)).data()
    assert(null != credit_ref01_data_dt0)


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/credit/CreditTestData.json')

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
    ['credit01','credit02','credit03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'THESMSWORKS_TEST_CREDIT_ENTID': idmap,
    'THESMSWORKS_TEST_LIVE': 'FALSE',
    'THESMSWORKS_TEST_EXPLAIN': 'FALSE',
    'THESMSWORKS_APIKEY': '',
  })

  idmap = env['THESMSWORKS_TEST_CREDIT_ENTID']

  const live = 'TRUE' === env.THESMSWORKS_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['THESMSWORKS_TEST_CREDIT_ENTID']
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
  
