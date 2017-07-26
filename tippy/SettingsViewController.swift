//
//  SettingsViewController.swift
//  tippy
//
//  Created by Oscar Bonilla on 7/25/17.
//  Copyright © 2017 Oscar Bonilla. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    

    @IBOutlet weak var tipSelector: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        tipSelector.selectedSegmentIndex = Tips.getDefaultTipIndex()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveDefaultTip(_ sender: Any) {
        Tips.saveDefaultTipIndex(tipSelector.selectedSegmentIndex)
    }

}
