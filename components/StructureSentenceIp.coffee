noflo = require 'noflo'

class StructureSentenceIp extends noflo.Component

  description: 'Forwards Packages'

  count: 0

  constructor: ->
    @inPorts =
      in: new noflo.Port

    @outPorts =
      out: new noflo.Port

    @inPorts.in.on 'data', (data) =>
      @count++
      @outPorts.out.send {
        sentence: @cleanup(data),
        readable: data,
        position: @count,
        score: 0
      }

    @inPorts.in.on 'disconnect', =>
      @count = 0
      @outPorts.out.disconnect() if @outPorts.out.isAttached()

  cleanup: (data) ->
    reg = /[^\w ]/g;
    data = data.toLowerCase()
    data = data.replace(reg, '')
    data.split(' ')

exports.getComponent = -> new StructureSentenceIp