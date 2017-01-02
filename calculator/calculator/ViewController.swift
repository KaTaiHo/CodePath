//
//  ViewController.swift
//  calculator
//
//  Created by Ka Tai Ho on 12/29/16.
//  Copyright © 2016 SDLtest. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var splitSwitch: UISwitch!
    @IBOutlet weak var numPeople: UITextField!
    @IBOutlet weak var customPercentage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(_ sender: AnyObject) {
        let tipPercentages = [0.18, 0.2, 0.25]
        let bill = Double(billField.text!) ?? 0
        var tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        if (customPercentage.hasText) {
            tip = (Double(customPercentage.text!) ?? 1.0) / 100 * bill
        }
        var total = bill + tip
        
        if (splitSwitch.isOn) {
            let split = (Double(numPeople.text!) ?? 1)
            if (split <= 1) {
                splitSwitch.setOn(false, animated: false)
            }
            tip = tip / split
            total = bill / split + tip
        }
        
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
    }
}

