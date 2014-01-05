noflo = require 'noflo'

class AssertEqual extends noflo.Component

  description: 'Forwards Packages'

  assertion = null

  constructor: ->
    @inPorts =
      in: new noflo.Port
      assert: new noflo.Port

    @outPorts =
      out: new noflo.Port

    @inPorts.assert.on 'data', (data) =>
      @assertion = JSON.stringify(data)

    @inPorts.in.on 'data', (data) =>
      jsonData = JSON.stringify(data)
      if jsonData == @assertion        
        @outPorts.out.send "EQUAL: " + @assertion + " = " + jsonData
      else
        @outPorts.out.send "ASSERT FAILED: expected " + @assertion + " to equal " + jsonData

    @inPorts.in.on 'disconnect', =>
      @outPorts.out.disconnect() if @outPorts.out.isAttached()

exports.getComponent = -> new AssertEqual