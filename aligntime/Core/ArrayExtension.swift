//
//  ArrayExtension.swift
//  aligntime
//
//  Created by Ostap on 12/02/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import Foundation

extension Array {
    func pair(at i: Index) -> (Element, Element?) {
        return (self[i], i < self.count - 1 ? self[i+1] : nil)
    }

    func pairs() -> [(Element, Element?)] {
        guard !isEmpty else { return [] }
        return (0..<(self.count/2 + self.count%2)).map { pair(at: $0*2) }
    }
    
    mutating func prepend(_ newElement: Element) {
        self.insert(newElement, at: 0)
    }
    
    var last: Element {
        return self[self.endIndex - 1]
    }
    
    var first: Element {
        return self[0]
    }
}
