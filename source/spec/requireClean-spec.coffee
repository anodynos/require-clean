_ = require 'lodash'
chai = require 'chai'
expect = chai.expect
{ equal } = require './specHelpers'

requireClean = require 'require-clean' # package name or `require '../code/requireClean'` - works the same

a = null

_.each ['./a', '../spec/a'], (pathToModule)-> do (pathToModule)->

  describe "with pathToModule = `#{pathToModule}`", ->

    describe 'Using plain `require` to load a module & its nested ones,', ->

      it "the module's closure holds its state.", ->
        requireClean.clean()
        a = require './a'
        equal a(), 111
        equal a(), 222
        equal a(), 333

      it "the module's closure holds its state when you re-`require` it.", ->
        a = require './a'
        equal a(), 444
        equal a(), 555
        equal a(), 666

    describe "Using `requireClean`", ->

      describe 'it loads the module & all its nested ones from a clean state, ', ->

        beforeEach ->
          requireClean.clean()
          a = require './a'
          a() #111

        it "by calling `requireClean(moduleId).", ->
          a = requireClean pathToModule
          equal a(), 111
          equal a(), 222
          equal a(), 333

        it "by calling `requireClean.clean` and then `require`", ->
          requireClean.clean './a'
          a = require  pathToModule
          equal a(), 111
          equal a(), 222
          equal a(), 333

      describe 'with `deep = false`, it cleans only the loaded module, not the nested ones', ->

        beforeEach ->
          requireClean.clean()
          a = requireClean './a'
          a() #111

        it "using `requireClean.clean(mod, false)` and then `require` it", ->
            requireClean.clean './a', false
            a = require  pathToModule
            equal a(), 221
            equal a(), 332
            equal a(), 443

        it "using, `requireClean(mod, false)`", ->
            a = requireClean pathToModule, false
            equal a(), 221
            equal a(), 332
            equal a(), 443

      describe.skip "With `native = false`, it doesn't clean module if its a node compiled object", ->

        beforeEach ->
          requireClean.clean()
          a = requireClean './a'
          a() #111

        it "using `requireClean.clean(mod, undefined, false)` and then `require` it", ->
          requireClean.clean './a', undefined, false
          a = require  pathToModule
          equal a(), 211
          equal a(), 322
          equal a(), 433

        it "using, `requireClean(mod, undefined, false)`", ->
          a = requireClean pathToModule, undefined, false
          equal a(), 211
          equal a(), 322
          equal a(), 433

