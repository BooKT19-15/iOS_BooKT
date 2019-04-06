//
//  ReservationVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 06/02/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//


import UIKit
import Firebase
class ReservationVC: UIViewController {
    
    //MARK:- User TextFields
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var additionalInfo: UITextField!
    
    //MARK:- View IBOutlets
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var sectionsPicker: UIPickerView!
    @IBOutlet weak var numberOfSeats: UILabel!
    
    //MARK:- Properties
    var sectionList = [String]()
    var counter = 0
    var restaurant: Restaurants!
    var sections: [String]!
    var seats: [Int]!
    var user: User!
    
    //MARK:- CALENDAR Properties
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

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchingData()
    }
    
    
    func getSeats(section: String){
        DataService.instance.getSeats(id: restaurant.id, section: section) { (returnedSeats) in
            self.seats = returnedSeats
            self.numberOfSeats.text = "\(self.seats[0])"
        }
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
        
        
        let calendar = Calendar.current
        day = calendar.component(.day, from: datePicker.date)
        month = calendar.component(.month, from: datePicker.date)
        year = calendar.component(.year, from: datePicker.date)
       
        datePicker.addTarget(self, action: #selector(handleDateSelection(_:)), for: .valueChanged)
        
    }
    
    @objc func handleDateSelection(_ sender: UIDatePicker){
        
        let calendar = Calendar.current
        day = calendar.component(.day, from: sender.date)
        month = calendar.component(.month, from: sender.date)
        year = calendar.component(.year, from: sender.date)

        setupTimrPicker()
    }
    func getTimeIntervalForDate()->(min : Date, max : Date){
        
        let close = restaurant.close.prefix(2)
        let open = restaurant.open.prefix(2)
        let closeForUser = Int(close)
        let today = Calendar.current.isDateInToday(datePicker.date)
        hours = closeForUser! - 2
       
        
        let calendar = Calendar.current
        let hour = Calendar.current.component(.hour, from: Date())
        var minDateComponent = calendar.dateComponents([.hour], from: datePicker.date)
        
        // if today set time
        if today {
            minDateComponent.hour = hour + 1
        }else {
            minDateComponent.hour = Int(open)
        }
        
        print(open,"O")
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        let minDate = calendar.date(from: minDateComponent)
        print(" min date : \(formatter.string(from: minDate!))")
        
        var maxDateComponent = calendar.dateComponents([.hour], from: Date())
        maxDateComponent.hour = hours!//EndTime
        
        
        
        let maxDate = calendar.date(from: maxDateComponent)
        print(" max date : \(formatter.string(from: maxDate!))")
        
        
        
        return (minDate!,maxDate!)
    }
    func setupTimrPicker(){
        
        timePicker.datePickerMode = .time
        let color = UIColor(red: 235/255, green: 39/255, blue: 72/255, alpha: 1)
        timePicker.setValue(color, forKeyPath: "textColor")
        timePicker.setValue(false, forKeyPath: "highlightsToday")
        
        
        let dates = getTimeIntervalForDate()

        timePicker.maximumDate = dates.max
        timePicker.minimumDate = dates.min
        timePicker.minuteInterval = 30
        timePicker.addTarget(self, action: #selector(handleTimeSelection(_:)), for: .valueChanged)
       
        

    }
    @objc func handleTimeSelection(_ sender: UIDatePicker){
        hours = calendar.component(.hour, from: timePicker.date)
        print("HOUR!!!!!!!!!!!!!",hours)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK:- Confirm Button
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        setUserResrevation()
        sender.isEnabled = true
    }
    
    
    
    
    
    
    
    //MARK:- Set Reservation
    func setMainReservation(){
        if Auth.auth().currentUser?.uid != nil {
            setMainReservationForAuthUser()
        }else {
            setMainReservationForUnAuthUser()
        }
    }
    
    
    
    //MARK- Set uset reservation info
    func setUserResrevation() {
        
        if name.text != "" && email.text != "" && mobile.text != "" {
            let newUser = User(name: name.text!, email: email.text!, mobile: mobile.text!)
            user = newUser
            setTextFiledData()
            setMainReservation()
        }
        if name.text == "" && email.text == "" && mobile.text == "" {
            alert(title:"Empty", message: "Please make sure to fill your info")
        }
    }
    func setTextFiledData(){
        name.text = user.name
        email.text = user.email
        mobile.text = user.mobile
    }
    
    
    
    //MARK:- Alert
    func alert(title: String,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    //MARK:- Fetching Data
    func fetchingData(){
        if let id = Auth.auth().currentUser?.uid {
            DataService.instance.getUserInfo(uid: id) { (returenUser) in
                self.user = returenUser
                self.setTextFiledData()
                self.loadViewIfNeeded()
            }
        }
    }
    
    
    
    
    //MARK:- Upload Data
    func setMainReservationForAuthUser(){
//        DataService.instance.setReservationForAuthUser(id: restaurant.id, user: user, year: year, month: month, day: day, hour: hours, section: section, seatNumber: seats[counter], additionalInfo: additionalInfo.text ?? "")
        
        setReservation(id: restaurant.id, user: user, year: year, month: month, day: day, hour: hours, section: section, seatNumber: seats[counter], additionalInfo: additionalInfo.text ?? "")
    }
    
    
    func setMainReservationForUnAuthUser(){
//        DataService.instance.setReservation(id: restaurant.id, user: user, year: year, month: month, day: day, hour: hours, section: section,seatNumber: seats[counter], additionalInfo: additionalInfo.text ?? "")
        setReservation(id: restaurant.id, user: user, year: year, month: month, day: day, hour: hours, section: section, seatNumber: seats[counter], additionalInfo: additionalInfo.text ?? "")
    }
    
    
    
@IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
       navigationController?.popViewController(animated: true)
    }
    
    
    //MARK:- Reservation Functions
    func checkReservation(id: String,max:String,year:Int,month: Int,day: Int,hour: Int,section: String,seatNumber: Int, user: User, additionalInfo: String, flag: Bool) {
        DB_BASE.child("Reservation").child(id).child("sections").child(section).child("T\(seatNumber)").child("date").child("\(year)").child("\(month)").child("\(day)").child("\(hour)").observeSingleEvent(of: .value) { (snapshot) in
            
            //check if current selected time is full
            var status = false
            if Int(snapshot.childrenCount) >= Int(max)! {
                status = true
                self.alert(title: "No Reservation", message:"Either the time you chose is already reserved or you already have reservation in this restaurant")
                print("if", status)
            }else {
                status = false
                print("elseif", status)
            }
            
            // if current selected time is NOT full
            if !status {
                
                var status_two = false
                
                // check if NEXT hour is full
                DB_BASE.child("Reservation").child(id).child("sections").child(section).child("T\(seatNumber)").child("date").child("\(year)").child("\(month)").child("\(day)").child("\(hour+1)").observeSingleEvent(of: .value) { (snapshot2) in
                    
                    if Int(snapshot2.childrenCount) >= Int(max)! {
                        status_two = true
                    }
                    
                    // if next hour is NOT full --> RESERVE
                    if !status_two {
                        
                        DB_BASE.child("Reservation").child(id).child("sections").child(section).child("T\(seatNumber)").child("date").child("\(year)").child("\(month)").child("\(day)").child("\(hour)").childByAutoId().updateChildValues(["name":"\(user.name)","mobile":"\(user.mobile)","email":"\(user.email)","month":"\(month)","day":"\(day)","hour":"\(hour)","additional_Info":additionalInfo])
                        
                        
                        DB_BASE.child("Reservation").child(id).child("sections").child(section).child("T\(seatNumber)").child("date").child("\(year)").child("\(month)").child("\(day)").child("\(hour+1)").childByAutoId().updateChildValues(["name":"\(user.name)","mobile":"\(user.mobile)","email":"\(user.email)","month":"\(month)","day":"\(day)","hour":"\(hour)","additional_Info":additionalInfo])
                        
                        self.alert(title: "Done", message: "your reservation is completed")
                        if flag{
                            self.setAuthUserProfileReservation(id: id, user: user, year: year, month: month, day: day, hour: hour, section: section, seatNumber: seatNumber, additionalInfo: additionalInfo)
                        }
                    }
                    
                }
                
            }
            
        }
    }
    
    
    func setReservation(id: String,user: User,year:Int,month: Int,day: Int,hour: Int,section: String,seatNumber: Int,additionalInfo: String){
        DB_BASE.child("Reservation").child(id).child("sections").child("single").child("T\(seatNumber)").observeSingleEvent(of: .value) { (snapshot) in
            
            let max = snapshot.childSnapshot(forPath: "max").value as! String
            self.checkReservation(id: id, max: max, year: year, month: month, day: day, hour: hour, section: section, seatNumber: seatNumber, user: user, additionalInfo: additionalInfo, flag: false)
            
        }
    }
    
    
    func setReservationForAuthUser(id: String,user: User,year:Int,month: Int,day: Int,hour: Int,section: String,seatNumber: Int,additionalInfo: String){
        
        let uid = Auth.auth().currentUser!.uid
        
        DataService.instance.REF_USERS.child("\(uid)").child("reservations").child("active").child("\(id)").observe(.value, with: { (snapshot) in
            if snapshot.exists() {
                
                
                
            }else {
                
                DB_BASE.child("Reservation").child(id).child("sections").child("single").child("T\(seatNumber)").observeSingleEvent(of: .value) { (snapshot) in
                    
                    let max = snapshot.childSnapshot(forPath: "max").value as! String
                    self.checkReservation(id: id, max: max, year: year, month: month, day: day, hour: hour, section: section, seatNumber: seatNumber, user: user, additionalInfo: additionalInfo, flag: true)
                    
                }
            }
        })
    }
    
    func setAuthUserProfileReservation(id: String,user: User,year:Int,month: Int,day: Int,hour: Int,section: String,seatNumber: Int,additionalInfo: String){
        print("PASS")
        let uid = Auth.auth().currentUser!.uid
        DataService.instance.REF_USERS.child("\(uid)").child("reservations").child("active").child("\(id)").childByAutoId().updateChildValues(["name":"\(user.name)","mobile":"\(user.mobile)","email":"\(user.email)","month":"\(month)","day":"\(day)","hour":"\(hour)","additional_Info":additionalInfo,"date":"\(month)/\(day)/\(year)"])
    }
    
    
}








//extension Date {
//    func dateStringWith(strFormat: String) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = Calendar.current.timeZone
//        dateFormatter.locale = Calendar.current.locale
//        dateFormatter.dateFormat = strFormat
//        return dateFormatter.string(from: self)
//    }
//}







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
