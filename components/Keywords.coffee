noflo = require 'noflo'

class Keywords extends noflo.component

	description 'Extracts Keywords from a given sentence'

  constructor: ->
    @inPorts =
      in: new noflo.Port

    @outPorts =
      out: new noflo.Port

    @inPorts.in.on 'data', (data) =>
      @outPorts.out.send data

    @inPorts.in.on 'disconnect', =>
      @outPorts.out.disconnect() if @outPorts.out.isAttached()

exports.getComponent = -> new Keywords()