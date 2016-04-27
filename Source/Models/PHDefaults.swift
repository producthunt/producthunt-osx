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

    private let kAutoLoginKey = "autoLoginKey"
    private let kShowCountKey = "showBadgeCount"
    private let kFilterCountKey = "filterPostsCount"

    private let kSeenPostsKey = "seenPostsKey"
    private let kSeenPostsKeyDate = "seenPostsDate"
    private let kSeenPostsKeyIds = "seenPostsDateIds"

    private let kTokenKey = "oauthToken"
    private let kTokenKeyDate = "expirationDate"
    private let kTokenKeyAccess = "accessToken"

    init() {
        migrate()

        store.dispatch( PHSettingsSetAction(settings: readSettings()) )
        store.dispatch( PHSeenPostsSetAction(seenPost: readSeenPosts()) )
        store.dispatch( PHTokenGet(token: readToken()) )

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

        set([ kTokenKeyDate: state.token.expirationDate, kTokenKeyAccess: state.token.accessToken], key: kTokenKey)
    }

    private func readSettings() -> PHSettings {
        let autologinEnabled    = get(kAutoLoginKey, objectType: Bool()) ?? true
        let showCountKey        = get(kShowCountKey, objectType: Bool()) ?? true
        let filterCount         = get(kFilterCountKey, objectType: Int()) ?? 10

        return PHSettings(autologinEnabled: autologinEnabled, showsCount: showCountKey, filterCount: filterCount)
    }

    private func readSeenPosts() -> PHSeenPosts {
        let data = get( kSeenPostsKey, objectType: [String : AnyObject]() ) ?? [String : AnyObject]()

        var day = NSDate()
        var ids = Set<Int>()

        if let date = data[kSeenPostsKeyDate] as? NSDate {
            day = date
        }

        if let postIds = data[kSeenPostsKeyIds] as? [Int] {
            ids = Set(postIds)
        }

        return PHSeenPosts(date: day, postIds: ids)
    }

    private func readToken() -> PHToken {
        let data = get(kTokenKey, objectType: [String : AnyObject]()) ?? [String : AnyObject]()

        var access = ""
        var date = NSDate(timeIntervalSince1970: 0)

        if let accessToken = data[kTokenKeyAccess] as? String {
            access = accessToken
        }

        if let expirationDate = data[kTokenKeyDate] as? NSDate {
            date = expirationDate
        }

        return PHToken(accessToken: access, expirationDate: date)
    }

    // TODO: Remove migrate in V1.1
    private func migrate() {
        let deprecatedTokenKey          = "authToken"
        let deprecatedShowsCountKey     = "showsCount"
        let deprecatedFilterCountKey    = "filterCount"
        let deprecatedAutoLoginKey      = "autoLogin"
        let deprecatedSeenPostsKey      = "seenPosts"
        let deprecatedLastUpdatedKey    = "lastUpdatedDate"

        if let tokenData =  get(deprecatedTokenKey, objectType: [String : AnyObject]()), let token = PHToken.token(fromDictionary: tokenData) {
            set([ kTokenKeyDate: token.expirationDate, kTokenKeyAccess: token.accessToken], key: kTokenKey)
        }

        if let showsCount = get(deprecatedShowsCountKey, objectType: Bool()) {
            set(showsCount, key: kShowCountKey)
        }

        if let filterCount = get(deprecatedFilterCountKey, objectType: Int()) {
            set(filterCount, key: kFilterCountKey)
        }

        if let autologin = get(deprecatedAutoLoginKey, objectType: Bool()) {
            set(autologin, key: kAutoLoginKey)
        }

        if let seenPosts = get(deprecatedSeenPostsKey, objectType: [String : [Int]]()), let key = seenPosts.keys.first, let date = NSDate(ISO8601String: key), let ids = seenPosts[key] {
            set([ kSeenPostsKeyDate: date, kSeenPostsKeyIds: ids ], key: kSeenPostsKey)
        }

        remove(deprecatedTokenKey)
        remove(deprecatedShowsCountKey)
        remove(deprecatedFilterCountKey)
        remove(deprecatedAutoLoginKey)
        remove(deprecatedSeenPostsKey)
        remove(deprecatedLastUpdatedKey)
    }

    private func set(object: AnyObject, key: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(object, forKey: key)
        defaults.synchronize()
    }

    private func get<T>(key: String, objectType: T) -> T? {
        guard let object = NSUserDefaults.standardUserDefaults().objectForKey(key) as? T else {
            return nil
        }

        return object
    }

    private func remove(key: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey(key)
        defaults.synchronize()
    }
}