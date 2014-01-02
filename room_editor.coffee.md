Room Editor
===========

Switch between rooms and edit them.

    # Name -> SHA1 mapping
    key = "image_sha_names"
    try
      names = JSON.parse(localStorage[key])
    catch
      names = {}

    remember = (name, sha) ->
      names[name] = sha
      persist()

    forget = (name) ->
      delete names[name]
      persist()

    persist = ->
      localStorage[key] = JSON.stringify(names)

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
