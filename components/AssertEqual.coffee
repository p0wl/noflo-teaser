noflo = require 'noflo'

class AssertEqual extends noflo.Component

  description: 'Forwards Packages'

  expection: null
  log: []

  constructor: ->
    @inPorts =
      in: new noflo.Port
      expected: new noflo.Port

    @outPorts =
      out: new noflo.Port

    @inPorts.expected.on 'data', (data) =>
      @expection = JSON.stringify(data)

    @inPorts.in.on 'data', (data) =>
      jsonData = JSON.stringify(data)
      if jsonData == @expection
        @outPorts.out.send "."
      else
        @outPorts.out.send "F"
        @log.push "ASSERT FAILED: expected " + @expection + " to equal " + jsonData

    @inPorts.in.on 'disconnect', =>
      @outPorts.out.send @log.join("\n")
      @outPorts.out.disconnect() if @outPorts.out.isAttached()

exports.getComponent = -> new AssertEqual