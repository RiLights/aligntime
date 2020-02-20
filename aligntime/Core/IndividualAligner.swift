//
//  IndividualAligner.swift
//  aligntime
//
//  Created by Ostap on 20/02/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import Foundation

class IndividualAligner: Identifiable,ObservableObject{
    var id: Int = 0
    @Published var days:Int = 7
    @Published var aligner_number:Int = 1
    
    init(){}
    init(_ id: Int, days: Int, aligner_number: Int ) {
        self.days = days
        self.aligner_number = aligner_number
        self.id = id
    }
    
}
