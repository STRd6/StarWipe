Room Editor
===========

Switch between rooms and edit them.

    Storage = require "storage"
    storage = Storage.new "StarWipe"

    key = "room_data"
    rooms = storage.get(key) or []

    persist = ->
      storage.set key, rooms

    module.exports = (I={}, self) ->
      choice = 0
      frame = 0
      frameStep = 4
      FPS = 60

      t = ->
        (frame / FPS).toFixed(2)

      self.loadState(rooms[choice] or [])

      changeRoom = (newChoice) ->
        if newChoice != choice
          rooms[choice] = self.saveState()
          choice = newChoice
          self.loadState(rooms[choice] or [])

      self.on "overlay", (canvas) ->
        canvas.drawText
          color: "white"
          font: "24px bold consolas, monospace"
          x: 850
          y: 50
          text: "Room: ##{choice}"

        canvas.drawText
          color: "white"
          font: "24px bold consolas, monospace"
          x: 850
          y: 25
          text: "t = #{t()}"

      self.on "update", ->
        newChoice = null

        [0..9].forEach (key) ->
          if justPressed[key]
            newChoice = key

        if newChoice?
          changeRoom newChoice
          persist()

        if justPressed["="] and keydown.shift
          frame += frameStep

        if justPressed["-"]
          frame -= frameStep

        frame = frame.clamp(0, FPS - frameStep)

        self.applyKeyframes()

      self.extend
        setKeyframe: (object, properties) ->
          object.setKeyframe t(), properties

        applyKeyframes: ->
          self.objects().forEach (object) ->
            object.applyKeyframe(t())
