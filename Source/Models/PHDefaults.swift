//
//  PHDefaults.swift
//  Product Hunt
//
//  Created by Vlado on 4/28/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation
import ISO8601
import ReSwift

class PHDefaults: StoreSubscriber {

    fileprivate let kAutoLoginKey = "autoLoginKey"
    fileprivate let kShowCountKey = "showBadgeCount"
    fileprivate let kFilterCountKey = "filterPostsCount"

    fileprivate let kSeenPostsKey = "seenPostsKey"
    fileprivate let kSeenPostsKeyDate = "seenPostsDate"
    fileprivate let kSeenPostsKeyIds = "seenPostsDateIds"

    fileprivate let kTokenKey = "oauthToken"
    fileprivate let kTokenKeyAccess = "accessToken"

    fileprivate var store: Store<PHAppState>

    init(store: Store<PHAppState>) {
        self.store = store

        migrate()

        store.dispatch( PHSettingsSetAction(settings: readSettings()) )
        store.dispatch( PHSeenPostsSetAction(seenPost: readSeenPosts()) )
        store.dispatch( PHTokenGetAction(token: readToken()) )

        store.subscribe(self)
    }

    deinit {
        store.unsubscribe(self)
    }

    func newState(state: PHAppState) {
        set(state.settings.autologinEnabled, key: kAutoLoginKey)
        set(state.settings.showsCount, key: kShowCountKey)
        set(state.settings.filterCount, key: kFilterCountKey)

        set([ kSeenPostsKeyDate: state.seenPosts.date, kSeenPostsKeyIds: Array(state.seenPosts.postIds) ], key: kSeenPostsKey)

        set([kTokenKeyAccess: state.token.accessToken], key: kTokenKey)
    }

    fileprivate func readSettings() -> PHSettings {
        let autologinEnabled    = get(kAutoLoginKey, objectType: Bool()) ?? true
        let showCountKey        = get(kShowCountKey, objectType: Bool()) ?? true
        let filterCount         = get(kFilterCountKey, objectType: Int()) ?? 10

        return PHSettings(autologinEnabled: autologinEnabled, showsCount: showCountKey, filterCount: filterCount)
    }

    fileprivate func readSeenPosts() -> PHSeenPosts {
        let data = get( kSeenPostsKey, objectType: [String : AnyObject]() ) ?? [String : AnyObject]()

        var day = Date()
        var ids = Set<Int>()

        if let date = data[kSeenPostsKeyDate] as? Date {
            day = date
        }

        if let postIds = data[kSeenPostsKeyIds] as? [Int] {
            ids = Set(postIds)
        }

        return PHSeenPosts(date: day, postIds: ids)
    }

    fileprivate func readToken() -> PHToken {
        let data = get(kTokenKey, objectType: [String : AnyObject]()) ?? [String : AnyObject]()

        var access = ""

        if let accessToken = data[kTokenKeyAccess] as? String {
            access = accessToken
        }

        return PHToken(accessToken: access)
    }

    // TODO: Remove migrate in V1.1
    fileprivate func migrate() {
        let deprecatedTokenKey          = "authToken"
        let deprecatedShowsCountKey     = "showsCount"
        let deprecatedFilterCountKey    = "filterCount"
        let deprecatedAutoLoginKey      = "autoLogin"
        let deprecatedSeenPostsKey      = "seenPosts"
        let deprecatedLastUpdatedKey    = "lastUpdatedDate"

        if let tokenData =  get(deprecatedTokenKey, objectType: [String : Any]()), let token = PHToken.token(fromDictionary: tokenData) {
            set([kTokenKeyAccess: token.accessToken], key: kTokenKey)
        }

        if let showsCount = get(deprecatedShowsCountKey, objectType: Bool()) {
            set(showsCount as AnyObject, key: kShowCountKey)
        }

        if let filterCount = get(deprecatedFilterCountKey, objectType: Int()) {
            set(filterCount as AnyObject, key: kFilterCountKey)
        }

        if let autologin = get(deprecatedAutoLoginKey, objectType: Bool()) {
            set(autologin as AnyObject, key: kAutoLoginKey)
        }

        if let seenPosts = get(deprecatedSeenPostsKey, objectType: [String : [Int]]()), let key = seenPosts.keys.first, let date = NSDate(iso8601String: key), let ids = seenPosts[key] {
            set([ kSeenPostsKeyDate: date, kSeenPostsKeyIds: ids ], key: kSeenPostsKey)
        }

        remove(deprecatedTokenKey)
        remove(deprecatedShowsCountKey)
        remove(deprecatedFilterCountKey)
        remove(deprecatedAutoLoginKey)
        remove(deprecatedSeenPostsKey)
        remove(deprecatedLastUpdatedKey)
    }

    fileprivate func set(_ object: Any, key: String) {
        let defaults = UserDefaults.standard
        defaults.set(object, forKey: key)
        defaults.synchronize()
    }

    fileprivate func get<T>(_ key: String, objectType: T) -> T? {
        guard let object = UserDefaults.standard.object(forKey: key) as? T else {
            return nil
        }

        return object
    }

    fileprivate func remove(_ key: String) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
}
