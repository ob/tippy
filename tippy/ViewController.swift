//
//  ViewController.swift
//  tippy
//
//  Created by Oscar Bonilla on 7/25/17.
//  Copyright © 2017 Oscar Bonilla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var bill = 0.0
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var gearButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func tipSelectorChanged(_ sender: Any) {
        TipsManager.shared.selectedIndex = tipControl.selectedSegmentIndex
        calculateTip(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tipControl.layer.borderColor = tipControl.tintColor!.cgColor
        tipControl.layer.cornerRadius = 0
        tipControl.layer.borderWidth = 1
        tipControl.layer.masksToBounds = true
        navigationController?.setNavigationBarHidden(true, animated: true)
        for i in 0..<tipControl.numberOfSegments {
            let txt = String(format: "%.0f%%", TipsManager.shared.available_tips[i] * 100.0)
            tipControl.setTitle(txt, forSegmentAt: i)
        }
        tipControl.selectedSegmentIndex = TipsManager.shared.selectedIndex
        calculateTip(tipControl)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Gross but I don't know why it doesn't reload the view.
        // The problem happens if you change the tip amount in one of
        // the textFields in settings and then hit the Back button without
        // dismising the keyboard. In that case, I don't know why the viewWillAppear
        // method doesn't get called.
        //
        // I guess that's why I need to take the iOS class
        for i in 0..<tipControl.numberOfSegments {
            let txt = String(format: "%.0f%%", TipsManager.shared.available_tips[i] * 100.0)
            tipControl.setTitle(txt, forSegmentAt: i)
        }
        gearButton.titleLabel?.text = " \u{2699}\u{0000FE0E} "
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func calculateTip(_ sender: Any) {
        let tipPercentage = TipsManager.shared.getTip()
        
        let bill = Double(String(billLabel.text!.dropFirst())) ?? 0
        let tip = bill * tipPercentage
        let total = bill + tip
        
        tipLabel.text = String(format: "$ %.2f", tip)
        totalLabel.text = String(format: "$ %.2f", total)
    }
    
    @IBAction func buttonPushed(_ sender: Any) {
        let button = sender as! DarkButton
        var billText = billLabel.text!
        let buttonText = button.titleLabel!.text!
        let dotIdx = billText.range(of: ".")
        switch buttonText {
            case ".":
                if dotIdx == nil {
                    if billText == "$" {
                        billText = "$0."
                    } else {
                        billText.append(buttonText)
                    }
                }
                break
            case "⌫":
                if billText != "$" {
                    billText = String(billText.characters.dropLast())
                }
                break
            default:
                var decimals = 0
                if let dotIdx = dotIdx {
                    decimals = billText.distance(from: dotIdx.lowerBound, to: billText.endIndex)
                }
                if decimals <= 2 {
                    billText.append(buttonText)
            }
        }
        billLabel.text = billText
        calculateTip(self)
    }
}
