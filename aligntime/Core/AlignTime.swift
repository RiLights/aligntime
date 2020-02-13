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
    
    @Published var intervals:[DayInterval] = test_intervals()//create_wear_intervals(intervals:days_intervals,type:true)

    @Published var selected_date: Date! = Date()//nil
    @Published var selected_month = Calendar.current.dateComponents(in: .current, from: Date()).month ?? 0
    
    @Published var current_state = true
    @Published var last_interval_date = Date()
    
    let notification_identifier01 = "AlignTime.id.01"
    let notification_identifier02 = "AlignTime.id.02"
    let notification_identifier03 = "AlignTime.id.03"

    
    func _filter(d:Date, wear: Bool) -> [DayInterval] {
        return self.intervals.filter{ ($0.time.belongTo(date: d)) && ($0.wear == wear) }
    }
      
    func _get_timer_for_today(d:Date, wear: Bool) -> String{
        let intervals = _filter(d: d, wear: wear)
        var total:TimeInterval = 0
        for i in intervals {
            if self.intervals.count > i.id+1{
                let t =  self.intervals[i.id+1].time.timeIntervalSince(i.time)
                total+=t
            }
            else {
                let t = d.timeIntervalSince(i.time)
                total+=t
            }
        }
        //print(self.timer_format(total)!)
        return self.timer_format(total)!
    }
    
    func _get_timer_for_date(_ request:Date, wear: Bool) -> TimeInterval{
        var total:TimeInterval = 0
        if self.intervals.count == 0 {
            return total
        }
        
        var intervals = self.intervals.filter{ $0.time.belongTo(date: request) }
        
        if intervals == [] {
            let tmp = self.intervals.filter{ $0.timestamp < request.timestamp() }
            if (tmp == []) || (tmp.last.wear != wear) {
                return total
            }
            let local = request.setTime(hour: 0, min: 0, sec: 0)!
            intervals.append(DayInterval(tmp.last.id+1, wear: wear,time: local))
            intervals.append(DayInterval(tmp.last.id+2, wear: wear,time: request))
        }
        else {
            if intervals.first.wear != wear {
                let local = request.setTime(hour: 0, min: 0, sec: 0)!
                intervals.prepend(DayInterval(intervals.first.id-1, wear: wear,time: local))
            }
            
            if intervals.last.wear == wear {
                intervals.append(DayInterval(intervals.last.id+1, wear: !wear,time: request))
            }
        }
            
        for (start, end) in intervals.pairs() {
            total += end!.time.timeIntervalSince(start.time)
        }
        
        return total
    }
    
    
    func get_wear_timer_for_date(update_time:Date?)->TimeInterval{
        return _get_timer_for_date(update_time!, wear: true)
    }
    
    func get_off_timer_for_date(update_time:Date?)->TimeInterval{
        return  _get_timer_for_date(update_time!, wear: false)
    }
  
    func get_off_timer_for_today(d:Date) -> String{
        return _get_timer_for_today(d: d, wear: false)
    }

    func get_wear_timer_for_today(d:Date) -> String{
        return _get_timer_for_today(d: d, wear: true)
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
  
    
    func update_today_dates() {
        let days_interval = Date().timeIntervalSince(self.start_treatment)
        let days_formated_string = String(days_interval.days)
        if (self.wearing_aligners_days != days_formated_string){
            self.wearing_aligners_days = days_formated_string
        }
        
        let days_left_digit = ((self.required_aligners_total-(self.aligner_number_now-1)) * self.aligner_wear_days) - self.current_aligner_days
        
        let days_left_string = String(days_left_digit)
        if (self.days_left != days_left_string){
             self.days_left = days_left_string
        }
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
        
        let selected_date = self.selected_date! //(wear == true) ? self.selected_date! : self.selected_date.advanced(by: -86400)
        
        let previous_intervals = self.intervals.filter{ $0.time.belongTo(date: selected_date) }
        
        if previous_intervals != [] {
            let lastdate = previous_intervals.max { a, b in a.id < b.id }!
            let intervals = self.intervals.filter {
                ($0.time.belongTo(date: self.selected_date) || $0.time.belongTo(date: lastdate.time, toGranularity: .minute))
                    &&
                    ($0.wear == wear)
            }
            return intervals
        }
        else {
            return _filter(d: self.selected_date, wear: wear)
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
        return date.belongTo(date: self.selected_date)
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
        
        var trigger = UNTimeIntervalNotificationTrigger(timeInterval: time_interval, repeats: false)
        var request = UNNotificationRequest(identifier: notification_identifier01, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        content.body = "Don’t forget to put your aligners on"

        trigger = UNTimeIntervalNotificationTrigger(timeInterval: time_interval+120, repeats: false)
        request = UNNotificationRequest(identifier: notification_identifier02, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

        content.body = "Your aligners have been out for a while now. It’s time to put them back on"

        trigger = UNTimeIntervalNotificationTrigger(timeInterval: time_interval+420, repeats: false)
        request = UNNotificationRequest(identifier: notification_identifier03, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func remove_notification(){
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [notification_identifier01])
        center.removeDeliveredNotifications(withIdentifiers: [notification_identifier01])
        center.removePendingNotificationRequests(withIdentifiers: [notification_identifier02])
        center.removeDeliveredNotifications(withIdentifiers: [notification_identifier02])
        center.removePendingNotificationRequests(withIdentifiers: [notification_identifier03])
        center.removeDeliveredNotifications(withIdentifiers: [notification_identifier03])
    }
    
    /// Calendar Manager
    
    func update_min_max_dates(){
        self.minimumDate = self.intervals.min()!.time
        self.maximumDate = self.intervals.max()!.time
    }
}

