//
//  Utils.swift
//  aligntime
//
//  Created by Ostap on 30/04/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import Foundation

func timer_format(_ second: TimeInterval) -> String? {
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .positional
    formatter.allowedUnits = [.hour, .minute, .second]
    formatter.zeroFormattingBehavior = .pad
    return formatter.string(from: second)
}

func hour_timer_format(_ second: TimeInterval) -> String? {
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .positional
    formatter.allowedUnits = [.hour, .minute]
    formatter.zeroFormattingBehavior = .pad
    return formatter.string(from: second+1)
}

func date_formatter_medium() ->DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}

func date_formatter_long() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
}
