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
    @Published var aligners_wear_days:Int = 7
    @Published var start_treatment:Date = Date()
    @Published var aligner_number_now:Int = 1
    @Published var current_aligner_days:Int = 1
    
    @Published var days_left:String = "0"
    @Published var wearing_aligners_days:String = "0"
    
    @Published var complete:Bool = false
    
    
    @Published var calendar = Calendar.current
    @Published var minimumDate: Date = Date()
    @Published var maximumDate: Date = Date() //.addingTimeInterval(60*60*24*2)
    @Published var startDate: Date! = nil
    @Published var endDate: Date! = nil
    
    @Published var intervals:[DayInterval] = test_intervals()//create_wear_intervals(intervals:days_intervals,type:true)
    @Published var aligners:[IndividualAligner] = [
        IndividualAligner(0,days:7,aligner_number:1)]

    @Published var selected_date: Date! = Date()//nil
    @Published var selected_month = Calendar.current.dateComponents(in: .current, from: Date()).month ?? 0
    
    @Published var current_state = true
    
    let notification_identifier01 = "AlignTime.id.01"
    let notification_identifier02 = "AlignTime.id.02"
    let notification_identifier03 = "AlignTime.id.03"
    
    var colors = RKColorSettings()

    
    func _get_timer_for_date(_ request:Date, wear: Bool) -> TimeInterval{
        var total:TimeInterval = 0
        if self.intervals.count == 0 {
            return total
        }
        
        var intervals = self.intervals.filter{ $0.belongTo(request) }
        
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
    
    
    func switch_timer(){
        let interval = DayInterval()
        interval.time=Date()
        interval.id = self.intervals.count
        interval.wear = current_state
        self.intervals.append(interval)
        push_user_defaults()
        update_min_max_dates()
    }
  
    
    func update_today_dates() {
        let days_interval = Date().timeIntervalSince(self.start_treatment)
        self.wearing_aligners_days = String(days_interval.days)
        
        let days_left_digit = ((self.required_aligners_total-(self.aligner_number_now-1)) * self.aligners_wear_days) - self.current_aligner_days
        
        let days_left_string = String(days_left_digit)
        if (self.days_left != days_left_string){
             self.days_left = days_left_string
        }
        update_individual_aligners()
    }
    
    func update_individual_aligners(){
        var res:[IndividualAligner] = []
        for i in 0..<self.required_aligners_total-1{
            res.append(IndividualAligner(i,days:7,aligner_number:i+1))
        }
        self.aligners = res
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
    
    func _interval_filter(wear: Bool) -> [DayInterval] {
        // Get last interval from previous day
        if self.selected_date == nil {
            return []
        }
        
        var intervals = self.intervals.filter{ $0.belongTo(self.selected_date) }
        if intervals == [] {
            return []
        }
                
        let previous_intervals = self.intervals.filter{ $0.timestamp < intervals.first.timestamp }
        if previous_intervals != [] {
            intervals.prepend(previous_intervals.last)
        }
        
        let next_intervals = self.intervals.filter{ $0.timestamp > intervals.last.timestamp }
        if next_intervals != [] {
            intervals.append(next_intervals.first)
        }
        else {
            let time = Date()
            intervals.append(DayInterval(intervals.last.id+1,wear: !intervals.last.wear,time: time ) )
        }
        
        if intervals.first.wear != wear {
            intervals.remove(at: 0)
        }
        
        var result:[DayInterval] = []
        for (s,e) in intervals.pairs() {
            if s.wear == wear && e != nil {
                result.append(s)
            }
        }
        
        return result
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
    
    func get_first_event_for_selected_date()->DayInterval{
        let previous_intervals = self.intervals.filter{ $0.timestamp < self.selected_date.timestamp()}
        return previous_intervals.last
    }
    
    func reasign_intervals_date_id(){
        self.intervals.sort(by: { $0.timestamp < $1.timestamp })
        for (i,_) in self.intervals.enumerated(){
            self.intervals[i].id = i
        }
        
        update_min_max_dates()
    }
    
    func add_new_event(to:[DayInterval]){
        var local_id:Int = 0
        var time:Date = Date()
        if to == []{
            let interval = get_first_event_for_selected_date()
            local_id = interval.id
            time = self.selected_date
        }
        else{
            local_id = to.last.id
            time = to.last.time
        }
        let wear_state = self.intervals[local_id].wear
        if wear_state{
            let d_off = DayInterval(local_id+1,
                                wear: false, time: time.advanced(by: 1))
            self.intervals.insert(d_off,at: local_id+1)
            let d_wear = DayInterval(local_id+2,
                                wear: true, time: time.advanced(by: 1))
            self.intervals.insert(d_wear, at: local_id+2)
        }
        else{
            let d_wear = DayInterval(local_id+1,
                                wear: true, time: time.advanced(by: 1))
            self.intervals.insert(d_wear, at: local_id+1)
            let d_off = DayInterval(local_id+2,
                                    wear: false, time: time.advanced(by: 1))
            self.intervals.insert(d_off, at: local_id+2)
        }
        reasign_intervals_date_id()
    }
    
    func remove_interesected_events(event_index:Int){
        if self.intervals.count<=event_index+1{
            return
        }
        
        let start_event:DayInterval = self.intervals[event_index]
        let end_event:DayInterval = self.intervals[event_index+1]
        
        for i in self.intervals{
            if (i.time>start_event.time) && (i.time<end_event.time){
                self.intervals.remove(at: i.id)
                reasign_intervals_date_id()
            }
        }
        force_event_order()
    }
    
    func force_event_order(){
        var previos_event = DayInterval(self.intervals[0].id,
                                        wear:!self.intervals[0].wear,
                                        time: self.intervals[0].time)
        for i in self.intervals{
            print("ss ",i.wear,i.id,i.time.description(with: .current))
            if (i.wear == previos_event.wear){
                let new_event = DayInterval(previos_event.id,
                                            wear:!previos_event.wear,
                                            time:previos_event.time)
                //new_event.wear = !new_event.wear
                new_event.time = new_event.time.advanced(by: 100)
                self.intervals.insert(new_event, at: new_event.id)
            }
            previos_event = i
        }
        reasign_intervals_date_id()
    }
    
    func push_user_defaults(){
        defaults.set(required_aligners_total, forKey: "require_count")
        defaults.set(aligners_wear_days, forKey: "aligners_count")
        defaults.set(start_treatment.timeIntervalSince1970, forKey: "start_treatment")
        defaults.set(aligner_number_now, forKey: "align_count_now")
        defaults.set(current_aligner_days, forKey: "days_wearing")
        defaults.set(complete, forKey: "collecting_data_complete")
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self.intervals) {
            defaults.set(encoded, forKey: "intervals")
        }
    }
  
    func pull_user_defaults(){
        self.required_aligners_total = defaults.integer(forKey: "require_count")
        if self.required_aligners_total == 0 {self.required_aligners_total = 75 }
        
        self.aligners_wear_days = defaults.integer(forKey: "aligners_count")
        if self.aligners_wear_days == 0 {self.aligners_wear_days = 7 }
        
        self.aligner_number_now = defaults.integer(forKey: "align_count_now")
        if self.aligner_number_now == 0 {self.aligner_number_now = 1 }
        
        self.current_aligner_days = defaults.integer(forKey: "days_wearing")
        if self.current_aligner_days == 0 {self.current_aligner_days = 1 }
        
        let start_treatment_raw = defaults.double(forKey: "start_treatment")
        if start_treatment_raw == 0{
            self.start_treatment = Date()
        }
        else{
            self.start_treatment = Date(timeIntervalSince1970:start_treatment_raw)
        }
        
        if let temp_data_intervals = defaults.object(forKey: "intervals") as? Data {
            let decoder = JSONDecoder()
            if let temp_intervals = try? decoder.decode([DayInterval].self, from: temp_data_intervals) {
                if temp_intervals != [] {
                    self.intervals = temp_intervals
                    for i in self.intervals{
                        i.time = Date().fromTimestamp(i.timestamp)
                    }
                    self.current_state = self.intervals[self.intervals.count-1].wear
                }
                else{
                    self.intervals = [DayInterval(0, wear: true, time: Date())]
                }
            }
        }
        
        self.complete = defaults.bool(forKey: "collecting_data_complete")
        self.update_min_max_dates()
    }
    

    func send_notification(time_interval:Double){
        
        let content = UNMutableNotificationContent()
        content.title = "AlignTime Reminder"
        content.body = "Time to put your aligners on again"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = notification_identifier01
        
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
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
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
        self.minimumDate = Date().fromTimestamp( self.intervals.min()!.timestamp )
        self.maximumDate = Date().fromTimestamp( self.intervals.max()!.timestamp )
    }
    
    func is_between(_ date: Date) -> Bool {
        if self.startDate == nil {
            return false
        } else if self.endDate == nil {
            return false
        } else if self.calendar.compare(date, to: self.startDate, toGranularity: .day) == .orderedAscending {
            return false
        } else if self.calendar.compare(date, to: self.endDate, toGranularity: .day) == .orderedDescending {
            return false
        }
        return true
    }
    
    func is_present(_ date: Date) -> Bool {
        if self.calendar.compare(date, to: self.minimumDate, toGranularity: .day) == .orderedAscending || self.calendar.compare(date, to: self.maximumDate, toGranularity: .day) == .orderedDescending {
            return false
        }
        return true
    }
}


func timer_format(_ second: TimeInterval) -> String? {
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .positional
    formatter.allowedUnits = [.hour, .minute, .second]
    formatter.zeroFormattingBehavior = .pad
    return formatter.string(from: second)
}

func hour_timer_format(_ second: TimeInterval) -> String? {
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .positional
    formatter.allowedUnits = [.hour, .minute]
    formatter.zeroFormattingBehavior = .pad
    return formatter.string(from: second+1)
}
