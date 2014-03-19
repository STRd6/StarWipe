Setup
=====

Set up our runtime styles and expose some stuff for debugging.

    # For debug purposes
    global.PACKAGE = PACKAGE
    global.require = require

    # TODO: HAX
    {extend} = require "./lib/util"
    extend Object,
      extend: extend
    
    {Resource} = require "dust"

    global.Sprite = Resource.Sprite

    # Prevent browser contextmenu from popping up in games.
    document.oncontextmenu = -> false

    # Prevent default keypresses except for input fields
    $(document).bind "keydown", (event) ->
      event.preventDefault() unless $(event.target).is "input"
