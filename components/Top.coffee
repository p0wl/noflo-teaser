noflo = require 'noflo'
jsTeaser = require './../node_modules/jsTeaser/jsTeaser.js'

class Top extends noflo.Component

  description: 'Returns only the top <count>, ordered by <attribute>'
  buffer: []

  constructor: ->
    @inPorts =
      in: new noflo.ArrayPort

    @outPorts =
      out: new noflo.Port

    @inPorts.in.on 'data', (data) =>
      @buffer.push data

    @inPorts.in.on 'disconnect', =>
      @outPorts.out.send jsTeaser.top @buffer
      @outPorts.out.disconnect() if @outPorts.out.isAttached()

exports.getComponent = -> new Top