noflo = require 'noflo'

class ComponentName extends noflo.Component

  description: 'Beschreibung der Komponenten'

  constructor: ->
    # Definition der Input Ports
    @inPorts =
      in: new noflo.Port

    # Definition der Output Ports
    @outPorts =
      out: new noflo.Port

    # Komponente reagiert auf das DATA Event (IP wird empfangen)
    @inPorts.in.on 'data', (data) =>
      # Reaktion auf das IP: Weiterleiten an den OUT Port wenn dieser verbunden ist.
      @outPorts.out.send data if @outPorts.out.isAttached()

exports.getComponent = -> new ComponentName



