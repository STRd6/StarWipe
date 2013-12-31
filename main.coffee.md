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

    engine.add "Puppet",
      x: 500
      y: 278
      width: 100
      height: 100

    handleImage = ({dataURL, file}) ->

      # TODO: Store locally

      # Sync on addressable
      Locosto.store(file)

      # Add object to screen
      engine.add "Puppet",
        spriteURL: dataURL

    $(document).pasteImageReader handleImage
    $(document).dropImageReader handleImage
