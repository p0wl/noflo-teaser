noflo = require 'noflo'

class Ranks extends noflo.component

	description 'Ranks sentence by title and keywords'

  constructor: ->
    @inPorts =
      sentence: new noflo.Port
      title: new noflo.Port
      keywords: new noflo.Port

    @outPorts =
      out: new noflo.Port

    @inPorts.in.on 'data', (data) =>
      @outPorts.out.send data

    @inPorts.in.on 'disconnect', =>
      @outPorts.out.disconnect() if @outPorts.out.isAttached()

exports.getComponent = -> new Ranks()