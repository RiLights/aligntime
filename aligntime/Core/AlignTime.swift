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
    
    @Published var required_aligners_total:Int = 50
    @Published var aligners_wear_days:Float = 7
        {
            didSet{
                self.update_induvidual_aligners_from_aligner(aligner_number:self.aligner_number_now)
            }
        }
    @Published var start_treatment:Date = Date()
        {
            didSet{
                //print("sss",Float(Date().timeIntervalSince(start_treatment).days))
                if !self.complete {
                    if self.aligner_number_now == 1 {
                        self.days_wearing = Float(Date().timeIntervalSince(start_treatment).days)+1
                    }
                }
            }
        }
    @Published var aligner_number_now:Int = 1
    @Published var days_wearing:Float = 1
    @Published var wear_hours:Float = 20
    @Published var show_current_date:Bool = false
    @Published var show_aligner_description:Bool = true
    @Published var start_date_for_current_aligners:Date = Date()
    @Published var aligner_time_notification:Date = Calendar.current.date(bySettingHour: 20, minute: 0, second: 0, of: Date())!
    
    @Published var days_left:String = "1"
    @Published var days_left_on_aligner:Int = 1
    @Published var wearing_aligners_days:Int = 0
    
    @Published var complete:Bool = false
    
    
    @Published var calendar = Calendar.current
    @Published var expanded_calendar:Bool = false
    @Published var minimumDate: Date = Date()
    @Published var maximumDate: Date = Date() //.addingTimeInterval(60*60*24*2)
    @Published var startDate: Date! = nil
    @Published var endDate: Date! = nil
    
    @Published var intervals:[DayInterval] = [DayInterval(0, wear: true, time: Calendar.current.startOfDay(for: Date()))] //test_intervals()
    @Published var aligners:[IndividualAligner] = []

    @Published var selected_date: Date! = Date()//nil
    @Published var selected_month = Calendar.current.dateComponents(in: .autoupdatingCurrent, from: Date()).month ?? 0
    
    @Published var current_state = true
    @Published var showing_profile = false
    
    let notification_identifier01 = "AlignTime.id.01"
    let notification_identifier02 = "AlignTime.id.02"
    let notification_identifier03 = "AlignTime.id.03"
    let notification_identifier04 = "AlignTime.id.04"
    let notification_identifier_aligner = "AlignTime.id.aligner"
    let notification_center = UNUserNotificationCenter.current()
    
    var colors = RKColorSettings()
    let calendarUnitYMD = Set<Calendar.Component>([.year, .month, .day])
    
    func set_default_values() {
        required_aligners_total = 50
        aligners_wear_days = 7
        start_treatment = Date()
        aligner_number_now = 1
        start_date_for_current_aligners = Date()
        show_current_date = false
        show_aligner_description = true
        days_wearing = 1
        wear_hours = 20
        current_state = true
        showing_profile = false
        days_left = "1"
        aligner_time_notification = Calendar.current.date(bySettingHour: 20, minute: 0, second: 0, of: Date())!
        
        aligners = []
        intervals = [DayInterval(0, wear: true, time: Calendar.current.startOfDay(for: Date()))]
        selected_date = Date()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100), execute: {
            self.complete = false
        })
        
    }
    
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
                if intervals.count != self.intervals.count {
                    let local = request.setTime(hour: 0, min: 0, sec: 0)!
                    intervals.prepend(DayInterval(intervals.first.id-1, wear: wear,time: local))
                }
                else{
                    intervals.prepend(DayInterval(intervals.first.id-1, wear: wear,time: intervals.first.time))
                }
            }
            if intervals.last.wear == wear {
                intervals.append(DayInterval(intervals.last.id+1, wear: !wear,time: request))
            }
        }

        for (start, end) in intervals.pairs() {
            if end != nil{
                total += end!.time.timeIntervalSince(start.time)
            }
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
    
    // MARK: - Expected Aligner
    
    func get_expected_aligner_for_date(date:Date)->(Int,Int){
        let start_date = Calendar.current.startOfDay(for: self.start_date_for_current_aligners)
        //let _date = date.convertToTimeZone(initTimeZone: .current, timeZone: TimeZone(secondsFromGMT: 0)!)
        let tz = TimeZone.current
        var seconds_past = date.timeIntervalSince(start_date)
        if tz.isDaylightSavingTime(for: date) {
            if seconds_past>0{
                seconds_past+=3600
            }
        }
        let days_past = abs(seconds_past).days
        
        //print("seconds_past",seconds_past)
        if days_past==0 {return (Int(self.aligner_number_now),Int(self.days_wearing))}
        
        var expected_aligner = Int(self.aligner_number_now)
        var current_aligner_day = Int(self.days_wearing)
        
        if expected_aligner>self.required_aligners_total{ return (self.required_aligners_total,self.aligners[self.required_aligners_total-1].days) }
        
        if seconds_past>0{
            //if self.aligners[expected_aligner-1].days<days_past{return (expected_aligner,self.aligners[expected_aligner-1].days)}
            (expected_aligner,
                current_aligner_day) = forward_walking_wearing_days(days_past: days_past)
        }
        else{
            (expected_aligner,
                current_aligner_day) = backward_walking_wearing_days(days_past: days_past)
        }
        return (expected_aligner,current_aligner_day)
    }
    
    func forward_walking_wearing_days(days_past:Int)->(Int,Int){
        var expected_aligner = Int(self.aligner_number_now)
        var current_aligner_day = Int(self.days_wearing)
        
        var day_index = 0
        
        while (day_index < days_past){
            if (self.aligners.count == 0) {return (expected_aligner,current_aligner_day)}
            if (self.aligners.count < expected_aligner) {return (expected_aligner,1)}
//            if (self.aligners.count == expected_aligner) {
//                if self.aligners[expected_aligner-1].days<days_past{
//                    return (expected_aligner,self.aligners[expected_aligner-1].days)
//                }
//            }
            
            let aligner_days = self.aligners[expected_aligner-1].days
            if current_aligner_day >= aligner_days{
                expected_aligner+=1
                current_aligner_day = 1
            }
            else{
                current_aligner_day+=1
            }
            day_index+=1
        }
        return (expected_aligner,current_aligner_day)
    }
    
    func backward_walking_wearing_days(days_past:Int)->(Int,Int){
        var expected_aligner = Int(self.aligner_number_now)
        var current_aligner_day = Int(self.days_wearing)
        var day_index = 0
//        if expected_aligner == 1{
//            day_index = -1
//        }
        
        while (day_index < days_past){
            if (self.aligners.count == 0) {return (expected_aligner,current_aligner_day)}
            if expected_aligner == 0 {return (expected_aligner,current_aligner_day)}
            if current_aligner_day == 1{
                expected_aligner-=1
                if expected_aligner == 0 { return (expected_aligner,current_aligner_day)}
                let aligner_offset = expected_aligner-1
                let aligner_days = self.aligners[aligner_offset].days
                current_aligner_day = aligner_days
            }
            else{
                current_aligner_day-=1
            }
            day_index+=1
        }

        return (expected_aligner,current_aligner_day)
    }
    
    func is_last_day_for_aligner(aligner:Int,day_count:Int)->Bool{
        if aligner <= 0 {return false}
        let aligner_offset = aligner-1
        if aligner_offset < self.aligners.count{
            let aligner_days = self.aligners[aligner_offset].days
            if day_count == aligner_days{
                return true
            }
        }
        return false
    }
    
    func get_custom_aligners_days_left(start_aligner:Int)->Int{
        var days:Int = 0
        var skip_default = false
        for i in (1...Int(self.required_aligners_total)){
            
            if i>start_aligner{
                for custom_aligner in self.aligners{
                    if custom_aligner.aligner_number == i{
                        days += custom_aligner.days
                        skip_default = true
                        continue
                    }
                }
                if skip_default{
                    skip_default = false
                    continue
                }
                days += Int(self.aligners_wear_days)
            }
        }
        return days
    }
    
    func get_days_for_current_aligner()->Int{
        var d_count = 1
        if self.aligner_number_now>0 && self.aligners.count>1{
            let aligner_offset = self.aligner_number_now-1
            if self.aligners.count<=aligner_offset { return self.aligners[self.required_aligners_total-1].days }
            d_count = self.aligners[aligner_offset].days
        }
        return d_count
    }
    
    func get_days_to_change_aligner(aligner_number:Int,curent_aligner_day:Int)->Int{
        let aligner_offset = aligner_number-1
        //if  aligner_offset<0 { return 0 }
        
        if aligner_offset < self.aligners.count{
            let aligner_days = self.aligners[aligner_offset].days
            if curent_aligner_day <= aligner_days{
                let days_left = aligner_days-curent_aligner_day
                return days_left
            }
        }
        return 0
    }
    
    // MARK: - Updates
    
    func update_today_dates() {
        if required_aligners_total<aligner_number_now{return}
        update_individual_aligners()
        update_expected_aligner_data()
        update_aligner_notification()
        
        let days_interval = Date().timeIntervalSince(self.start_treatment)
        self.wearing_aligners_days = days_interval.days
        
        let aligners_days_left:Int = get_custom_aligners_days_left(start_aligner:Int(self.aligner_number_now)-1)
        let total_days_left_digit:Int = aligners_days_left - Int(self.days_wearing)
        
        let days_left_string = String(total_days_left_digit)
        if (self.days_left != days_left_string){
             self.days_left = days_left_string
        }
        
        current_state = self.intervals.last.wear
    }
    
    func update_individual_aligners(){
        if self.aligners.count != self.required_aligners_total{
            var res:[IndividualAligner] = []
            if self.aligners.count == 0{
                for i in 1..<Int(self.required_aligners_total)+1{
                    res.append(IndividualAligner(i-1,days:Int(self.aligners_wear_days),aligner_number:i))
                }
            }
            else if self.aligners.count < self.required_aligners_total{
                for i in 1..<Int(self.required_aligners_total)+1{
                    var check_in = false
                    for a in self.aligners{
                        if a.aligner_number == i{
                            check_in = true
                            res.append(a)
                        }
                    }
                    if !check_in{
                        res.append(IndividualAligner(i-1,days:Int(self.aligners_wear_days),aligner_number:i))
                    }
                }
            }
            else if self.aligners.count > self.required_aligners_total{
                res = self.aligners.dropLast(self.aligners.count-self.required_aligners_total)
            }
            res.sort(by: { $0.aligner_number < $1.aligner_number })
            self.aligners = res
        }
    }
    

    
    func update_induvidual_aligners_from_aligner(aligner_number:Int){
        for i in self.aligners{
            if i.aligner_number>=aligner_number{
                i.days=Int(self.aligners_wear_days)
            }
        }
    }
    
    func update_expected_aligner_data(date:Date = Date()){
        let (expected_aligner,current_aligner_day) = self.get_expected_aligner_for_date(date:date)
        if required_aligners_total<expected_aligner{return}
        
        self.aligner_number_now = expected_aligner
        self.start_date_for_current_aligners = Date()
        self.days_wearing = Float(current_aligner_day)
    }
    
    func update_min_max_dates(){
        if self.intervals.count != 0 {
            self.minimumDate = Date().fromTimestamp( self.intervals.min()!.timestamp )
            self.maximumDate = Date().fromTimestamp( self.intervals.max()!.timestamp )
        }
    }
    
    func update_aligner_notification(){
        self.days_left_on_aligner = get_days_to_change_aligner(aligner_number: Int(self.aligner_number_now), curent_aligner_day: Int(self.days_wearing))
        let date_offset = Calendar.current.date(byAdding: .day, value: self.days_left_on_aligner, to: Date())
        
        let hour = calendar.component(.hour, from: self.aligner_time_notification)
        let minutes = calendar.component(.minute, from: self.aligner_time_notification)
        let seconds = calendar.component(.second, from: self.aligner_time_notification)
        
        let notification_time = Calendar.current.date(bySettingHour: hour, minute: minutes, second: seconds, of: date_offset!)

        notification_center.removePendingNotificationRequests(withIdentifiers: [notification_identifier_aligner])
        notification_center.removeDeliveredNotifications(withIdentifiers: [notification_identifier_aligner])
        self.send_aligner_notification(time:notification_time!,aligner_number:Int(self.aligner_number_now))
    }
   
    func date_string_format(_ date: Date) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
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
    
    func total_wear_time_for_date(date:Date)->TimeInterval{
        var selected_date = Date()
        if self.calendar.compare(selected_date, to: date, toGranularity: .day) == .orderedDescending {
            selected_date = Calendar.current.startOfDay(for: date)
            selected_date = selected_date.advanced(by: 86399)
        }
        let val = self.get_wear_timer_for_date(update_time: selected_date)
        return val
    }
    
    func is_date_present(_ date: Date) -> Bool {
        if self.calendar.compare(date, to: self.minimumDate, toGranularity: .day) == .orderedAscending || self.calendar.compare(date, to: self.maximumDate, toGranularity: .day) == .orderedDescending {
            return false
        }
        return true
    }
    
    func is_date_enabled(date: Date) -> Bool {
        let clampedDate = self.RKFormatDate(date: date)
        return self.is_date_present(clampedDate)
    }
    
    func RKFormatDate(date: Date) -> Date {
        let components = self.calendar.dateComponents(calendarUnitYMD, from: date)
        
        return self.calendar.date(from: components)!
    }
    
    func RKFormatAndCompareDate(date: Date, referenceDate: Date) -> Bool {
        let refDate = RKFormatDate(date: referenceDate)
        let clampedDate = RKFormatDate(date: date)
        return refDate == clampedDate
    }
    
    func isToday(date: Date) -> Bool {
        return RKFormatAndCompareDate(date: date, referenceDate: Date())
    }
    
    func is_in_wear_time_target(date:Date) -> Bool{
        if self.is_date_enabled(date: date){
            if !self.isToday(date: date){
                if Int(self.total_wear_time_for_date(date:date))<((Int(self.wear_hours)*60*60)-1){
                    return false
                }
            }
        }
        return true
    }
    
    // MARK: - Notifications
    
    func send_aligner_notification(time:Date,aligner_number:Int){

        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("AlignTime Reminder",comment: "")
        content.body = String(format:
                        NSLocalizedString("last_aligner # %d",comment: ""),aligner_number+1)
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "AlignerAlignTimeNotification"
        content.threadIdentifier = "aligner-aligntime"
        content.summaryArgument = "AlignTime"
        
        let comps = Calendar.current.dateComponents([.year,.day,.month,.hour,.minute], from: time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)
        let request = UNNotificationRequest(identifier: notification_identifier_aligner, content: content, trigger: trigger)
        notification_center.add(request, withCompletionHandler: nil)
    }

    func send_wear_notification(time_interval:Double){
        
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("AlignTime Reminder",comment: "")
        content.body = NSLocalizedString("Time to put your aligners on again",comment: "")
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "WearAlignTimeNotification"
        content.threadIdentifier = "wear-aligntime"
        content.summaryArgument = "AlignTime"
        
        var trigger = UNTimeIntervalNotificationTrigger(timeInterval: time_interval, repeats: false)
        var request = UNNotificationRequest(identifier: notification_identifier01, content: content, trigger: trigger)
        notification_center.add(request, withCompletionHandler: nil)
        
        content.body = NSLocalizedString("Don’t forget to put your aligners on",comment: "")

        trigger = UNTimeIntervalNotificationTrigger(timeInterval: time_interval+120, repeats: false)
        request = UNNotificationRequest(identifier: notification_identifier02, content: content, trigger: trigger)
        notification_center.add(request)

        content.body = NSLocalizedString("Your aligners have been out for a while now",comment: "")

        trigger = UNTimeIntervalNotificationTrigger(timeInterval: time_interval+420, repeats: false)
        request = UNNotificationRequest(identifier: notification_identifier03, content: content, trigger: trigger)
        notification_center.add(request)
        
        content.body = NSLocalizedString("Did you forget to start the timer?",comment: "")

        trigger = UNTimeIntervalNotificationTrigger(timeInterval: time_interval+1200, repeats: false)
        request = UNNotificationRequest(identifier: notification_identifier04, content: content, trigger: trigger)
        notification_center.add(request)
    }
    
    func remove_wear_notification(){
        notification_center.removePendingNotificationRequests(withIdentifiers: [notification_identifier01])
        notification_center.removeDeliveredNotifications(withIdentifiers: [notification_identifier01])
        notification_center.removePendingNotificationRequests(withIdentifiers: [notification_identifier02])
        notification_center.removeDeliveredNotifications(withIdentifiers: [notification_identifier02])
        notification_center.removePendingNotificationRequests(withIdentifiers: [notification_identifier03])
        notification_center.removeDeliveredNotifications(withIdentifiers: [notification_identifier03])
        notification_center.removePendingNotificationRequests(withIdentifiers: [notification_identifier04])
        notification_center.removeDeliveredNotifications(withIdentifiers: [notification_identifier04])
    }
}
