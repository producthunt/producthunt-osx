//
//  PHStatusBarUpdater.swift
//  ProductHunt
//
//  Created by Vlado on 3/30/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa

class PHStatusBarUpdater: PHAppContextObserver {

    private var button: NSStatusBarButton?

    init(button: NSStatusBarButton?) {
        self.button = button
    }

    func contentChanged(updateType: UpdateType, context: PHAppContext) {
        guard let button = button, let posts = context.fetcher.todayPosts()  else {
            return
        }

        let sortedPosts = PHPostSorter.filter(posts, by: [.Seen(false), .Votes(PHUserDefaults.getFilterCount())])

        button.title = title(fromCount: sortedPosts.count)
    }

    private func title(fromCount count: Int) -> String {
        if !PHUserDefaults.getShowsCount() {
            return ""
        }

        return count > 9 ? "9+" : (count == 0 ? "" : "\(count)")
    }
}