S3 CAS
======

Store file blobs in a namespaced content addressable store.

    CryptoJS = require "./crypto"
    SHA1 = CryptoJS.SHA1

    module.exports =
      store: (namespace, file, completed) ->
        blobTypedArray file, (arrayBuffer) ->
          sha = SHA1(CryptoJS.lib.WordArray.create(arrayBuffer)).toString()

          uploadBlobby namespace, file, ->
            completed?("#{namespace}/#{sha}")

    blobTypedArray = (blob, fn) ->
      reader = new FileReader()

      reader.onloadend = ->
        fn?(reader.result)

      reader.readAsArrayBuffer(blob)

    uploadBlobby = (namespace, blob, complete) ->
      url = "http://addressable.herokuapp.com"
      # url = "http://locohost:9393"

      form = new FormData
      form.append "data", blob
      form.append "namespace", namespace

      request = new XMLHttpRequest()

      request.onload = ->
        complete?()

      request.open("POST", url)
      request.send(form)
