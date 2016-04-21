//
//  PHUserDefaults.swift
//  ProductHunt
//
//  Created by Vlado on 3/17/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

class PHUserDefaults {

    static let kDefaultFilterCount = 10

    static let lastUpdatedKey       = "lastUpdatedDate"
    static let seenPostsKey         = "seenPosts"
    static let showsCountKey        = "showsCount"
    static let autoLoginKey         = "autoLogin"
    static let alreadyLaunchedKey   = "alreadyLaunched"
    static let tokenKey             = "authToken"
    static let filterCount          = "filterCount"

    // MARK: Last updated

    class func setLastUpdated(date: NSDate = NSDate()) {
        set(date, key: lastUpdatedKey)
    }

    class func getLastUpdated() -> NSDate {
        return self.get(lastUpdatedKey, objectType: NSDate()) ?? NSDate()
    }

    // MARK: Seen posts

    class func setSeenPosts(posts: [String : [Int]]) {
        set(posts, key: seenPostsKey)
    }

    class func getSeenPosts() -> [String : AnyObject] {
        return get(seenPostsKey, objectType: [String : [Int]]()) ?? [NSDate().ISO8601String()! : [Int]()]
    }

    // MARK: Shows count

    class func setShowsCount(showsCount: Bool) {
        set(showsCount, key: showsCountKey)
    }

    class func getShowsCount() -> Bool {
        return get(showsCountKey, objectType: Bool()) ?? true
    }

    // MARK: Auto login

    class func setAutoLogin(enabled: Bool) {
         set(enabled, key: autoLoginKey)
    }

    class func getAutoLogin() -> Bool {
        return get(autoLoginKey, objectType: Bool()) ?? false
    }

    // MARK: First time launch

    class func setAlreadyLaunched(launched: Bool) {
        set(launched, key: alreadyLaunchedKey)
    }

    class func getAlreadyLaunched() -> Bool {
        return get(alreadyLaunchedKey, objectType: Bool()) ?? false
    }

    // MARK: Token

    class func setTokenData(data: [String : AnyObject]) {
        set(data, key: tokenKey)
    }

    class func getTokenData() -> [String : AnyObject] {
        return get(tokenKey, objectType: [String : AnyObject]()) ?? [String : AnyObject]()
    }

    // MARK: Filter votes

    class func setFilterCount(count: Int) {
        set(count, key: filterCount)
    }

    class func getFilterCount() -> Int {
        return get(filterCount, objectType: Int()) ?? kDefaultFilterCount
     }

    // MARK: Defaults behaviour

    class func registerDefaults() {
        setLastUpdated(NSDate())
        setSeenPosts([NSDate().ISO8601String()! : [Int]()])
        setShowsCount(true)
        setAutoLogin(true)
        setFilterCount(10)
    }

    class func resetUserDefaults() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(lastUpdatedKey)
        NSUserDefaults.standardUserDefaults().removeObjectForKey(seenPostsKey)
        NSUserDefaults.standardUserDefaults().removeObjectForKey(filterCount)
    }

    // MARK: Helpers

    private class func set(object: AnyObject, key: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(object, forKey: key)
        defaults.synchronize()
    }

    private class func get<T>(key: String, objectType: T) -> T? {
        guard let object = NSUserDefaults.standardUserDefaults().objectForKey(key) as? T else {
            return nil
        }

        return object
    }
}