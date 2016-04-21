//
//  PHPostsDataSource.swift
//  ProductHunt
//
//  Created by Vlado on 3/15/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

protocol PHDataSourceDelegate {
    func contentChanged(updateType: UpdateType)
}

class PHPostsDataSource: PHAppContextObserver {

    var delegate: PHDataSourceDelegate?

    private var content = [AnyObject]()
    private var context: PHAppContext

    init(context: PHAppContext) {
        self.context = context
        context.addObserver(self)
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
        context.fetcher.loadNewer()
    }

    func loadOlder() {
        context.fetcher.loadOlder()
    }

    func contentChanged(updateType: UpdateType, context: PHAppContext) {
        content = flatContent(context.fetcher.content)
        delegate?.contentChanged(updateType)
    }

    private func flatContent(content: [PHSection]) -> [AnyObject] {
        let formatter = PHDateFormatter()
        var output = [AnyObject]()

        content.forEach { (section) in
            output.append(formatter.format(withDateString: section.day) ?? "")

            PHPostSorter.sort(section.posts, votes: PHUserDefaults.getFilterCount()).forEach({ (post) in
                output.append(post)
            })
        }

        return output
    }
}
