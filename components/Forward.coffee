noflo = require 'noflo'

class Forward extends noflo.Component

  description: 'Forwards Packages'

  constructor: ->
    @inPorts =
      in: new noflo.Port

    @outPorts =
      out: new noflo.Port

    @inPorts.in.on 'data', (data) =>
      @outPorts.out.send data if @outPorts.out.isAttached()

    @inPorts.in.on 'disconnect', =>
      @outPorts.out.disconnect() if @outPorts.out.isAttached()

exports.getComponent = -> new Forward