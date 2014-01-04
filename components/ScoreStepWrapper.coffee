noflo = require 'noflo'

class ScoreStepWrapper extends noflo.Component

  description: 'Wrapper around ScoreBy... Graphs'

  buffer: [];

  constructor: ->
    @inPorts =
      in: new noflo.Port
      score: new noflo.Port

    @outPorts =
      position: new noflo.Port
      sentence: new noflo.Port
      out: new noflo.Port

    @inPorts.in.on 'data', (data) =>
      @buffer.push(data);
      @outPorts.position.send data.position if @outPorts.position.isAttached()
      @outPorts.sentence.send data.sentence if @outPorts.sentence.isAttached()

    @inPorts.score.on 'data', (data) =>
      sentence = @buffer.shift()
      sentence.score = data
      @outPorts.out.send sentence;

    @inPorts.in.on 'disconnect', =>
      @outPorts.position.disconnect() if @outPorts.position.isAttached()
      @outPorts.sentence.disconnect() if @outPorts.sentence.isAttached()

    @inPorts.score.on 'disconnect', =>
      @outPorts.out.disconnect() if @outPorts.out.isAttached()

exports.getComponent = -> new ScoreStepWrapper