//
//  PHStatusBarUpdater.swift
//  ProductHunt
//
//  Created by Vlado on 3/30/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa
import ReSwift

class PHStatusBarUpdater: StoreSubscriber {

    private var button: NSStatusBarButton?
    private var store: Store<PHAppState>

    init(button: NSStatusBarButton?, store: Store<PHAppState>) {
        self.button = button
        self.store = store

        store.subscribe(self)
    }

    deinit {
        store.unsubscribe(self)
    }

    func newState(state: PHAppState) {
        updateTitle()
    }

    private func updateTitle() {
        guard let button = button, let posts = store.state.posts.todayPosts  else {
            return
        }

        let sortedPosts = PHPostSorter.filter(store, posts: posts, by: [.Seen(false), .Votes(store.state.settings.filterCount)])

        button.title = title(fromCount: sortedPosts.count)
    }

    private func title(fromCount count: Int) -> String {
        if !store.state.settings.showsCount {
            return ""
        }

        return count > 9 ? "9+" : (count == 0 ? "" : "\(count)")
    }
}