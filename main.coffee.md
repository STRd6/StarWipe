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

    Object.keys(Locosto.names()).forEach (name) ->
      engine.add "Puppet",
        x: width/2
        y: height/2
        width: 100
        height: 100
        spriteURL: Locosto.url(name)
