Locosto
=======

Remember SHAs of resources.

    Storage = require "storage"

    storage = Storage.new "StarWipe"

    # Name -> SHA1 mapping
    key = "image_sha_names"
    names = storage.get(key) or {}

    remember = (name, sha) ->
      names[name] = sha
      persist()

    forget = (name) ->
      delete names[name]
      persist()

    persist = ->
      storage.set key, names

    # If you call crossOrigin, but use the url in a normal request rather than a cross
    # origin request CloudFront will cache the wrong headers making it unusable, so don't
    # make a mistake!
    urlForSha = (sha, crossOrigin=false) ->
      n = parseInt(sha.split("/").last().substring(0, 1), 16) % 4

      url = "http://a#{n}.pixiecdn.com/#{sha}"

      if crossOrigin
        "#{url}?#{location.host}"
      else
        url

    module.exports = Locosto =
      url: (name) ->
        if sha = names[name]
          urlForSha(sha)

      sprite: (name) ->
        if url = Locosto.url(name)
          Sprite.load url

      forget: forget

      remember: remember

      names: ->
        names
