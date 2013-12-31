Locosto
=======

Store blobs locally until they've been uploaded to S3

    SHA1 = require "./lib/sha1"

    # Name -> SHA1 mapping
    key = "image_sha_names"
    try
      names = JSON.parse(localStorage[key])
    catch
      names = {}

    remember = (name, sha) ->
      names[name] = sha

      localStorage[key] = JSON.stringify(names)

    # If you call crossOrigin, but use the url in a normal request rather than a cross
    # origin request CloudFront will cache the wrong headers making it unusable, so don't
    # make a mistake!
    url = (sha, crossOrigin=false) ->
      n = parseInt(sha.substring(0, 1), 16) % 4

      url = "http://a#{n}.pixiecdn.com/#{sha}"

      if crossOrigin
        "#{url}?#{location.host}"
      else
        url

    module.exports =
      sprite: (name) ->
        if sha = names[name]
          Sprite.load url(sha)

      store: (file) ->
        # TODO: S
        blobTypedArray file, (arrayBuffer) ->
          sha = SHA1(arrayBuffer).toString()
          console.log sha

          # TODO: Save SHA as a key
          remember(sha, sha)

          uploadBlobby(file)

      names: ->
        names

    blobTypedArray = (blob, fn) ->
      reader = new FileReader()

      reader.onloadend = ->
        result =
        console.log(reader.result)
        fn?(reader.result)

      reader.readAsArrayBuffer(blob)

    uploadBlobby = (blob) ->
      url = "http://addressable.herokuapp.com"
      # url = "http://locohost:9393"

      form = new FormData
      form.append "data", blob

      request = new XMLHttpRequest()
      request.open("POST", url)
      request.send(form)
