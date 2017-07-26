//
//  Tips.swift
//  tippy
//
//  Created by Oscar Bonilla on 7/25/17.
//  Copyright © 2017 Oscar Bonilla. All rights reserved.
//

import UIKit

final class TipsManager {

    let TIP_SELECTOR_KEY = "defaultTipSelectorIndex"
    var available_tips = [0.18, 0.2, 0.25]
    var selectedIndex = 0

    private init() {
        selectedIndex = getDefaultTipIndex()
    }
    
    static let shared = TipsManager()
    
    public func availableTips() -> [Double] {
        return available_tips
    }

    public func getDefaultTipIndex() -> Int {
        let defaults = UserDefaults.standard
        return defaults.integer(forKey: TIP_SELECTOR_KEY)
    }
    
    public func getTip() -> Double {
        return available_tips[selectedIndex]
    }

    public func saveDefaultTipIndex(_ index: Int) {
        if index < 0 || index > 2 {
            return
        }
        let defaults = UserDefaults.standard
        defaults.set(index, forKey: TIP_SELECTOR_KEY)
        defaults.synchronize()
        selectedIndex = index
    }
}
