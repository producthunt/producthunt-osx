//
//  PHSettingsReducer.swift
//  Product Hunt
//
//  Created by Vlado on 4/27/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import ReSwift

struct PHSettingsSetAction: Action {
    var settings: PHSettings
}

struct PHSettingsActionAutoLogin: Action {
    var autologin: Bool
}

struct PHSettingsActionShowsCount: Action {
    var showsCount: Bool
}

struct PHSettngsActionFilterCount: Action {
    var filterCount: Int
}

func settingsReducer(action: Action, state: PHSettings?) -> PHSettings {
    guard let state = state else {
        return PHSettings(autologinEnabled: true, showsCount: true, filterCount: 10)
    }

    switch action {

        case let action as PHSettingsSetAction:
            return action.settings

        case let action as PHSettingsActionAutoLogin:
            return PHSettings(autologinEnabled: action.autologin, showsCount: state.showsCount, filterCount: state.filterCount)

        case let action as PHSettingsActionShowsCount:
            return PHSettings(autologinEnabled: state.autologinEnabled, showsCount: action.showsCount, filterCount: state.filterCount)

        case let action as PHSettngsActionFilterCount:
            return PHSettings(autologinEnabled: state.autologinEnabled, showsCount: state.showsCount, filterCount: action.filterCount)

        default:
            return state
    }
}