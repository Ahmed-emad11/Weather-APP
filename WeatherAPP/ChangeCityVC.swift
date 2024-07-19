//
//  ChangeCityVC.swift
//  Pods
//
//  Created by Ahmed Emad on 12/07/2024.
//

import UIKit

class ChangeCityVC: UIViewController {
    
    var citiesArray = [
        City(name: "الرياض", id: "108410"),
        City(name: "الدمام", id: "110336"),
        City(name: "جدة", id: "105343"),
        City(name: "أبها", id: "110690"),
       ]
    
    /*
     Damam => 110336
     Jeddah => 105343
     Apha => 110690
     */
   
    
    var selectedCity :City?
    
    @IBOutlet weak var citiesPickersView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        citiesPickersView.delegate = self
        citiesPickersView.dataSource = self
    }
    @IBAction func editCityButtonCliked(_ sender: Any) {
        if let city = selectedCity {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cityValueChanged")
                , object: nil, userInfo: ["city":city])
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
}

extension ChangeCityVC:
    UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        citiesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return citiesArray[row].name
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCity = citiesArray[row]
    }
    
}
                            
