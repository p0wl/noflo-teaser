noflo = require 'noflo'

class AssertEqual extends noflo.Component

  description: 'Forwards Packages'

  expection: null

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
        @outPorts.out.send "F -> ASSERT FAILED: expected " + jsonData + " to equal " + @expection

    @inPorts.in.on 'disconnect', =>
      @outPorts.out.disconnect() if @outPorts.out.isAttached()

exports.getComponent = -> new AssertEqual