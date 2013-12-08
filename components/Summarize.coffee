noflo = require 'noflo'

class Summarize extends noflo.Component

  description: 'Summarizes Text'

  constructor: ->
    @inPorts =
      intitle: new noflo.Port
      intext: new noflo.Port

    @outPorts =
      title: new noflo.Port
      text: new noflo.Port

    @inPorts.intitle.on 'data', (data) =>
      @outPorts.title.send data.toLowerCase() if @outPorts.title.isAttached()

    @inPorts.intext.on 'data', (data) =>
      @outPorts.text.send data.toLowerCase() if @outPorts.text.isAttached()

    @inPorts.intitle.on 'disconnect', =>
      @outPorts.title.disconnect() if @outPorts.title.isAttached()

    @inPorts.intext.on 'disconnect', =>
      @outPorts.text.disconnect() if @outPorts.text.isAttached()

exports.getComponent = -> new Summarize