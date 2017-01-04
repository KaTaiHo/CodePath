
//
//  SettingsViewController.swift
//  calculator
//
//  Created by Ka Tai Ho on 1/2/17.
//  Copyright © 2017 SDLtest. All rights reserved.
//

import UIKit

protocol SettingsViewControllerProtocol {
    func changeDefault(newVal:Double)
    func changeBackGroundColor(color:String)
    func changeTextColor(color:UIColor)
}

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    var delegate:SettingsViewControllerProtocol!
    @IBOutlet weak var defaultPercentage: UITextField!
    @IBOutlet weak var backgroundColor: UITextField!
    var colorPicked:UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = colorPicked
        if (colorPicked == UIColor.white || colorPicked == UIColor.yellow) {
            changeTextColorSetting(color: UIColor.black)
        }
        else {
            changeTextColorSetting(color: UIColor.white)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let doubleValue = defaults.double(forKey: "defaultVal")
        delegate.changeDefault(newVal: (Double(defaultPercentage.text!) ?? doubleValue*100)/100)
        
        
        if let text = backgroundColor.text, !text.isEmpty
        {
            delegate.changeBackGroundColor(color: String(backgroundColor.text!))
        }
        else {
            delegate.changeBackGroundColor(color: String(describing: colorPicked))
            print(String(describing: colorPicked))
        }
    }
    
    @IBAction func colorChanged(_ sender: AnyObject) {
        let settingsColor:String = String(backgroundColor.text!)
        
        switch settingsColor {
        case "black":
            self.view.backgroundColor = UIColor.black
            changeTextColorSetting(color: UIColor.white)
        case "gray":
            self.view.backgroundColor = UIColor.gray
            changeTextColorSetting(color: UIColor.white)
        case "white":
            self.view.backgroundColor = UIColor.white
            changeTextColorSetting(color: UIColor.black)
        default:
            self.view.backgroundColor = colorPicked
            if (colorPicked == UIColor.white || colorPicked == UIColor.yellow) {
                changeTextColorSetting(color: UIColor.black)
            }
            else {
                changeTextColorSetting(color: UIColor.white)
            }
        }
    }
    
    func changeTextColorSetting(color:UIColor) {
        for case let u as UILabel in self.view.subviews {
            u.textColor = color
        }
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
