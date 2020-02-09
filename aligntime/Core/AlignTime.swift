//
//  AlignTime.swift
//  aligntime
//
//  Created by Ostap on 31/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//
import Combine
import Foundation
import UserNotifications


final class AlignTime: ObservableObject {
    
    let defaults = UserDefaults.standard
    
    @Published var required_aligners_total:Int = 75
    @Published var aligner_wear_days:Int = 7
    @Published var start_treatment:Date = Date()
    @Published var aligner_number_now:Int = 4
    @Published var current_aligner_days:Int = 6
    
    @Published var play_state:Bool = true
    @Published var wear_timer:String = "00:00:00"
    @Published var out_timer:String = "00:00:00"
    @Published var start_time:Date = Date()
    @Published var out_time:Date = Date()
    @Published var wear_elapsed_time:TimeInterval = TimeInterval()
    @Published var out_elapsed_time:TimeInterval = TimeInterval()
    
    @Published var wearing_aligners_days:String = "0"
    @Published var days_left:String = "0"
    
    @Published var complete:Bool = false
    
    // how to save custom data into UserDefaults?
    var days: [Date: [String: TimeInterval]] = [:]
    var colors = RKColorSettings()
    
    @Published var calendar = Calendar.current
    @Published var minimumDate: Date = Date()
    @Published var maximumDate: Date = Date() //.addingTimeInterval(60*60*24*2)
    @Published var startDate: Date! = nil
    @Published var endDate: Date! = nil
    
    @Published var intervals = test_intervals()//create_wear_intervals(intervals:days_intervals,type:true)

    @Published var selected_date: Date! = Date()//nil
    
    @Published var current_state = true
    @Published var last_interval_date = Date()
      
    func _get_timer_for_today(d:Date? = nil, wear: Bool) -> String{
        let intervals = self.intervals.filter{
            (Calendar.current.isDate($0.time, equalTo: Date(), toGranularity: .day))
        &&
        ($0.wear == wear)}
        
        //intervals.append(contentsOf: )
        var total:TimeInterval = 0
        for i in intervals {
            if self.intervals.count > i.id+1{
                let t =  self.intervals[i.id+1].time.timeIntervalSince(i.time)
                total+=t
            }
            else {
                if d != nil{
                    let t = d!.timeIntervalSince(i.time)
                    total+=t
                }
            }
        }
        //print(self.timer_format(total)!)
        return self.timer_format(total)!
    }
  
    func get_off_timer_for_today(d:Date? = nil) -> String{
        return _get_timer_for_today(d: d, wear: false)
    }

    func get_wear_timer_for_today(d:Date? = nil) -> String{
        return _get_timer_for_today(d: d, wear: true)
    }
    
    func get_off_timer_for_date(d:Date) -> String{
        if !current_state{
            return self.timer_format(d.timeIntervalSince(self.last_interval_date))!
        }
        return wear_timer
    }
    
    func switch_timer(){
        if self.intervals.count != 0{
            self.last_interval_date = self.intervals[self.intervals.count-1].time
        }
        else{
            self.last_interval_date = Date()
        }
        let interval = DayInterval()
        interval.time=Date()
        interval.id = self.intervals.count
        interval.wear = current_state
        self.intervals.append(interval)
        update_min_max_dates()
    }
  
    
    func update_today_dates() throws {
        let days_interval = Date().timeIntervalSince(self.start_treatment)
        let days_formated_string = String(days_interval.days)
        if (self.wearing_aligners_days != days_formated_string){
            self.wearing_aligners_days = days_formated_string
        }
        
        let days_left_digit = ((self.required_aligners_total) * self.aligner_wear_days) - days_interval.days-self.current_aligner_days
        
        let days_left_string = String(days_left_digit)
        if (self.days_left != days_left_string){
             self.days_left = days_left_string
        }
    }
        
    func start_wear(){
        self.start_time = Date().addingTimeInterval((self.wear_elapsed_time)*(-1))
        self.start_time-=1
    }
    
    func out_wear(){
        self.out_time = Date().addingTimeInterval((self.out_elapsed_time)*(-1))
        self.out_time-=1
    }
    
