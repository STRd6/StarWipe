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
      t = 0

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

      self.on "update", ->
        newChoice = null

        [0..9].forEach (key) ->
          if justPressed[key]
            newChoice = key

        if newChoice?
          changeRoom newChoice
          persist()
