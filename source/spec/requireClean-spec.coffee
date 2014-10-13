_ = (_B = require 'uberscore')._
l = new _B.Logger "requireClean", 1

chai = require 'chai'
expect = chai.expect


#describe = ->

{ equal, notEqual, ok, notOk, tru, fals, deepEqual, notDeepEqual, exact, notExact, iqual, notIqual
  ixact, notIxact, like, notLike, likeBA, notLikeBA, equalSet, notEqualSet } = require './specHelpers'

requireClean = require '../code/requireClean'

describe 'plain `require`', ->

  it "`require`, a() -& nested b- start", ->
    a = require './a'
    equal a(), 11
    equal a(), 22
    equal a(), 33

  it "`require` with diff path, a() -& nested b- continue", ->
    a = require '../spec/a'
    equal a(), 44
    equal a(), 55
    equal a(), 66

describe 'requireClean', ->

  it "`requireClean`, a() -& nested b- restart", ->
    a = requireClean './a'
    equal a(), 11
    equal a(), 22
    equal a(), 33

  it "`requireClean.clean` then `require`, a() -& nested b- again restart", ->
    requireClean.clean './a'
    a = require  './a'
    equal a(), 11
    equal a(), 22
    equal a(), 33

  it "`requireClean.clean` with no deep, then `require`, a() restarts but nested b is not", ->
    requireClean.clean '../spec/a', false
    a = require  './a'
    equal a(), 41
    equal a(), 52
    equal a(), 63

describe 'plain `require` again', ->

  it "`require`, a() -& nested b- continue from where left", ->
    a = require './a'
    equal a(), 74
    equal a(), 85
    equal a(), 96

  it "`require` with diff path, a() -& nested b- continue from where left", ->
    a = require '../../build/spec/a'
    equal a(), 107
    equal a(), 118
    equal a(), 129

describe 'cleanAll & plain `require` again', ->

  it "`requireClean.cleanAll` then `require`, a() -& nested b- restart", ->
    requireClean.clean()
    a = require './a'
    equal a(), 11
    equal a(), 22
    equal a(), 33



