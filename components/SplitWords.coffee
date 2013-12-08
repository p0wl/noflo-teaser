noflo = require 'noflo'

class SplitWords extends noflo.Component

	description: 'Splits sentence to single words'

  constructor: ->
    @inPorts =
      in: new noflo.Port

    @outPorts =
      out: new noflo.Port

    @inPorts.in.on 'data', (data) =>
      @outPorts.out.send data

    @inPorts.in.on 'disconnect', =>
      @outPorts.out.disconnect() if @outPorts.out.isAttached()

exports.getComponent = -> new SplitWords