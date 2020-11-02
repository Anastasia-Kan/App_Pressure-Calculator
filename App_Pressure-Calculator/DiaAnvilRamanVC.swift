//
//  DiaRamanVC.swift
//  App_Pressure-Calculator
//
//  Created by Anastasia Kantor on 2020-10-15.
//

import UIKit

class DiaAnvilRamanVC: UIViewController, UITextFieldDelegate {

   
    @IBOutlet weak var AmbientPressurePeak: UITextField!
    @IBOutlet weak var MeasuredPeak: UITextField!
    @IBOutlet weak var resultP: UITextField!
    @IBOutlet weak var calcP: UIButton!
    @IBOutlet weak var note: UITextView!
    @IBOutlet weak var saveToLogBook: UIButton!
    @IBOutlet weak var sampleName: UITextField!
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
        if (AmbientPressurePeak.text == "") {
            AmbientPressurePeak.text = "1333"
        }
        if (MeasuredPeak.text == "") {
            MeasuredPeak.text = "1333"
        }

    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            let viewframe = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            view.frame = viewframe
        } else {
            if(sampleName.isFirstResponder)
            {
                let viewframe = CGRect(x: 0, y: -keyboardViewEndFrame.height, width: view.frame.width, height: view.frame.height)
                view.frame = viewframe
            }
            
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AmbientPressurePeak.delegate = self
        MeasuredPeak.delegate = self
        resultP.delegate = self
        sampleName.delegate = self
        
        calcP.layer.cornerRadius = 10
        calcP.clipsToBounds = true
        note.layer.cornerRadius = 10
        note.clipsToBounds = true
        saveToLogBook.layer.cornerRadius = 10
        saveToLogBook.clipsToBounds = true
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    
        }
    
    @IBAction func calculatePressure(_ sender: Any) {
        view.endEditing(true)

        // Checking that numbers entered
        guard let dia0 = Double(AmbientPressurePeak.text!) else {
            resultP.text = "Some value is missing"
            return}
        guard let dia = Double(MeasuredPeak.text!) else {
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
        let diK = 547.0
        let diKp = 3.75
        
        let rat1 = (dia - dia0) / dia0
        let part1 = diK * rat1
        let part2 = 0.5 * (diKp - 1)
        let part3 = 1 + (part2 * rat1)
        let pressure = part1 * part3
        
        print(pressure)
        let P = ((pressure * 100).rounded()) / 100
        resultP.text = String(P)
     }
    
    @IBAction func save(_ sender: Any) {
        view.endEditing(true)
        
        print(sampleName.text ?? "DAC-1")
        print(resultP.text ?? "0.0")
    }
    
}