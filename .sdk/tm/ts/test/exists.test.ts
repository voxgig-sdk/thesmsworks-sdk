
import { test, describe } from 'node:test'
import { equal } from 'node:assert'


import { ThesmsworksSDK } from '..'


describe('exists', async () => {

  test('test-mode', () => {
    const testsdk = ThesmsworksSDK.test()
    equal(testsdk instanceof ThesmsworksSDK, true,
      'ThesmsworksSDK.test() must return a client synchronously')
  })

})
