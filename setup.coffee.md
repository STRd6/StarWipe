Setup
=====

Set up our runtime styles and expose some stuff for debugging.

    # For debug purposes
    global.PACKAGE = PACKAGE
    global.require = require

    # TODO: HAX
    {extend} = require "dust/util"
    extend Object,
      extend: extend