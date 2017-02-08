//
//  ScheduleViewController.swift
//  Reservation
//
//  Created by Tu Vu on 07/02/17.
//  Copyright © 2017 MAC. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    @IBOutlet weak var timeSlotsCollectionView: UICollectionView!
    @IBOutlet weak var monthCollectionView: UICollectionView!
    
    @IBOutlet weak var reserveButton: UIButton!
    
    @IBOutlet weak var partySizeButton: UIButton!
    var currentMonthDates:[Date] {
        var dates:[Date] = []
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let today = Date()
        let units: Set<Calendar.Component> = [.hour, .day, .month, .year]
        var components = Calendar.current.dateComponents(units, from: today)
        let day = components.day;
        let lastMonthDate = Date().endOfMonth(day: day!)
        let lastMonthDay = Calendar.current.dateComponents(units, from:lastMonthDate).day
        dates.append(today)
        for index in day!...lastMonthDay! {
            components.day = index + 1
            components.hour = 0
            let date = Calendar.current.date(from:components)
            dates.append(date!)
        }
        return dates
    }
    
    var partySize:Int = 1
    var currentSelectedDate:Date?
    var selectedTimeSlot:String?
    var currentSelectedDay:String?
    var monthCollectionSelectedIndexPath = IndexPath(item:0, section:0)
    var timeSlotCollectionSelectedIndexPath:IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()

       currentSelectedDate = currentMonthDates[0]
        
        reserveButton.layer.borderColor = UIColor.lightGray.cgColor
        reserveButton.layer.cornerRadius = 2.0
        reserveButton.layer.borderWidth = 1.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- Private Functions
    
    
    /**
     This function retruns weekDay, day, Current hour as tupple
     - parameter : Date
     - returns: Tupple with values Weekday, monthDay, Hour
     */
    
    func getDayOfDate(date:Date) -> (Int,Int,Int) {
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = dateFormateString
        let units: Set<Calendar.Component> = [.hour, .day, .month, .year ,.weekday]
        var components = Calendar.current.dateComponents(units, from:date)
        return (components.weekday!, components.day!,components.hour!)
    }
    
    /**
     This function will conver integer value of week day into string value
     - parameter weekDay
     - returns: String
     */
    func getWeekDayString(weekDay:Int) -> String {
        switch weekDay {
        case 1:
            return "SUN"
        case 2:
            return "MON"
        case 3:
            return "TUE"
        case 4:
            return "WED"
        case 5:
            return "THU"
        case 6:
            return "FRI"
        case 7:
            return "SAT"
        default:
            return ""
        }
    }
    
    /**
       This function will get time slot.
     - parameter index
     - returns: String
     */
    func getTimeSlotString(index:Int) ->String {
        guard let currentSelectedDate = currentSelectedDate else {
            return ""
        }
        if getDayOfDate(date: currentSelectedDate).2 + index + 1 >= 12 {
            return "\(getDayOfDate(date: currentSelectedDate).2 + index + 1 ):00 PM"
        }else {
            return "\(getDayOfDate(date: currentSelectedDate).2 + index + 1 ):00 AM"
        }
    }
    
    //MARK:- Button Actions

    @IBAction func reserveButtonAction(_ sender: Any) {
        
        let reservation = Reservation(timeSlot:selectedTimeSlot!, date:currentSelectedDate!, day:currentSelectedDay!, category:ServiceOptions.hotStoneMessage, partySize:partySize, categoryDesc:categoryDesc)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        ReservationDetails.createReservationRecord(reservation:reservation, inManagedObjectContext:appDelegate.persistentContainer.viewContext)
        
        appDelegate.saveContext()
        
        appDelegate.allCreatedReservation.append(reservation)
        self.navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func partySizeButtonTapped(_ sender: Any) {
        
        let picker: UIPickerView
        picker = UIPickerView(frame:CGRect(x:0, y:self.view.frame.height - 300, width:self.view.frame.size.width, height:300))
        picker.backgroundColor = UIColor.white
        picker.showsSelectionIndicator = true
        
        self.view.addSubview(picker)
        picker.delegate = self
        picker.dataSource = self
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

//MARK:- PickerView DataSource


extension ScheduleViewController : UIPickerViewDataSource{
 
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
}


//MARK:- PickerView Delegate

extension ScheduleViewController : UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }

    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
        partySizeButton.setTitle("\(row+1)", for:.normal)
        partySize = row + 1
        pickerView.removeFromSuperview()
    }
}

//MARK:- CollectionView DataSource

extension ScheduleViewController:UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == monthCollectionView {
            return currentMonthDates.count
        }else if collectionView == timeSlotsCollectionView {
                return 24 - getDayOfDate(date: currentSelectedDate!).2
        }
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == monthCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"monthCell", for:indexPath) as? MonthCollectionViewCell
            
            let date = currentMonthDates[indexPath.row]
            let days = getDayOfDate(date: date)
            cell?.numberDayLabel.text = "\(days.1)"
            cell?.textDayLabel.text = getWeekDayString(weekDay:days.0)
            
            if indexPath.row == monthCollectionSelectedIndexPath.row {
                cell?.selectedTickMarkImageView.isHidden = false
                cell?.maskedView.isHidden = false
                currentSelectedDay = cell?.textDayLabel.text
            }else {
                cell?.selectedTickMarkImageView.isHidden = true
                cell?.maskedView.isHidden = true
            }

            cell?.layer.borderColor = UIColor.lightGray.cgColor
            cell?.layer.borderWidth = 1.0
            
            return cell!
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"timeSlotCell", for:indexPath) as? TimeSlotCollectionViewCell
            
            cell?.timeSlotLabel.text = getTimeSlotString(index:indexPath.row)
            
            cell?.layer.borderColor = UIColor.lightGray.cgColor
            cell?.layer.borderWidth = 1.0
            
            if let _timeSlotCollectionSelectedIndexPath = timeSlotCollectionSelectedIndexPath {
                if indexPath.row == _timeSlotCollectionSelectedIndexPath.row {
                    cell?.selectedTickMarkImageView.isHidden = false
                    cell?.maskedView.isHidden = false
                    selectedTimeSlot = cell?.timeSlotLabel.text
                }else {
                    cell?.selectedTickMarkImageView.isHidden = true
                    cell?.maskedView.isHidden = true
                }
            }else {
                cell?.selectedTickMarkImageView.isHidden = true
                cell?.maskedView.isHidden = true
            }
            return cell!
        }
    }
}

//MARK:- CollectionView Delegate

extension ScheduleViewController:UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == monthCollectionView {
            currentSelectedDate = currentMonthDates[indexPath.row]
            monthCollectionSelectedIndexPath = indexPath
            timeSlotCollectionSelectedIndexPath = nil
            timeSlotsCollectionView.reloadData()
            monthCollectionView.reloadData()
            reserveButton.isEnabled = false
        }else {
            timeSlotCollectionSelectedIndexPath = indexPath
            timeSlotsCollectionView.reloadData()
            reserveButton.isEnabled = true
        }
    }
}

//MARK: - Date Extension

extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.day,.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth(day:Int) -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -day,hour:0), to: self.startOfMonth())!
    }
}
