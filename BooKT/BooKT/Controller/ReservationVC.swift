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
    var restaurant: Restaurants!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(restaurant.close,"xxxxx")
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
        //let dateFormatter = DateFormatter()
        //let strDate = dateFormatter.string(from: datePicker.date)
        datePicker.addTarget(self, action: #selector(handleDateSelection(_:)), for: .valueChanged)
        print(datePicker.date)
    }
    
    
    @objc func handleDateSelection(_ sender: UIDatePicker){
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        let month = formatter.string(from: currentDate)
        print(month[month.startIndex],"DATE")
        print(sender.date)
    }
    func getTimeIntervalForDate()->(min : Date, max : Date){
        
        let close = restaurant.close.prefix(2)
        let open = restaurant.open.prefix(2)
        let today = Calendar.current.isDateInToday(Date())
       
        let calendar = Calendar.current
        let hour = Calendar.current.component(.hour, from: Date())
        var minDateComponent = calendar.dateComponents([.hour], from: Date())
        
        // if today set time
        if today {
            minDateComponent.hour = hour // Start time
        }else {
            minDateComponent.hour = Int(open) // Start time
        }
        
        print(open,"O")
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        let minDate = calendar.date(from: minDateComponent)
        print(" min date : \(formatter.string(from: minDate!))")
        
        var maxDateComponent = calendar.dateComponents([.hour], from: Date())
        maxDateComponent.hour = (Int(close)) //EndTime
        
        
        
        let maxDate = calendar.date(from: maxDateComponent)
        print(" max date : \(formatter.string(from: maxDate!))")
        
        
        
        return (minDate!,maxDate!)
    }
    func setupTimrPicker(){
        
        timePicker.datePickerMode = .time
        let color = UIColor(red: 235/255, green: 39/255, blue: 72/255, alpha: 1)
        timePicker.setValue(color, forKeyPath: "textColor")
        timePicker.setValue(false, forKeyPath: "highlightsToday")
        //let currentTime = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        
        dateFormatter.dateFormat =  "HH:mm"
        let dates = getTimeIntervalForDate()

        timePicker.minimumDate = dates.min
        timePicker.maximumDate = dates.max
        timePicker.minuteInterval = 30
        timePicker.addTarget(self, action: #selector(handleTimeSelection(_:)), for: .valueChanged)

    }
    @objc func handleTimeSelection(_ sender: UIDatePicker){
       
        let currentTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        let hour = formatter.string(from: currentTime)
        print(hour[hour.startIndex], "HOUR")
  
//      let date = sender.date
//        let strTime = date.dateStringWith(strFormat: "hh")
//        print(strTime)
    }
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
       navigationController?.popViewController(animated: true)
    }
    
}









extension Date {
    func dateStringWith(strFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        dateFormatter.dateFormat = strFormat
        return dateFormatter.string(from: self)
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
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(sectionList[row])
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {

        let attributedString = NSAttributedString(string: sectionList[row], attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 0, blue: 0.2558506727, alpha: 1)])
        return attributedString
    }
}
