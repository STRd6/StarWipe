Star Wipe
=========

    require "./setup"
    Dust = require "dust"
    
    Locosto = require "./locosto"

    {width, height} = require "./pixie"

    Puppet = require "./puppet"

    engine = Dust.init
      width: width
      height: height

    engine.include require "./draggin"
    engine.include require "./selectin"
    engine.include require "./room_editor"
    engine.include require "./toolbox"

    handleImage = ({dataURL, file}) ->
      # Sync on addressable
      Locosto.store(file)

      # Add object to screen
      engine.add "Puppet",
        x: width/2
        y: height/2
        width: 100
        height: 100
        spriteURL: dataURL

    $(document).pasteImageReader handleImage
    $(document).dropImageReader handleImage

    engine.add "Puppet",
      width: 200
      height: 200
      x: width/2
      y: height/2
      spriteURL: Locosto.url("62f8bdd7c28650a2b77393f37792fd39cd3121b9")
      components: [{
        class: "Puppet"
        x: width/2
        spriteURL: Locosto.url("62f8bdd7c28650a2b77393f37792fd39cd3121b9")
      }, {
        class: "Puppet"
        x: -width/2
        spriteURL: Locosto.url("62f8bdd7c28650a2b77393f37792fd39cd3121b9")
      }]

    window.engine = engine
