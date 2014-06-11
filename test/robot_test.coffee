chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
path = require 'path'

expect = chai.expect

Robot = require '../src/robot.coffee'

describe 'Robot', ->

  describe 'Help', ->
    beforeEach (done)->
      @robot = robot = new Robot path.resolve('.', 'src', 'adapters'), 'shell', no, 'TestHubot'
      @robot.loadFile path.resolve('.', 'src', 'scripts'), 'help.coffee'
      waitForHelp = ->
        if robot.helpCommands().length > 0
          do done
        else
          setTimeout waitForHelp, 100
      do waitForHelp

    describe 'helpCommands', (done)->
      it 'should have 2 commands', ->
        expect(@robot.helpCommands()).to.have.length 2

      it 'should parse commands', ->
        expect(@robot.helpCommands()[0]).to.equal 'hubot help - Displays all of the help commands that Hubot knows about.'
        expect(@robot.helpCommands()[1]).to.equal 'hubot help <query> - Displays all help commands that match <query>.'

