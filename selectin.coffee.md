Selectin
========

    {extend} = require "dust/util"

    module.exports = (I={}, self) ->
      selected = null
      bounds =
        color: "rgba(255, 0, 255, 0.5)"

      self.on "update", ->
        if mousePressed.left
          startPosition = mousePosition.copy()
          selected = self.objectAtScreenPosition(startPosition)

      self.on "draw", (canvas) ->
        if selected
          extend bounds, selected.bounds()

          canvas.drawRect bounds

      self.on "update", ->
        if justPressed.del or justPressed.backspace
          selected?.destroy()
          selected = null

        if justPressed.return
          data = extend {}, selected?.I
          data.x += 20
          data.y += 20

          selected = self.add data

      return self
