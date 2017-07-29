//
//  SettingsViewController.swift
//  tippy
//
//  Created by Oscar Bonilla on 7/25/17.
//  Copyright © 2017 Oscar Bonilla. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tip0: UITextField!
    @IBOutlet weak var tip1: UITextField!
    @IBOutlet weak var tip2: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tipControl.layer.borderColor = tipControl.tintColor!.cgColor
        tipControl.layer.cornerRadius = 0
        tipControl.layer.borderWidth = 1
        tipControl.layer.masksToBounds = true
        navigationController?.setNavigationBarHidden(false, animated: true)
        let buttons = [tip0, tip1, tip2]
        for i in 0..<tipControl.numberOfSegments {
            let txt = String(format: "%.0f%%", TipsManager.shared.available_tips[i] * 100.0)
            tipControl.setTitle(txt, forSegmentAt: i)
            buttons[i]?.text = txt
        }
        tipControl.selectedSegmentIndex = TipsManager.shared.getDefaultTipIndex()
    }
    
    @IBAction func didBeginEditingTextField(_ sender: Any) {
        let textField = sender as! UITextField
        textField.selectAll(sender)
    }
    
    @IBAction func onTap(_ sender: Any) {
        let textFields = [tip0, tip1, tip2]
        for i in 0..<textFields.count {
            textFields[i]?.endEditing(true)
        }
    }
    
    @IBAction func tipChanged(_ sender: Any) {
        let changedTextField = sender as! UITextField
        let textFields = [tip0, tip1, tip2]
        var index = -1
        for i in 0..<textFields.count {
            if changedTextField == textFields[i] {
                index = i
                break
            }
        }
        assert(index >= 0 && index < textFields.count)
        // drop the %
        var percentage: String = changedTextField.text ?? "%"
        if percentage.characters.last! == "%" {
            percentage = String(percentage.characters.dropLast())
        }
        let newValue = Double(percentage) ?? 0.0
        let oldValue = TipsManager.shared.available_tips[index]
        if newValue < 0 || newValue > 100 {
            // invalid, just refuse the change
            changedTextField.text = String(format: "%.0f%%", oldValue)
            return
        }
        // valid change, do it
        TipsManager.shared.available_tips[index] = newValue / 100.0
        TipsManager.shared.saveAvailableTips()
        let txt = String(format: "%.0f%%", newValue)
        // Make sure we're consistent
        changedTextField.text = txt
        tipControl.setTitle(txt, forSegmentAt: index)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveDefaultTip(_ sender: Any) {
        TipsManager.shared.saveDefaultTipIndex(tipControl.selectedSegmentIndex)
    }

}
