//
//  CustomFontSize.swift
//  aligntime
//
//  Created by Ostap on 4/05/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI

struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var size: CGFloat

    func body(content: Content) -> some View {
       let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.system(size: scaledSize))
    }
}

extension View {
    func scaledFont(size: CGFloat) -> some View {
        return self.modifier(ScaledFont(size: size))
    }
}

extension Font {

    #if canImport(UIKit)

    static var myHeadline = Font.custom(
        "Your-Font-Name",
        size: UIFontMetrics(forTextStyle: .headline).scaledValue(for: 17)
    )

    #endif
}
