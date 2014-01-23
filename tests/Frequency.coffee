test = require "noflo-test"

test.component("teaser/Frequency").
  discuss("send one object 2 times in").
    send.connect("in").
      send.data("in", "a").
      send.data("in", "a").
    send.disconnect("in").
  discuss("get back the object with count 2").
    receive.connect("out").
      receive.data("out", [{ip: "a", count: 2}]).
    receive.disconnect("out").

  next().
  discuss("send 2 different objects").
    send.connect("in").
      send.data("in", "first").
      send.data("in", "second").
    send.disconnect("in").
  discuss("get both out, each with count 1").
    receive.connect("out").
      receive.data("out", [{ip: 'first', count: 1},{ip: 'second', count: 1}]).
    receive.disconnect("out").

export module
