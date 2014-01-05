noflo = require 'noflo'

class Frequency extends noflo.Component

  description: 'Counts frequency of IPs. Sends results on disconnect.'

  buffer: []

  constructor: ->
    @inPorts =
      in: new noflo.Port

    @outPorts =
      out: new noflo.Port

    @inPorts.in.on 'data', (data) =>
      @checkFrequency(data)

    @inPorts.in.on 'disconnect', =>
      @outPorts.out.send @buffer if @outPorts.out.isAttached()
      @outPorts.out.disconnect() if @outPorts.out.isAttached()

  checkFrequency: (data) ->
    found = false
    _.each(@buffer, (entry) ->
      if (entry.ip == data)
        entry.count++
        found = true
    )
    if not found
      @buffer.push {ip: data, count: 0}

exports.getComponent = -> new Frequency