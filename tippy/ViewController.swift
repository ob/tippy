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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tipControl.layer.borderColor = tipControl.tintColor!.cgColor
        tipControl.layer.cornerRadius = 0
        tipControl.layer.borderWidth = 1
        tipControl.layer.masksToBounds = true
        navigationController?.setNavigationBarHidden(true, animated: true)
        tipControl.selectedSegmentIndex = Tips.getDefaultTipIndex()
        calculateTip(tipControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func calculateTip(_ sender: Any) {
        
        let tipPercentages = Tips.availableTips()
        
        let bill = Double(String(billLabel.text!.dropFirst())) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
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
