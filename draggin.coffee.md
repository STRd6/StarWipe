Draggin
=======

An engine module that allows "drag to move" for objects.

    module.exports = (I={}, self) ->
      active = null
      startPosition = null
      objectStartPosition = null

      self.on "update", ->
        if mousePressed.left
          startPosition = mousePosition.copy()
          if active = self.objectAtScreenPosition(startPosition)
            objectStartPosition = active.position()
        else if mouseDown.left
          # Drag
          if active
            delta = mousePosition.subtract(startPosition)
            newPosition = objectStartPosition.add(delta)

            active.position(newPosition)
        else if mouseReleased.left
          active = null

      ascendingZIndex = (a, b) ->
        a.I.zIndex - b.I.zIndex

      self.extend
        # Get the object at a given screen position
        objectAtScreenPosition: (screenPosition) ->
          # TODO: Camera transforms
          self.objectsUnderPoint(screenPosition).sort(ascendingZIndex).last()

      return self
