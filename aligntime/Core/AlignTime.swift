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
    @Published var elapsed_time:TimeInterval = TimeInterval()
    @Published var out_elapsed_time:TimeInterval = TimeInterval()
    
    @Published var complete:Bool = false
    
    var days: [Date: [String: TimeInterval]] = [:]

    
    @objc func update_timer() {
        if self.play_state{
            let elapsed_time = Date().timeIntervalSince(self.start_time)
            self.wear_timer = self.timer_format(second:elapsed_time)!
            self.elapsed_time = elapsed_time
        }
        else{
            let elapsed_time = Date().timeIntervalSince(self.out_time)
            self.out_timer = self.timer_format(second:elapsed_time)!
            self.out_elapsed_time = elapsed_time
        }
    }
    
    func start_timer(){
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update_timer), userInfo: nil, repeats: true)
    }
        
    func start_wear(){
        self.start_time = Date().addingTimeInterval((self.elapsed_time)*(-1))
    }
    
    func out_wear(){
        self.out_time = Date().addingTimeInterval((self.out_elapsed_time)*(-1))
    }
    
    func timer_format(second: TimeInterval) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: second)
    }
    
    func get_total_wear_time() ->String{return ""}
    
    func get_total_off_time() ->String{return ""}
    
    func get_wear_time_for_date(date:Date) ->String{return ""}
    
    func get_off_time_for_date(date:Date) ->String{return ""}
    
    func get_wearing_days() ->Int{return 0}
    
    func get_days_to_treatment_end() ->Int{return 0}
    
    func push_user_defaults(){
        defaults.set(require_count, forKey: "require_count")
        defaults.set(aligners_count, forKey: "aligners_count")
        defaults.set(start_treatment.timeIntervalSince1970, forKey: "start_treatment")
        defaults.set(align_count_now, forKey: "align_count_now")
        defaults.set(days_wearing, forKey: "days_wearing")
        
        defaults.set(complete, forKey: "collecting_data_complete")
        
    }
    func pull_user_defaults(){
        self.require_count = defaults.integer(forKey: "require_count")
        self.aligners_count = defaults.integer(forKey: "aligners_count")
        self.start_treatment = Date(timeIntervalSince1970:defaults.double(forKey: "start_treatment"))
        self.align_count_now = defaults.integer(forKey: "align_count_now")
        self.days_wearing = defaults.integer(forKey: "days_wearing")
        
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
}
