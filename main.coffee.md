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
      Locosto.store file, engine.addItem

    $(document).pasteImageReader handleImage
    $(document).dropImageReader handleImage

    window.engine = engine
