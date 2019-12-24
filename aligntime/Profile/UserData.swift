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
    @Published var start_treatment:Date = Date()
    @Published var aligners_start:Int = 0
    @Published var aligners_count:Int = 1
    @Published var complete:Bool = false
}
