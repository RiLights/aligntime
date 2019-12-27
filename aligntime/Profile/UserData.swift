//
//  UserData.swift
//  aligntime
//
//  Created by Ostap on 24/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import Combine
import SwiftUI

final class UserData: ObservableObject {
    let defaults = UserDefaults.standard
    
    @Published var require_count:Int = 75
    @Published var aligners_count:Int = 7
    @Published var start_treatment:Date = Date()
    @Published var align_count_now:Int = 4
    @Published var days_wearing:Int = 6
    
    @Published var complete:Bool = false
    
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
}


