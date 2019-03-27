//
//  ReservationVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 06/02/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class ReservationVC: UIViewController {
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var sectionsPicker: UIPickerView!
    @IBOutlet weak var numberOfSeats: UILabel!
    
    
    var sectionList = [String]()
    var counter = 1
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
        setupTimrPicker()
        setupUI()
        navigationController?.setNavigation()
        UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.2558506727, alpha: 1)
    }

    func setupUI(){
        sectionsPicker.delegate = self
        sectionsPicker.dataSource = self
        sectionList = ["Single","Family"]
        numberOfSeats.text = "\(counter)"
    }
    
    
    @IBAction func numberOfSeatsFunction(_ sender: UIButton) {
        if sender.tag == 101 && counter < 30{
            counter += 1
            numberOfSeats.text = "\(counter)"
        }else if sender.tag == 202  && counter > 1 {
            counter -= 1
            numberOfSeats.text = "\(counter)"
        }
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
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
       dismiss(animated: true, completion: nil)
    }
    
}











// I added all the delegation through the stroyboard for each textField
//MARK:- TextFiled Delegates
extension ReservationVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}



















//MARK:- UIPickerView Delegates & Data Source
extension ReservationVC: UIPickerViewDelegate , UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerView.backgroundColor = #colorLiteral(red: 0.1129432991, green: 0.1129470244, blue: 0.1129450426, alpha: 1)
        return sectionList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sectionList[row]
    }
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {

        let attributedString = NSAttributedString(string: sectionList[row], attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 0, blue: 0.2558506727, alpha: 1)])
        return attributedString
    }
}
