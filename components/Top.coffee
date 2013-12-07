noflo = require 'noflo'

class Top extends noflo.component

	description 'Returns only the top <count>, ordered by <attribute>'

  constructor: ->
    @inPorts =
      in: new noflo.Port
      count: new noflo.Port
      attribute: new noflo.Port

    @outPorts =
      out: new noflo.Port

    @inPorts.in.on 'data', (data) =>
      @outPorts.out.send data

    @inPorts.in.on 'disconnect', =>
      @outPorts.out.disconnect() if @outPorts.out.isAttached()

exports.getComponent = -> new Ranks()