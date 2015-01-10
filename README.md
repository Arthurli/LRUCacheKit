# LRUCacheKit
A sample LRU cache kit

~~~
  //Setup cache number
  LRUCacheKit.setCacheNumber(5)

  //Save cache
  for  a:Int in array {
    LRUCacheKit.setCacheObject(a, byKey: String(a))
    LRUCacheKit.showDescription()
  }
  
  //Get cache
  var b: AnyObject? = LRUCacheKit.cacheObjectByKey(String(a))

        
   //Change cache number
  LRUCacheKit.setCacheNumber(3)
  LRUCacheKit.showDescription()

~~~
