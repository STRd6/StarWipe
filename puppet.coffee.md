Puppet
======

    GameObject = require("dust").GameObject
    Compositions = require("./lib/compositions")
    
    # TODO: Expose this more gracefully
    {defaults} = require "dust/util"

    Puppet = (I={}, self) ->
      defaults I,
        components: []

      self = GameObject(I)

      self.attrModels "components", Puppet

      self.on "draw", (canvas) ->
        self.components().invoke "draw", canvas

      # TODO: Extract to a module "autosize to sprite"
      self.on "update", ->
        if sprite = self.sprite()
          I.width = sprite.width
          I.height = sprite.height

      return self

    GameObject.registry.Puppet = Puppet

    GameObject.defaultModules.push Compositions

    module.exports = Puppet
