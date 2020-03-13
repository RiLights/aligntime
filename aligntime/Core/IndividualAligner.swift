//
//  IndividualAligner.swift
//  aligntime
//
//  Created by Ostap on 20/02/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import Foundation

class IndividualAligner: Identifiable,ObservableObject,Codable{
    var id: Int = 0
    var days:Int = 7
    var aligner_number:Int = 1
    
    init(){}
    init(_ id: Int, days: Int, aligner_number: Int ) {
        self.days = days
        self.aligner_number = aligner_number
        self.id = id
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case days
        case aligner_number
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        days = try values.decode(Int.self, forKey: .days)
        aligner_number = try values.decode(Int.self, forKey: .aligner_number)
    }
}
