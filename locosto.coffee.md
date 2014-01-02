Locosto
=======

Store blobs locally and uploadeds them to S3

    CryptoJS = require "./lib/crypto"
    SHA1 = CryptoJS.SHA1

    # Name -> SHA1 mapping
    key = "image_sha_names"
    try
      names = JSON.parse(localStorage[key])
    catch
      names = {}

    remember = (name, sha) ->
      names[name] = sha
      persist()

    forget = (name) ->
      delete names[name]
      persist()

    persist = ->
      localStorage[key] = JSON.stringify(names)

    # If you call crossOrigin, but use the url in a normal request rather than a cross
    # origin request CloudFront will cache the wrong headers making it unusable, so don't
    # make a mistake!
    urlForSha = (sha, crossOrigin=false) ->
      n = parseInt(sha.substring(0, 1), 16) % 4

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

      store: (file, completed) ->
        blobTypedArray file, (arrayBuffer) ->
          sha = SHA1(CryptoJS.lib.WordArray.create(arrayBuffer)).toString()

          uploadBlobby file, ->
            completed?(sha)

      forget: forget

      names: ->
        names

    blobTypedArray = (blob, fn) ->
      reader = new FileReader()

      reader.onloadend = ->
        fn?(reader.result)

      reader.readAsArrayBuffer(blob)

    uploadBlobby = (blob, complete) ->
      url = "http://addressable.herokuapp.com"
      # url = "http://locohost:9393"

      form = new FormData
      form.append "data", blob

      request = new XMLHttpRequest()

      request.onload = ->
        complete?()

      request.open("POST", url)
      request.send(form)
