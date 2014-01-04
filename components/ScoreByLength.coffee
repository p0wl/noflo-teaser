noflo = require 'noflo'

class RelevanceByLength extends noflo.Component

  description: 'Returns the relevance in connection to the length of the sentence.'

  ideal: 20

  constructor: ->

    @inPorts =
      in: new noflo.Port
      option: new noflo.Port

    @outPorts =
      out: new noflo.Port

    @inPorts.option.on 'data', (data) =>
      @ideal = data

    @inPorts.in.on 'data', (data) =>
      @outPorts.out.send @getRelevanceByLength(data)

    @inPorts.in.on 'disconnect', =>
      @outPorts.out.disconnect() if @outPorts.out.isAttached()

  getRelevanceByLength: (sentence) ->
    1 - Math.abs(@ideal - sentence.length) / @ideal

exports.getComponent = -> new RelevanceByLength()