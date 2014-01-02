noflo = require 'noflo'

class RelevanceByPosition extends noflo.Component

  description: 'Returns the relevance in connection to the given position'

  constructor: ->
    @inPorts =
      in: new noflo.Port

    @outPorts =
      out: new noflo.Port

    @inPorts.in.on 'data', (data) =>
      @outPorts.out.send getRelevanceByPosition(data)

    @inPorts.in.on 'disconnect', =>
      @outPorts.out.disconnect() if @outPorts.out.isAttached()

  getRelevanceByPosition = (value) ->
    return 0.17  if value > 0 and value <= 0.1
    return 0.23  if value > 0.1 and value <= 0.2
    return 0.14  if value > 0.2 and value <= 0.3
    return 0.08  if value > 0.3 and value <= 0.4
    return 0.05  if value > 0.4 and value <= 0.5
    return 0.04  if value > 0.5 and value <= 0.6
    return 0.06  if value > 0.6 and value <= 0.7
    return 0.04  if value > 0.7 and value <= 0.8
    return 0.04  if value > 0.8 and value <= 0.9
    return 0.15  if value > 0.9 and value <= 1.0
    0

exports.getComponent = -> new RelevanceByPosition