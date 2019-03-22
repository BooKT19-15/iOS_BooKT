//
//  ReservationVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 06/02/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class ReservationVC: UIViewController {
    
    @IBOutlet weak var seatsTextField: UITextField!
    @IBOutlet weak var sectionTextField: UITextField!
   
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    
    var currentTextField = UITextField()
    var pickerView = UIPickerView()
    
    var seatsList = [String]()
    var sectionList = [String]()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFiled()
        setupDatePicker()
        setupTimrPicker()
    }
    
    
    
    
    
    
    
    //MARK:- Setup TextFiled Lists and Values
    func setupTextFiled(){
        seatsTextField.text = "1"
        sectionTextField.text = "Single"
        seatsList = ["1","2","3","4","5","6","7","8","9","10"]
        sectionList = ["Single","Family"]
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK:- setup TimePicker and DatePicker
    func setupDatePicker(){
        datePicker.datePickerMode = .date
        let color = UIColor(red: 235/255, green: 39/255, blue: 72/255, alpha: 1)
        datePicker.setValue(color, forKeyPath: "textColor")
        datePicker.setValue(false, forKeyPath: "highlightsToday")
        let twoMonths: TimeInterval = 60 * 24 * 60 * 60
        let today = Date()
        datePicker.minimumDate = today
        let twoMonthsFromToday = today.addingTimeInterval(twoMonths)
        datePicker.maximumDate = twoMonthsFromToday
        //datePicker
      
    }
    func setupTimrPicker(){
        timePicker.datePickerMode = .time
        let color = UIColor(red: 235/255, green: 39/255, blue: 72/255, alpha: 1)
        timePicker.setValue(color, forKeyPath: "textColor")
        timePicker.setValue(false, forKeyPath: "highlightsToday")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm"
        
        let min = dateFormatter.date(from: "9:00")
        let max = dateFormatter.date(from: "23:00")
        timePicker.minimumDate = min
        timePicker.maximumDate = max
    }
    

    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}











// I added all the delegation through the stroyboard for each textField
//MARK:- TextFiled Delegates
extension ReservationVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        currentTextField = textField
        
        if currentTextField == seatsTextField {
            currentTextField.inputView = pickerView
        }else if currentTextField == sectionTextField {
            currentTextField.inputView = pickerView
        }
    }
}



















//MARK:- UIPickerView Delegates & Data Source
extension ReservationVC: UIPickerViewDelegate , UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerView.backgroundColor = #colorLiteral(red: 0.1129432991, green: 0.1129470244, blue: 0.1129450426, alpha: 1)
        //pickerView.tit
        if currentTextField == seatsTextField {
            return seatsList.count
        }else if currentTextField == sectionTextField {
            return sectionList.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == seatsTextField {
            return seatsList[row]
        }else if currentTextField == sectionTextField {
            return sectionList[row]
        } else {
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == seatsTextField {
            seatsTextField.text = seatsList[row]
            self.view.endEditing(true)
        }else if currentTextField == sectionTextField {
            sectionTextField.text = sectionList[row]
            self.view.endEditing(true)
        }
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if currentTextField == seatsTextField {
            let attributedString = NSAttributedString(string: seatsList[row], attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 0, blue: 0.2558506727, alpha: 1)])
            return attributedString
        }else if currentTextField == sectionTextField{
            let attributedString = NSAttributedString(string: sectionList[row], attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 0, blue: 0.2558506727, alpha: 1)])
            return attributedString
        }
        let attributedString = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 0, blue: 0.2558506727, alpha: 1)])
        return attributedString
    }
}
