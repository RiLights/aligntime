//
//  EventExtension.swift
//  aligntime
//
//  Created by Yaryna Pochtarenko on 3/05/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import Foundation

extension AlignTime {
    
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
    
    func add_new_event(to:[DayInterval]) throws{
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
        if self.intervals.count==1{
             return
        }
        
        let start_event = self.intervals[event_index].timestamp
        var end_event = Date().timestamp()
        if self.intervals.count>event_index+1{
             end_event = self.intervals[event_index+1].timestamp
        }
        
        self.intervals = self.intervals.filter{ !(($0.timestamp > start_event) && ($0.timestamp < end_event)) }
        reasign_intervals_date_id()
        force_event_order()
    }
    
    func force_event_order(){
        if self.intervals.count == 0{
            return
        }
        var previos_event = DayInterval(self.intervals[0].id,
                                        wear:!self.intervals[0].wear,
                                        time: self.intervals[0].time)
        for i in self.intervals{
            if (i.wear == previos_event.wear){
                let new_event = DayInterval(previos_event.id,
                                            wear:!previos_event.wear,
                                            time:i.time.advanced(by: -2))
                //new_event.wear = !new_event.wear
                new_event.time = new_event.time.advanced(by: 1)
                self.intervals.insert(new_event, at: new_event.id)
            }
            previos_event = i
        }
        reasign_intervals_date_id()
    }
    
    func reasign_intervals_id(){
        for (i,v) in self.intervals.enumerated(){
            v.id = i
        }
        
        update_min_max_dates()
    }
}
