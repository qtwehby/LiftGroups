//
//  AddWorkoutViewController.swift
//  LiftGroups
//
//  Created by Wehby, Quinton on 3/16/22.
//

import UIKit

class AddWorkoutViewController: UIViewController {
    

    @IBOutlet weak var workoutTextField: UITextField!
    
    
    let workouts = ["Chest/Tri", "Back/Bi", "Legs", "Shoulders"]
    
    var pickerView = UIPickerView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        workoutTextField.inputView = pickerView
        workoutTextField.textAlignment = .center
        
        // Do any additional setup after loading the view.
    }

}

extension AddWorkoutViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return workouts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return workouts[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        workoutTextField.text = workouts[row]
        workoutTextField.resignFirstResponder()
    }
    
}
