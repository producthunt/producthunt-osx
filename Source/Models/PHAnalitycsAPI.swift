//
//  PHAnalitycsAPI.swift
//  Product Hunt
//
//  Created by Vlado on 5/5/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation
import ISO8601

class PHAnalitycsAPI {

    var endpoint = PHAnalitycsAPIEndpoint(key: kSegmentKey)

    func track(_ properties: PHAnalitycsProperties) {
        endpoint.post("track", parameters: properties)
    }

    // Use `page` instead of `screen`
    func visit(_ properties: PHAnalitycsProperties) {
        endpoint.post("page", parameters: properties)
    }

    func identify(_ properties: PHAnalitycsProperties) {
        endpoint.post("identify", parameters: properties)
    }
}
