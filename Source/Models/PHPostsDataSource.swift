//
//  PHPostsDataSource.swift
//  ProductHunt
//
//  Created by Vlado on 3/15/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation
import ReSwift

protocol PHDataSourceDelegate {
    func contentChanged()
}

class PHPostsDataSource: StoreSubscriber {

    var delegate: PHDataSourceDelegate?

    private var store: Store<PHAppState>
    private var content = [AnyObject]()

    init(store: Store<PHAppState>) {
        self.store = store

        store.subscribe(self)
    }

    deinit {
        store.unsubscribe(self)
    }

    func newState(state: PHAppState) {
        content = flatContent(state.posts.sections)
        delegate?.contentChanged()
    }

    func numberOfRows() -> Int {
        return content.count
    }

    func data(atIndex index: Int) -> AnyObject? {
        return content[index]
    }

    func isGroup(atIndex index: Int) -> Bool {
        return (content[index] as? String) != nil
    }

    func loadNewer() {
        PHLoadPostOperation.performNewer(store)
    }

    func loadOlder() {
        PHLoadPostOperation.performOlder(store)
    }

    private func flatContent(content: [PHSection]) -> [AnyObject] {
        let formatter = PHDateFormatter()
        var output = [AnyObject]()

        content.forEach { (section) in
            output.append(formatter.format(withDateString: section.day) ?? "")

            PHPostSorter.sort(store, posts: section.posts, votes: store.state.settings.filterCount).forEach({ (post) in
                output.append(post)
            })
        }

        return output
    }
}
