//
//  AlignTime.swift
//  aligntime
//
//  Created by Ostap on 31/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//
import Combine
import Foundation

final class AlignTime: ObservableObject {
    
    let defaults = UserDefaults.standard
    
    @Published var require_count:Int = 75
    @Published var aligners_count:Int = 7
    @Published var start_treatment:Date = Date()
    @Published var align_count_now:Int = 4
    @Published var days_wearing:Int = 6
    
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
    var days_string: [String: [String: Double]] = [:]//["2019/12/08":["wear":0]]

    
    @objc func update_timer() {
        //print(days_string)
        self.update_wear_timer()
        self.update_today_dates()
        //registering data everytime is not so nice
        //self.push_user_defaults()
    }
    
    func start_timer(){
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update_timer), userInfo: nil, repeats: true)
    }
    
    func update_wear_timer(){
        if self.play_state{
            let elapsed_time = Date().timeIntervalSince(self.start_time)
            self.wear_timer = self.timer_format(elapsed_time)!
            self.wear_elapsed_time = elapsed_time
            
            let date = self.date_format(date:Date())
            self.set_wear_time_for_date(date:date,interval: self.wear_elapsed_time)
        }
        else{
            let elapsed_time = Date().timeIntervalSince(self.out_time)
            self.out_timer = self.timer_format(elapsed_time)!
            self.out_elapsed_time = elapsed_time
            
            let date = self.date_format(date:Date())
            self.set_off_time_time_for_date(date:date,interval: self.out_elapsed_time)
        }
    }
    
    func update_today_dates(){
        let days_interval = Date().timeIntervalSince(self.start_treatment)
        let days_formated = self.day_format(days_interval)!.dropLast()
        let days_formated_string = String(days_formated)
        if (self.wearing_aligners_days != days_formated_string){
            self.wearing_aligners_days = days_formated_string
        }
        
        
        let days_left_digit = (self.aligners_count * self.require_count) - Int(days_formated_string)!
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
    
    func get_wear_time_for_date(date:Date) ->String{return ""}
    
    func get_off_time_for_date(date:Date) ->String{return ""}
    
    func get_wearing_days() ->Int{return 0}
    
    func get_days_to_treatment_end() ->Int{return 0}
    
    func set_wear_time_for_date(date:Date,interval:TimeInterval){
        let wear = ["wear": interval]
        self.days_string[self.date_string_format(date)!] = wear
    }

    func set_off_time_time_for_date(date:Date,interval:TimeInterval){
        let off_time = ["out": interval]
        self.days_string[self.date_string_format(date)!] = off_time
    }
    
//    func set_wear_time_for_date(date:Date,interval:TimeInterval){
//        self.days.updateValue(["wear" : interval], forKey: date)
//    }
//
//    func set_off_time_time_for_date(date:Date,interval:TimeInterval){
//        self.days.updateValue(["out" : interval], forKey: date)
//    }
    
    func push_user_defaults(){
        defaults.set(require_count, forKey: "require_count")
        defaults.set(aligners_count, forKey: "aligners_count")
        defaults.set(start_treatment.timeIntervalSince1970, forKey: "start_treatment")
        defaults.set(align_count_now, forKey: "align_count_now")
        defaults.set(days_wearing, forKey: "days_wearing")
        defaults.set(wearing_aligners_days, forKey: "wearing_aligners_days")
        defaults.set(days_left, forKey: "days_left")
        defaults.set(days_string, forKey: "days")
        
        defaults.set(complete, forKey: "collecting_data_complete")
        
    }
    func pull_user_defaults(){
        self.require_count = defaults.integer(forKey: "require_count")
        self.aligners_count = defaults.integer(forKey: "aligners_count")
        self.start_treatment = Date(timeIntervalSince1970:defaults.double(forKey: "start_treatment"))
        self.align_count_now = defaults.integer(forKey: "align_count_now")
        self.days_wearing = defaults.integer(forKey: "days_wearing")
        self.wearing_aligners_days = defaults.string(forKey: "wearing_aligners_days") ?? "0"
        self.days_left = defaults.string(forKey: "days_left") ?? "0"
        self.days_string = defaults.dictionary(forKey: "days") as? [String : [String : Double]] ?? days_string
        
        self.complete = defaults.bool(forKey: "collecting_data_complete")
    }
    
    func add_test_days(){
        let formatter_date = DateFormatter()
        formatter_date.dateFormat = "yyyy/MM/dd"
        let day1 = formatter_date.date(from: "2019/12/08")
        let day2 = formatter_date.date(from: "2019/12/09")

        let t1 = TimeInterval(exactly: 2000)
        let t2 = TimeInterval(exactly: 7000)
        let t3 = TimeInterval(exactly: 7000)
        self.days = [day1!: ["out":t1!,"wear":t2!],day2!:["out":t3!,"wear":t2!]]
    }
    
    func add_test_days_as_string(){
        let day1 = "2019/12/08"
        let day2 = "2019/12/09"

        let t1 = TimeInterval(exactly: 2000)
        let t2 = TimeInterval(exactly: 7000)
        let t3 = TimeInterval(exactly: 7000)
        self.days_string = [day1: ["out":t1!,"wear":t2!],day2:["out":t3!,"wear":t2!]]
    }
}
