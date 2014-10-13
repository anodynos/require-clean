_ = require 'lodash'

path = require 'path'
resolveFrom = require 'resolve-from'
callerPath = require 'caller-path'

# Require a nodejs module, having first flashed its cache and by default its submodule's cache
# Inspired by http://stackoverflow.com/questions/9210542/node-js-require-cache-possible-to-invalidate

deleteMod = (mod)-> delete require.cache[mod.id]

searchCache = (name, calledFrom, deep, callback)->
  mod = resolveFrom path.dirname(calledFrom), name

  if mod and ((mod = require.cache[mod]) isnt undefined)
    (run = (mod)->
      if deep then mod.children.forEach (child)-> run child
      callback mod
    ) mod

requireClean = (name, deep=true)->
  throw new TypeError('requireClean expects a moduleId String') if not _.isString name
  cp = callerPath()
  searchCache name, cp, deep, deleteMod # cant "clean name, deep" cause of callerPath()
  require resolveFrom path.dirname(cp), name

requireClean.clean = (name, deep=true)->
  console.log deep
  if _.isUndefined name # clean all
    _.each require.cache, (v, key)-> delete require.cache[key]
  else
    throw new TypeError('requireClean.clean Expects a moduleId String') if not _.isString name
    searchCache name, callerPath(), deep, deleteMod

requireClean.VERSION = if VERSION? then VERSION else '{NO_VERSION}' # 'VERSION' variable is added by grant:concat

module.exports = requireClean