
const envlocal = __dirname + '/../../../.env.local'
require('dotenv').config({ quiet: true, path: [envlocal] })

const Path = require('node:path')
const Fs = require('node:fs')

const { test, describe } = require('node:test')
const assert = require('node:assert')


const { ThesmsworksSDK, BaseFeature, stdutil, config } = require('../../..')

const {
  envOverride,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
} = require('../../utility')


describe('OneTimePasswordEntity', async () => {

  test('instance', async () => {
    const testsdk = ThesmsworksSDK.test()
    const ent = testsdk.OneTimePassword()
    assert(null != ent)
  })


  test('basic', async () => {

    const setup = basicSetup()
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const one_time_password_ref01_ent = client.OneTimePassword()
    let one_time_password_ref01_data = setup.data.new.one_time_password['one_time_password_ref01']

    one_time_password_ref01_data = (await one_time_password_ref01_ent.create(one_time_password_ref01_data)).data()
    assert(null != one_time_password_ref01_data)


    // LOAD
    const one_time_password_ref01_match_dt0 = {}
    const one_time_password_ref01_data_dt0 = (await one_time_password_ref01_ent.load(one_time_password_ref01_match_dt0)).data()
    assert(null != one_time_password_ref01_data_dt0)


  })
})



function basicSetup(extra) {
  // TODO: fix test def options
  const options = {} // null

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
    'THESMSWORKS_APIKEY': 'NONE',
  })

  idmap = env['THESMSWORKS_TEST_ONE_TIME_PASSWORD_ENTID']

  if ('TRUE' === env.THESMSWORKS_TEST_LIVE) {
    client = new ThesmsworksSDK(merge([
      {
        apikey: env.THESMSWORKS_APIKEY,
      },
      extra
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
    now: Date.now(),
  }

  return setup
}
  
