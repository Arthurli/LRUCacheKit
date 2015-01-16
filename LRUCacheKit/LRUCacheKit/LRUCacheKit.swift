//
//  LRUCacheKit.swift
//  LRUCacheKit
//
//  Created by Arthur on 15/1/10.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

import Foundation

var defaultKit:LRUCacheKit?
let defaultCacheNumber:Int = 25

class LRUCacheKit {
    
    //MARK: - CacheObject -
    class LRUCacheObject {
        var prevObject: Wrapped? = nil
        var nextObject: Wrapped? = nil
        var object: AnyObject!
        var cacheKey: String!
        
        init(_ object:AnyObject!, cacheKey:String!) {
            self.object = object
            self.cacheKey = cacheKey
        }
    }
    
    class Wrapped {
        var cache:LRUCacheObject
        
        init(_ cacheObject:LRUCacheObject!) {
            self.cache = cacheObject
        }
    }
    
    
    //MARK: - param -

    var cachePool : [String:LRUCacheObject] = Dictionary()
    var cacheNumber : Int = defaultCacheNumber
    var firstCache : LRUCacheObject?
    var lastCache : LRUCacheObject?
    
    //MARK: - Class function -
    class func defaultCacheKit() -> LRUCacheKit {
        if defaultKit == nil {
            defaultKit = LRUCacheKit();
        }
        
        return defaultKit!
    }
    
    class func setCacheObject(cacheObject:AnyObject!, byKey key:String!) -> Void {
        var kit : LRUCacheKit = LRUCacheKit.defaultCacheKit()
        var cache : LRUCacheObject! = LRUCacheObject( cacheObject, cacheKey: key)
        if kit.cachePool[key] != nil {
            kit.removeCacheByKey(key)
        }
        kit.addNewCache(cache, byKey: key)
    }
    
    class func cacheObjectByKey(key:String!) -> AnyObject? {
        
        var kit : LRUCacheKit = LRUCacheKit.defaultCacheKit();
        var cache : LRUCacheObject?
        cache = kit.cachePool[key]
        
        if cache != nil {
            kit.removeCacheByKey(key)
            kit.addNewCache(cache, byKey: key)
        }
        
        return cache?.object
    }
    
    class func showDescription() {
        var kit : LRUCacheKit = LRUCacheKit.defaultCacheKit()
        var object: LRUCacheObject? = kit.firstCache
        
        if object != nil {
            print("\(object?.cacheKey) ")
        }
        
        while (object?.nextObject != nil) {
            print("\(object?.nextObject?.cache.cacheKey) ")
            object = object?.nextObject?.cache
        }
        
        println("\n \(kit.cachePool.count) \n-------")
    }
    
    class func setCacheNumber(cacheNumber:Int!) {
        var kit : LRUCacheKit = LRUCacheKit.defaultCacheKit();
        kit.cacheNumber = cacheNumber
        
        if kit.lastCache != nil {
            while kit.cachePool.count > kit.cacheNumber {
                kit.removeCacheByKey(kit.lastCache!.cacheKey)
            }
        }
    }
    
    
    //MARK: - Add/Remove cache function -
    
    func addNewCache(cache:LRUCacheObject!, byKey key:String!) {
        
        var newCache = cache;
        
        if self.firstCache != nil {
            var originalFirst: LRUCacheObject = self.firstCache!
            newCache.nextObject = Wrapped(originalFirst)
            originalFirst.prevObject = Wrapped(newCache)
        }
        
        self.firstCache = newCache;
        
        if self.lastCache == nil {
            self.lastCache = newCache
        }
        
        self.cachePool[key] = newCache
        
        if self.cachePool.count > self.cacheNumber {
            self.removeCacheByKey(self.lastCache?.cacheKey)
        }
    }
    
    func removeCacheByKey(key:String!) {
        
        var cache : LRUCacheObject? = self.cachePool[key]
        if cache == nil {
            return;
        }
        
        var prevObject: Wrapped? = cache?.prevObject
        var nextObject: Wrapped? = cache?.nextObject
        
        if prevObject != nil && nextObject != nil {
            prevObject?.cache.nextObject = nextObject
            nextObject?.cache.prevObject = prevObject
        } else if prevObject != nil {
            self.lastCache = prevObject?.cache
            prevObject?.cache.nextObject = nil
        } else if nextObject != nil {
            self.firstCache = nextObject?.cache
            nextObject?.cache.prevObject = nil
        } else {
            self.lastCache = nil
            self.firstCache = nil
        }
        
        self.cachePool[cache!.cacheKey] = nil
    }
    
}