    func timer_format(_ second: TimeInterval) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: second)
    }
    
    func day_format(_ second: TimeInterval) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.day]
        //print(second.days)
        return formatter.string(from: second)
    }
    
    func date_format(date: Date) -> Date {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: date)) else {
            fatalError("Failed to strip time from Date object")
        }
        return date
    }
   
    func date_string_format(_ date: Date) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    func get_total_wear_time() ->String{return ""}
    
    func get_total_off_time() ->String{return ""}
        
    func get_days_to_treatment_end() ->Int{return 0}
    
    func set_wear_time_for_date(date:Date,interval:TimeInterval){
//        let wear = ["wear": interval]
//        self.days[date] = wear
    }

    func set_off_time_time_for_date(date:Date,interval:TimeInterval){
//        let off_time = ["out": interval]
//        self.days[date] = off_time
    }
    
    func _interval_filter(wear: Bool) -> [DayInterval] {
        // Get last interval from previous day
        if self.selected_date == nil {
            return []
        }
        
        var previous_intervals:[DayInterval] = []
        
        if (wear == true) {
            previous_intervals = self.intervals.filter{
                Calendar.current.isDate($0.time, equalTo: self.selected_date, toGranularity: .day)}
        }
        else {
            previous_intervals = self.intervals.filter{ // -86400 is yesterday
                Calendar.current.isDate($0.time, equalTo: self.selected_date.advanced(by: -86400), toGranularity: .day)}
        }
        
        if previous_intervals != [] {
            let lastdate = previous_intervals.max { a, b in a.id < b.id }!
            let intervals = self.intervals.filter {
                (Calendar.current.isDate($0.time, equalTo: self.selected_date, toGranularity: .day) || Calendar.current.isDate($0.time, equalTo: lastdate.time,toGranularity: .minute))
                    &&
                    ($0.wear == wear)
            }
            return intervals
        }
        else {
            let intervals = self.intervals.filter {
                (Calendar.current.isDate($0.time, equalTo: self.selected_date, toGranularity: .day))
                &&
                ($0.wear == wear)
            }
            return intervals
        }
    }
    
    func get_wear_days()->[DayInterval]{
        return _interval_filter(wear: true)
    }
    
    func get_off_days() ->[DayInterval] {
        return _interval_filter(wear: false)
    }
    
    func is_selected_date(date:Date)->Bool{
        if self.selected_date == nil {
            return false
        }
        let state = Calendar.current.isDate(date, equalTo: self.selected_date, toGranularity: .day)
        return state
    }
    
    func reasign_intervals_id(){
        for (i,v) in self.intervals.enumerated(){
            v.id = i
        }
        
        update_min_max_dates()
    }
    
    func push_user_defaults(){
        defaults.set(required_aligners_total, forKey: "require_count")
        defaults.set(aligner_wear_days, forKey: "aligners_count")
        defaults.set(start_treatment.timeIntervalSince1970, forKey: "start_treatment")
        defaults.set(aligner_number_now, forKey: "align_count_now")
        defaults.set(current_aligner_days, forKey: "days_wearing")
        defaults.set(wearing_aligners_days, forKey: "wearing_aligners_days")
        defaults.set(days_left, forKey: "days_left")
        //defaults.set(days_intervals, forKey: "days")
        
        defaults.set(complete, forKey: "collecting_data_complete")
    }
  
    func pull_user_defaults(){
        self.required_aligners_total = defaults.integer(forKey: "require_count")
        self.aligner_wear_days = defaults.integer(forKey: "aligners_count")
        self.start_treatment = Date(timeIntervalSince1970:defaults.double(forKey: "start_treatment"))
        self.aligner_number_now = defaults.integer(forKey: "align_count_now")
        self.current_aligner_days = defaults.integer(forKey: "days_wearing")
        self.wearing_aligners_days = defaults.string(forKey: "wearing_aligners_days") ?? "0"
        self.days_left = defaults.string(forKey: "days_left") ?? "0"
        //self.days_string = defaults.dictionary(forKey: "days") as? [String : [String : Double]] ?? days_string
        //var temp_days = defaults.object(forKey: "SavedArray") as? [DayInterval] ?? []
        
        self.complete = defaults.bool(forKey: "collecting_data_complete")
        
        update_min_max_dates()
    }
    
    func send_notification(time_interval:Double){
        let content = UNMutableNotificationContent()
        content.title = "AlignTime Reminder. \(time_interval)s"
        content.body = "Time to put your aligners on again"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time_interval, repeats: false)
        let request = UNNotificationRequest(identifier: "AlignTime.id.01", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    /// Calendar Manager
    
    func update_min_max_dates(){
        self.minimumDate = self.intervals.min()!.time
        self.maximumDate = self.intervals.max()!.time
    }
}

