Keyframes
=========

Store animation info in keyframes

    {extend, defaults} = require "dust/util"
    {keys} = Object

    lerp = (a, b, t) ->
      a + (b - a) * t

    module.exports = (I={}, self) ->
      I.keyframes ?= {}

      initialName = "0.00"

      # Ensure initial keyframe
      I.keyframes[initialName] ?=
        x: I.x
        y: I.y

      keyframeNames = ->
        keys I.keyframes

      previousFrameTime = (timeName) ->
        keyframeNames().filter (key) ->
          key < timeName
        .last()

      nextFrameTime = (timeName) ->
        keyframeNames().filter (key) ->
          key >= timeName
        .first()

      self.extend
        setKeyframe: (tName, properties) ->
          I.keyframes[tName] = properties

        applyKeyframe: (tName) ->
          prevTimeName = previousFrameTime(tName) or initialName
          nextTimeName = nextFrameTime(tName) or initialName

          if prevTimeName != nextTimeName
            prevKeyframe = I.keyframes[prevTimeName]
            nextKeyframe = I.keyframes[nextTimeName]

            initialTime = parseFloat(prevTimeName)
            finalTime = parseFloat(nextTimeName) or 1 # Wraps 0 to 1
            duration = finalTime - initialTime
            t = (parseFloat(tName) - initialTime) / duration

            keys(prevKeyframe).forEach (propertyName) ->
              initialValue = prevKeyframe[propertyName]
              finalValue = nextKeyframe[propertyName]

              lerp(initialValue, finalValue, t)
