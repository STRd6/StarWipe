SHA1 = require "../lib/sha1"

describe "SHA1", ->
  it "should hash stuff", ->
    hash = SHA1("").toString()
    
    assert hash
