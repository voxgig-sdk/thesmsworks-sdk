
import { test, describe } from 'node:test'
import { equal } from 'node:assert'


import { ThesmsworksSDK } from '..'


describe('exists', async () => {

  test('test-mode', async () => {
    const testsdk = await ThesmsworksSDK.test()
    equal(null !== testsdk, true)
  })

})
