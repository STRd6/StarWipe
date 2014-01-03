Keyframes
=========

Store animation info in keyframes

    {extend, defaults} = require "dust/util"

    module.exports = (I={}, self) ->
      I.keyframes ?= {}

      self.extend
        setKeyframe: (t, properties) ->
          I.keyframes[t] = properties

        applyKeyframe: (t) ->
          # TODO: Tweening
          extend I, (I.keyframes[t] or {})
