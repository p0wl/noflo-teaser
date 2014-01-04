noflo = require 'noflo'
_ = require 'underscore'

class ScoreByKeywords extends noflo.Component

  description: 'Score Sentence by Keywords'

  keywords: []

  constructor: ->
    @inPorts =
      in: new noflo.Port
      keywords: new noflo.Port

    @outPorts =
      out: new noflo.Port

    @inPorts.in.on 'data', (data) =>
      @outPorts.out.send @score(data)

    @inPorts.in.on 'disconnect', =>
      @outPorts.out.disconnect() if @outPorts.out.isAttached()

    @inPorts.keywords.on 'data', (data) =>
      @keywords = data

  score: (data) ->
    return (sbs(data, @keywords) + dbs(data, @keywords)) / 2.0 * 10.0 * 2.0

  sbs = (words, keywords) ->
    score = 0.0
    return 0  if words.length is 0
    words.forEach (word) ->
      score += getWordCount(word, keywords)

    return (1.0 / Math.abs(words.length) * score) / 10.0

  dbs = (words, keywords) ->
    return 0  if words.length is 0
    summ = 0
    first = null
    second = {}
    i = 0

    while i < words.length
      word = words[i]
      score = getWordCount(word, keywords)
      if score > 0
        if first is null
          first =
            num: i
            score: score
        else
          second = first
          first =
            num: i
            score: score

          dif = first.num - second.num
          summ += (first.score * second.score) / Math.pow(dif, 2)
      i++
    k = _.intersection(_.chain(keywords).pluck("word").toArray().value(), words).length + 1
    return 1 / (k * (k + 1.0)) * summ

  getWordCount = (c, words) ->
    x = _.findWhere(words, word: c)
    return (if x then x.sum else 0)

exports.getComponent = -> new ScoreByKeywords