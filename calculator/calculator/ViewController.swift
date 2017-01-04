//
//  ViewController.swift
//  calculator
//
//  Created by Ka Tai Ho on 12/29/16.
//  Copyright © 2016 SDLtest. All rights reserved.
//

import UIKit



class ViewController: UIViewController, SettingsViewControllerProtocol {

    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var splitSwitch: UISwitch!
    @IBOutlet weak var numPeople: UITextField!
    @IBOutlet weak var customPercentage: UITextField!
    @IBOutlet weak var defaultPercentLabel: UILabel!
    @IBOutlet weak var defaultPercentSwitch: UISwitch!
    
    var mainColor:UIColor = UIColor.white
    var defaultValue = 0.0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (mainColor == UIColor.white || mainColor == UIColor.yellow) {
            changeTextColor(color: UIColor.black)
        }
        else {
            changeTextColor(color: UIColor.white)
        }
        // Do any additional setup after loading the view, typically from a nib.
        let defaults = UserDefaults.standard
        let stringValue = defaults.string(forKey: "mainColor") ?? "my default string"
        changeBackGroundColor(color: stringValue)
        let doubleValue = defaults.double(forKey: "defaultVal")
        defaultValue = doubleValue
        defaultPercentLabel.text = String(defaultValue * 100) + "%"
        let doubleValue2 = defaults.double(forKey: "bill")
        
        if (doubleValue2 == 0) {
            billField.text = ""
        }
        else {
            billField.text = String(doubleValue2)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(defaultValue, forKey: "defaultVal")
        defaults.set(Double(billField.text!) ?? 0.0, forKey: "bill")

        defaults.synchronize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        self.billField.becomeFirstResponder()
        
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
        var tip = bill
        
        
        if (defaultPercentSwitch.isOn) {
            tip = bill * defaultValue
            tipControl.selectedSegmentIndex = -1
        }
        else if (tipControl.selectedSegmentIndex >= 0) {
            tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        }
        else {
            tip = bill * defaultValue
        }
        
        if (customPercentage.hasText) {
            tip = (Double(customPercentage.text!) ?? 1.0) / 100 * bill
            tipControl.selectedSegmentIndex = -1
            defaultPercentSwitch.setOn(false, animated: false)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC = segue.destination as! SettingsViewController
        secondVC.delegate = self
        secondVC.colorPicked = mainColor
    }
    
    func changeDefault(newVal:Double) {
        defaultValue = newVal
        defaultPercentLabel.text = String(defaultValue * 100) + "%"
        
        let defaults = UserDefaults.standard
        defaults.set(defaultValue, forKey: "defaultVal")
        defaults.synchronize()
    }
    
    func changeTextColor(color:UIColor) {
        for case let u as UILabel in self.view.subviews {
            u.textColor = color
        }
    }
    
    func changeBackGroundColor(color:String){
        tipControl.tintColor = UIColor.blue
        var viewColor = color
        
        switch viewColor {
        case "black":
            self.view.backgroundColor = UIColor.black
            mainColor = UIColor.black
            changeTextColor(color: UIColor.white)
            tipControl.tintColor = UIColor.yellow
        case "gray":
            self.view.backgroundColor = UIColor.gray
            mainColor = UIColor.gray
            changeTextColor(color: UIColor.white)
            tipControl.tintColor = UIColor.yellow
        case "white":
            self.view.backgroundColor = UIColor.white
            mainColor = UIColor.white
            changeTextColor(color: UIColor.black)
        default:
            self.view.backgroundColor = mainColor
            if (mainColor == UIColor.white) {
                changeTextColor(color: UIColor.black)
                tipControl.tintColor = UIColor.blue
            }
            else {
                changeTextColor(color: UIColor.white)
                tipControl.tintColor = UIColor.yellow
            }
        }
        let defaults = UserDefaults.standard
        defaults.set(viewColor, forKey: "mainColor")
        defaults.synchronize()
        
    }
}

