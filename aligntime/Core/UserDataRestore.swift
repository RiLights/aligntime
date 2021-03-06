//
//  UserDataRestore.swift
//  aligntime
//
//  Created by Ostap on 30/04/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import Foundation

extension AlignTime {
      func resetDefaults() {
            let defaults = UserDefaults.standard
            let dictionary = defaults.dictionaryRepresentation()
            dictionary.keys.forEach { key in
                defaults.removeObject(forKey: key)
            }
      }
    
      func push_user_defaults(){
          defaults.set(required_aligners_total, forKey: "require_count")
          defaults.set(aligners_wear_days, forKey: "aligners_count")
          defaults.set(start_treatment.timeIntervalSince1970, forKey: "start_treatment")
          defaults.set(aligner_number_now, forKey: "align_count_now")
          defaults.set(days_wearing, forKey: "days_wearing")
          defaults.set(wear_hours, forKey: "wear_hours")
          defaults.set(complete, forKey: "collecting_data_complete")
          defaults.set(show_current_date, forKey: "show_current_date")
          defaults.set(show_aligner_description, forKey: "show_aligner_description")
          defaults.set(start_date_for_current_aligners.timeIntervalSince1970, forKey: "start_date_for_current_aligners")
          defaults.set(aligner_time_notification.timeIntervalSince1970, forKey: "aligner_time_notification")
          
          let encoder = JSONEncoder()
          if let encoded = try? encoder.encode(self.intervals) {
              defaults.set(encoded, forKey: "intervals")
          }
          
          let encoder_aligners = JSONEncoder()
          if let encoded_aligners = try? encoder_aligners.encode(self.aligners) {
              defaults.set(encoded_aligners, forKey: "aligners")
          }
      }
    
      func pull_user_defaults(){
        self.required_aligners_total = defaults.integer(forKey: "require_count")
          if self.required_aligners_total == 0 {self.required_aligners_total = 50 }
          
        self.aligners_wear_days = Float(defaults.integer(forKey: "aligners_count"))
          if self.aligners_wear_days == 0 {self.aligners_wear_days = 7 }
          
        self.aligner_number_now = defaults.integer(forKey: "align_count_now")
          if self.aligner_number_now == 0 {self.aligner_number_now = 1 }
          
        self.days_wearing = Float(defaults.integer(forKey: "days_wearing"))
          if self.days_wearing == 0 {self.days_wearing = 1 }
        
        self.wear_hours = Float(defaults.integer(forKey: "wear_hours"))
          if self.wear_hours == 0 {self.wear_hours = 20 }
          
        self.show_current_date = defaults.bool(forKey: "show_current_date")
        self.show_aligner_description = defaults.bool(forKey: "show_aligner_description")
          
        let start_treatment_raw = defaults.double(forKey: "start_treatment")
          if start_treatment_raw == 0{
              self.start_treatment = Date()
          }
          else{
              self.start_treatment = Date(timeIntervalSince1970:start_treatment_raw)
          }
          
        let start_date_for_current_aligners_raw = defaults.double(forKey: "start_date_for_current_aligners")
          if start_date_for_current_aligners_raw == 0{
              self.start_date_for_current_aligners = Date()
          }
          else{
              self.start_date_for_current_aligners = Date(timeIntervalSince1970:start_date_for_current_aligners_raw)
          }
        
        let aligner_time_notification_raw = defaults.double(forKey: "aligner_time_notification")
          if aligner_time_notification_raw == 0{
            self.aligner_time_notification = Calendar.current.date(bySettingHour: 20, minute: 0, second: 0, of: Date())!
          }
          else{
             self.aligner_time_notification = Date(timeIntervalSince1970:aligner_time_notification_raw)
          }
          
          // Event
          if let temp_data_intervals = defaults.object(forKey: "intervals") as? Data {
              let decoder = JSONDecoder()
              if let temp_intervals = try? decoder.decode([DayInterval].self, from: temp_data_intervals) {
                  if temp_intervals != [] {
                    self.intervals = temp_intervals.chunked(into: 2000).last!
                      for i in self.intervals{
                          i.time = Date().fromTimestamp(i.timestamp)
                      }
                      self.current_state = self.intervals.last.wear
                  }
                  else{
                      self.intervals = [DayInterval(0, wear: true, time: Calendar.current.startOfDay(for: Date()))]
                      self.current_state = true
                  }
              }
          }
          
          // Aligners
          if let temp_data_aligners = defaults.object(forKey: "aligners") as? Data {
              let decoder_aligners = JSONDecoder()
              if let temp_aligners = try? decoder_aligners.decode([IndividualAligner].self, from: temp_data_aligners) {
                  if temp_aligners.count != 0 {
                      self.aligners = temp_aligners
                  }
                  else{
                      self.update_individual_aligners()
                  }
              }
          }
          
          self.complete = defaults.bool(forKey: "collecting_data_complete")
//          self.update_min_max_dates()
      }
}
