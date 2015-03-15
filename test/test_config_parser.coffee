# file: test/test_config_parser.coffee

should = require 'should'
EventEmitter = require('events').EventEmitter

describe 'Hotcoffee Config Plugin', ->
  beforeEach ->
    @app = new EventEmitter()
    @app.config = {}
    process.argv = ['node', 'index.coffee'] # fake args
    @plugin = require("#{__dirname}/../index")(@app)

  it 'should expose its right name', ->
    @plugin.name.should.equal 'config'

  describe 'parseArgs()', ->

    it 'should return the parsed args from process.argv', ->
      process.argv[2] = "port=8000"
      process.argv[3] = "host=superhost"
      args = @plugin.parseArgs()
      args.should.have.property 'port', '8000'
      args.should.have.property 'host', 'superhost'


  describe 'init()', ->

    it 'should parse args and update the app config', ->
      process.argv[2] = "port=8001"
      process.argv[3] = "host=megahost"
      @plugin.init()
      @app.config.should.have.property 'port', '8001'
      @app.config.should.have.property 'host', 'megahost'
