//
//  PHAppContext.swift
//  Product Hunt
//
//  Created by Vlado on 4/19/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation

enum UpdateType {
    case Newer, Older, Error
}

protocol PHAppContextObserver: class, AnyObject {
    func contentChanged(updateType: UpdateType, context: PHAppContext)
}

class PHAppContext {

    static let sharedInstance = PHAppContext()

    var fetcher: PHPostFetcher!

    private var observers = [PHAppContextObserverWrapper]()

    init() {
        fetcher = PHPostFetcher(context: self)
    }

    func addObserver(observer: PHAppContextObserver) {
        observers.append(PHAppContextObserverWrapper(observer: observer))
    }

    func notify(updateType: UpdateType) {
        var cleanArray = false

        observers.forEach {
            if let observer = $0.observer {
                observer.contentChanged(updateType, context: self)
            } else {
                cleanArray = true
            }
        }

        if cleanArray {
            observers = observers.filter({ $0.observer != nil })
        }
    }
}

class PHAppContextObserverWrapper {
    private(set) weak var observer: PHAppContextObserver?

    init(observer: PHAppContextObserver) {
        self.observer = observer
    }
}
