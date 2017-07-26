//
//  Tips.swift
//  tippy
//
//  Created by Oscar Bonilla on 7/25/17.
//  Copyright © 2017 Oscar Bonilla. All rights reserved.
//

import UIKit

let TIP_SELECTOR_KEY = "defaultTipSelectorIndex"
let AVAILABLE_TIPS = [0.18, 0.2, 0.25]

class Tips: NSObject {
    
    public class func availableTips() -> [Double] {
        return AVAILABLE_TIPS
    }

    public class func getDefaultTipIndex() -> Int {
        let defaults = UserDefaults.standard
        return defaults.integer(forKey: TIP_SELECTOR_KEY)
    }

    public class func saveDefaultTipIndex(_ index: Int) {
        if index < 0 || index > 2 {
            return
        }
        let defaults = UserDefaults.standard
        defaults.set(index, forKey: TIP_SELECTOR_KEY)
        defaults.synchronize()
    }

}
