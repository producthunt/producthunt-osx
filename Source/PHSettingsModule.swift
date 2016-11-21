//
//  PHSettingsReducer.swift
//  Product Hunt
//
//  Created by Vlado on 4/27/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import ReSwift

struct PHSettings {
    var autologinEnabled: Bool
    var showsCount: Bool
    var filterCount: Int
}

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

func settingsReducer(_ action: Action, state: PHSettings?) -> PHSettings {
    var state = state ?? PHSettings(autologinEnabled: true, showsCount: true, filterCount: 10)

    switch action {

        case let action as PHSettingsSetAction:
            return action.settings

        case let action as PHSettingsActionAutoLogin:
            state.autologinEnabled = action.autologin

            return state

        case let action as PHSettingsActionShowsCount:
            state.showsCount = action.showsCount

            return state

        case let action as PHSettngsActionFilterCount:
            state.filterCount = action.filterCount

            return state

        default:
            return state
    }
}
