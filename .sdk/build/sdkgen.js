
const { SdkGen } = require('@voxgig/sdkgen')

const config = {
  root: __dirname+'/../dist/Root.js',
  folder: __dirname+'/../..',
  meta: {
    name: 'thesmsworks'
  },
  model: {
    folder: __dirname+'/../model',
  },
  existing: { txt: { merge: false } },
}

module.exports = SdkGen.makeBuild(config)
