//
//  AlignTime.swift
//  aligntime
//
//  Created by Ostap on 31/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import Foundation

class AlignTime {
    @Published var wear_timer:String = "00:00:00"
    @Published var out_timer:String = "00:00:00"

    func start_timer(){}
    
    func stop_timer(){}
    
    func get_total_wear_time() ->String{return ""}
    
    func get_total_off_time() ->String{return ""}
    
    func get_wear_time_for_date(date:Date) ->String{return ""}
    
    func get_off_time_for_date(date:Date) ->String{return ""}
    
    func get_wearing_days() ->Int{return 0}
    
    func get_days_to_treatment_end() ->Int{return 0}
}
