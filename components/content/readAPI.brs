
sub GetContent() as object
    print "INSIDE READAPI"

      url = "https://staging.api.showms.com/programming/homepage"
    	request = createObject("roUrlTransfer")
    	if left(url, 5) = "https" then
      ' set https certificate
    		request.setCertificatesFile("common:/certs/ca-bundle.crt")
    		request.initClientCertificates()
    	end if
    	request.addHeader("api-version", "2018-07-19")
      request.setURL(url)
    	response = request.getToString()

      json = parseJSON(response)

      rootNodeArray = ParseJsonToNodeArray(json)
      m.top.content.AppendChildren(rootNodeArray)
end sub

function ParseJsonToNodeArray(jsonAA as Object) as Object
      if jsonAA = invalid then return []

      for each fieldInJsonAA in jsonAA
        if fieldInJsonAA = "collections"
        collectionsItemsArray = jsonAA[fieldInJsonAA]
        collectionsNodeArray = []

          for each collection in collectionsItemsArray
            resultArray = []
            collectionNode = ParseMediaItemNode(collection, fieldInJsonAA)
            ' print "title", collection.title
            collectionsNodeArray.push(collectionNode)
          end for
          ' print "collectionsNodeArray", collectionsNodeArray
          ' print "collectionsNodeArray", collectionsNodeArray[0]
          ' print "collectionsNodeArray", collectionsNodeArray[0].items[0]
          return collectionsNodeArray
        end if
      end for
end Function

function ParseMediaItemNode(collection as Object, fieldType as String) as Object
  collectionNode = Utils_AAToContentNode({
    "title": collection.title
    "apiEndpoint": collection.apiEndpoint
  })
  items = collection.Items
  itemsArray = []
  for each item in items
    itemNode = Utils_AAToContentNode(item)
    Utils_forceSetFields(itemNode, {
      "hdPosterUrl": item.images[0].sizes[0].url
      ' "fhdPosterUrl": mediaItem.thumbnail
      ' "description": item.description
    })

    itemsArray.push(itemNode)
  end for
  collectionNode.AppendChildren(itemsArray)
  Utils_forceSetFields(collectionNode, {
    "items": itemsArray
  })
  return collectionNode
end function
