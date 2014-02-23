Star Wipe
=========

    require "./setup"
    Dust = require "dust"

    S3CAS = require "./lib/s3cas"

    {width, height} = require "./pixie"

    # Need to require to register constructor
    require "./puppet"

    engine = Dust.init
      width: width
      height: height

    engine.include require "./draggin"
    engine.include require "./selectin"
    engine.include require "./room_editor"
    engine.include require "./toolbox"

    namespace = "starwipe"

    handleImage = ({file}) ->
      S3CAS.store namespace, file, engine.addItem

    $(document).pasteImageReader handleImage
    $(document).dropImageReader handleImage

    window.engine = engine
