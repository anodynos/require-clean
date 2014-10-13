b = require './b'
a = 0
module.exports = ->
  a = a + 1
  a + b()


