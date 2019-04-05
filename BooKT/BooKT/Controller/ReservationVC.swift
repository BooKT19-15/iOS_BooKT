//
//  ReservationVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 06/02/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//
struct ReservstionInfo {
    var hour: String
    var day: String
    var month: String
    var year: String
}
import UIKit
import Firebase
class ReservationVC: UIViewController {
    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var additionalInfo: UITextField!
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var sectionsPicker: UIPickerView!
    @IBOutlet weak var numberOfSeats: UILabel!
    
    
    var sectionList = [String]()
    var counter = 0
    var restaurant: Restaurants!
    var sections: [String]!
    var seats: [Int]!
    //var userReservation: UserReservation!
    var user: User!
    
    //CALENDAR
    let calendar = Calendar.current
    var year: Int!
    var month: Int!
    var day: Int!
    var hours: Int!
    var section: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        section = sectionList[sectionsPicker.selectedRow(inComponent: 0)]
        getSeats(section: section)
        setupDatePicker()
        setupTimrPicker()
        
        
//        userReservation.section = selectedValue
        navigationController?.setNavigation()
        UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.2558506727, alpha: 1)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let id = Auth.auth().currentUser?.uid {
            DataService.instance.getUserInfo(uid: id) { (returenUser) in
                self.user = returenUser
                self.setTextFiledData()
                self.loadViewIfNeeded()
            }
        }
    }
    
    
    func getSeats(section: String){
        DataService.instance.getSeats(id: restaurant.id, section: section) { (returnedSeats) in
            self.seats = returnedSeats
           // self.counter = self.seats[0]
           self.numberOfSeats.text = "\(self.seats[0])"
        }
    }
    func setTextFiledData(){
        name.text = user.name
        email.text = user.email
        mobile.text = user.mobile
    }
    
    func setupUI(){
        sectionsPicker.delegate = self
        sectionsPicker.dataSource = self
        if let sections = sections {
         sectionList = sections
        }
    }
    
    
    @IBAction func numberOfSeatsFunction(_ sender: UIButton) {
        if sender.tag == 101{
            if counter < seats.count-1{
                print(counter)
                numberOfSeats.text = "\(seats[counter+1])"
                counter += 1
            }
        }else if sender.tag == 202{
             if counter > 0{
                numberOfSeats.text = "\(seats[counter-1])"
                counter -= 1
            }
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
        let calendar = Calendar.current
        day = calendar.component(.day, from: datePicker.date)
        month = calendar.component(.month, from: datePicker.date)
        year = calendar.component(.year, from: datePicker.date)
        print(month,"MONTH\n",day,"DAY\n",year,"YEAR")
        datePicker.addTarget(self, action: #selector(handleDateSelection(_:)), for: .valueChanged)
        //print(datePicker.date)
        
    }
    
    @objc func handleDateSelection(_ sender: UIDatePicker){
        //let currentDate = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        //let month = formatter.string(from: sender.date)
        ///
        let calendar = Calendar.current
        day = calendar.component(.day, from: sender.date)
        month = calendar.component(.month, from: sender.date)
        year = calendar.component(.year, from: sender.date)
        print(month,"MONTH\n",day,"DAY\n",year,"YEAR")
//        calendar.component(.year, from: sender.date)
//        calendar.component(.day, from: sender.date)
        ///
        //let x = month.index(, offsetBy: <#T##Int#>)
       // print(month,"MONTHHHHHHH")
       // let monthNumbner = month.prefix(1)
       // print(monthNumbner,"LET X")
        setupTimrPicker()
        print(sender.date)
    }
    func getTimeIntervalForDate()->(min : Date, max : Date){
        
        let close = restaurant.close.prefix(2)
        let open = restaurant.open.prefix(2)
        let today = Calendar.current.isDateInToday(datePicker.date)
        hours = Int(close)
        print("HOUR!!!!!!!!!!!!!",hours)
        
        let calendar = Calendar.current
        let hour = Calendar.current.component(.hour, from: Date())
        var minDateComponent = calendar.dateComponents([.hour], from: datePicker.date)
        
        // if today set time
        if today {
            minDateComponent.hour = hour
        }else {
            minDateComponent.hour = Int(open)
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
        print("PASSING")
        timePicker.datePickerMode = .time
        let color = UIColor(red: 235/255, green: 39/255, blue: 72/255, alpha: 1)
        timePicker.setValue(color, forKeyPath: "textColor")
        timePicker.setValue(false, forKeyPath: "highlightsToday")
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none

        dateFormatter.dateFormat =  "HH:mm"
        let mySelectedDate = dateFormatter.string(from: timePicker.date)
        print(mySelectedDate,"FROM HERE!!!")
        let dates = getTimeIntervalForDate()

        timePicker.maximumDate = dates.max
        timePicker.minimumDate = dates.min
        timePicker.minuteInterval = 30
        timePicker.addTarget(self, action: #selector(handleTimeSelection(_:)), for: .valueChanged)
       
        

    }
    @objc func handleTimeSelection(_ sender: UIDatePicker){
        
//        sender.datePickerMode = .time
//        sender.locale = Locale(identifier: "en_UK")
//        //let currentTime = Date()
//        let formatter = DateFormatter()
//        formatter.timeStyle = .short
//        formatter.dateStyle = .none
//        let hour = formatter.string(from: sender.date)
//
//        print(hour, "HOUR")
        let myDateFormatter: DateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "HH:mm"
        
        // get the date string applied date format
        hours = calendar.component(.hour, from: timePicker.date)
        print("HOUR!!!!!!!!!!!!!",hours)
        let mySelectedDate = myDateFormatter.string(from: sender.date)
        print(mySelectedDate)
  

        
    }
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        setUserResrevation()
        print(seats[counter])
        if Auth.auth().currentUser?.uid != nil {
            DataService.instance.setReservationForAuthUser(id: restaurant.id, user: user, year: year, month: month, day: day, hour: hours, section: section, seatNumber: seats[counter], additionalInfo: additionalInfo.text ?? "")
        }else {
            DataService.instance.setReservation(id: restaurant.id, user: user, year: year, month: month, day: day, hour: hours, section: section,seatNumber: seats[counter], additionalInfo: additionalInfo.text ?? "")            
        }
        
    }
    

@IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
       navigationController?.popViewController(animated: true)
    }
    
    func setUserResrevation() {
        
        if name.text != nil && email.text != nil && mobile.text != nil {
            let newUser = User(name: name.text!, email: email.text!, mobile: mobile.text!)
            user = newUser
            setTextFiledData()
        }
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
        //print(sectionList[row],"ajfohabfjabfijbiasbfabehfbchz fhiabfbkabfibafbakbfkhbakhebfkhbakhbfkHHHHHHDHHDHDHDHDH")
        return sectionList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //setUserResrevation()
        section = sectionList[row]
        getSeats(section: section)
        counter = 0
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: sectionList[row], attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 0, blue: 0.2558506727, alpha: 1)])
        return attributedString
    }
}
