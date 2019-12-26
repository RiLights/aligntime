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
    @Published var require_count:Int = 75
    @Published var aligners_count:Int = 7
    @Published var start_treatment:Date = Date()
    @Published var align_count_now:Int = 4
    @Published var days_wearing:Int = 6
    
    @Published var complete:Bool = true
}
