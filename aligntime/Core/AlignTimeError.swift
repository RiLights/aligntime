//
//  AlignTimeError.swift
//  aligntime
//
//  Created by Ostap on 11/01/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import Foundation

enum AlignTimeError: Error {
    case ThereIsNoMakeSenseException(date1: Int, date2: Int)
}
