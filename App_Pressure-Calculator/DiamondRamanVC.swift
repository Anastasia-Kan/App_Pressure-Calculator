//
//  AnvilRamanVC.swift
//  App_Pressure-Calculator
//
//  Created by Anastasia Kantor on 2020-10-15.
//

import UIKit

class DiamondRamanVC: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var ambientPressurePeak: UITextField!
    @IBOutlet weak var measuredPeak: UITextField!
    @IBOutlet weak var resultP: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ambientPressurePeak.resignFirstResponder()
        measuredPeak.resignFirstResponder()
        resultP.resignFirstResponder()
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ambientPressurePeak.delegate = self
        measuredPeak.delegate = self
        resultP.delegate = self
    }
    
    @IBAction func calcP(_ sender: Any) {
        // Checking that numbers entered
        guard let dia0 = Double(ambientPressurePeak.text!) else {
            resultP.text = "Some value is missing"
            return}
        guard let dia = Double(measuredPeak.text!) else {
            resultP.text = "Some value is missing"
            return}
        
        
        // Checking that all the numbers are in allowed ranges
        if (1200...2500).contains(dia0) {
            print("everything is ok")
        } else {print("something is wrong")
                resultP.text = "Check your values"
                return
        }
        if (1200...2500).contains(dia0) {
                print("everything is ok")
            } else {print("something is wrong")
                    resultP.text = "Check your values"
                    return
            }
        
        // Calculating Pressure
        let a = -0.00275
        let b = 2.61
        let c = dia0 - dia
        let D = (b * b) - (4 * a * c)
        let routD = pow(D, 0.5)
        let pressure = (-b + routD) / (2 * a)
        
        print(pressure)
        let P = ((pressure * 100).rounded()) / 100
        resultP.text = String(P)
        
    }
}
