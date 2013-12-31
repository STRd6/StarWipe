Puppet
======

    GameObject = require("dust").GameObject

    Puppet = (I={}, self) ->
      self = GameObject(I)

    GameObject.registry.Puppet = Puppet

    module.exports = Puppet
