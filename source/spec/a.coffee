b = require './b'
pretendToBeNative = require './pretendToBeNative.node'

a = 0
module.exports = ->
  a = a + 1
  a + b() + pretendToBeNative()

