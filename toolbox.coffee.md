Toolbox
=======

    Locosto = require "./locosto"

    {floor} = Math

    module.exports = (I={}, self) ->
      names = Object.keys(Locosto.names())
      items = names.map Locosto.sprite
      selectedIndex = 0
      itemHeight = 100
      itemWidth = 100

      self.on "overlay", (canvas) ->
        items.forEach (sprite, i) ->
          sprite.draw(canvas, -sprite.width/2, i * itemHeight - sprite.height/2)

        if selectedIndex < items.length
          canvas.drawRect
            x: 0
            y: selectedIndex * itemHeight
            width: 100
            height: 100
            color: "rgba(0, 255, 255, 0.25)"

      self.on "update", ->
        if mousePressed.left
          position = mousePosition.copy()

          if position.x < itemWidth
            selectedIndex = floor position.y / itemHeight

        if mousePressed.right
          position = mousePosition.copy()

          if selectedIndex < items.length
            url = Locosto.url(names[selectedIndex])
            self.add
              class: "Puppet"
              spriteURL: url
              x: position.x
              y: position.y
