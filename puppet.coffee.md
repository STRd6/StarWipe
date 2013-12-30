Puppet
======

    GameObject = require("dust").GameObject

    Puppet = (I={}, self) ->

      console.log "radical!"
    
      self = GameObject(I)

    GameObject.registry.Puppet = Puppet

    module.exports = Puppet
