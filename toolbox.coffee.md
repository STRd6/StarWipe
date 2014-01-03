Toolbox
=======

    Locosto = require "./locosto"

    {floor, min} = Math

    # TODO: Item sets or scrollable items?
    # Page up/page down

    scaleToContain = (sprite, size) ->
      min 1, size / sprite.width, size / sprite.height

    module.exports = (I={}, self) ->
      items = Object.keys(Locosto.names()).map (name) ->
        name: name
        sprite: Locosto.sprite name
      selectedIndex = 0
      itemHeight = 72
      itemWidth = 72

      page = 0
      pageSize = 8

      self.on "overlay", (canvas) ->
        items.slice(page * pageSize, pageSize).forEach ({sprite}, i) ->
          scale = scaleToContain(sprite, itemHeight)
          position = Point(itemWidth/2, (i + 0.5) * itemHeight)
          canvas.withTransform Matrix.translation(position.x, position.y), ->
            canvas.withTransform Matrix.scale(scale), ->
              sprite.draw(canvas, -sprite.width/2, -sprite.height/2)

        if selectedIndex < items.length
          canvas.drawRect
            x: 0
            y: selectedIndex * itemHeight
            width: itemWidth
            height: itemHeight
            color: "rgba(0, 255, 255, 0.25)"

      self.on "update", ->
        if mousePressed.left
          position = mousePosition.copy()

          if position.x < itemWidth
            selectedIndex = floor position.y / itemHeight

        if mousePressed.right
          position = mousePosition.copy()

          if selectedIndex < items.length
            url = Locosto.url(items[selectedIndex].name)
            self.add
              class: "Puppet"
              spriteURL: url
              x: position.x
              y: position.y

        if justPressed.del
          if itemToRemove = items[selectedIndex + page * pageSize]
            items.remove(itemToRemove)
            Locosto.forget itemToRemove.name

        if justPressed.pageup
          page += 1

        if justPressed.pagedown
          page -= 1

      self.extend
        addItem: (sha) ->
          Locosto.remember sha, sha

          items.push
            name: sha
            sprite: Locosto.sprite sha
