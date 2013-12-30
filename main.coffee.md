Star Wipe
=========

    require "./setup"
    Dust = require "dust"

    {width, height} = require "./pixie"

    Puppet = require "./puppet"

    engine = Dust.init
      width: width
      height: height

    console.log Dust.GameObject

    engine.add "Puppet",
      x: 500
      y: 278
      width: 100
      height: 100
