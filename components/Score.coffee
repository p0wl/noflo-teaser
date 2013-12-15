noflo = require 'noflo'
jsTeaser = require './../node_modules/jsTeaser/jsTeaser.js'

class Score extends noflo.Component

  description: 'Ranks sentence by title and keywords'
  sentencesBuffer: []
  keywordsBuffer: []
  titleBuffer: []

  constructor: ->
    @inPorts =
      sentences: new noflo.ArrayPort
      title: new noflo.ArrayPort
      keywords: new noflo.ArrayPort

    @outPorts =
      out: new noflo.Port

    @inPorts.sentences.on 'data', (data) =>
      @sentencesBuffer.push data
      @calculateScore

    @inPorts.keywords.on 'data', (data) =>
      @keywordsBuffer.push data

    @inPorts.title.on 'data', (data) =>
      @titleBuffer.push data

    @inPorts.sentences.on 'disconnect', =>
      @calculateScore()

  calculateScore: ->
    if (@sentencesBuffer and @titleBuffer and @keywordsBuffer)
      if @outPorts.out.isAttached()
        while @sentencesBuffer.length > 0
          s = @sentencesBuffer.shift()
          if s
            @outPorts.out.send jsTeaser.scoreSentence s, @titleBuffer, @keywordsBuffer, 0.15
        @outPorts.out.disconnect()



exports.getComponent = -> new Score