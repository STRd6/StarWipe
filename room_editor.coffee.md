Room Editor
===========

Switch between rooms and edit them.

    module.exports = (I={}, self) ->
      choice = 0

      rooms = []

      changeRoom = (newChoice) ->
        if newChoice != choice
          rooms[choice] = self.saveState()
          choice = newChoice
          self.loadState(rooms[choice] or [])

      self.on "overlay", (canvas) ->
        canvas.drawText
          color: "white"
          font: "24px bold consolas, monospace"
          x: 50
          y: 50
          text: "Room: ##{choice}"

      self.on "update", ->
        newChoice = null

        [0..9].forEach (key) ->  
          if justPressed[key]
            newChoice = key

        if newChoice?
          changeRoom newChoice
