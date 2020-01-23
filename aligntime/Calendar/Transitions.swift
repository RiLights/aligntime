//
//  Transitions.swift
//  aligntime
//
//  Created by Ostap on 23/01/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI


var backward_transition: AnyTransition {
    let insertion = AnyTransition.move(edge: .trailing)
    let removal = AnyTransition.move(edge: .leading)
    return .asymmetric(insertion: insertion, removal: removal)
}

var forward_transition: AnyTransition {
    let insertion = AnyTransition.move(edge: .trailing)
    let removal = AnyTransition.move(edge: .leading)
    return .asymmetric(insertion: removal, removal: insertion)
}


