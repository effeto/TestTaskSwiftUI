//
//  Font + Extension.swift
//  TestTask
//
//  Created by Демьян on 22.04.2023.
//

import SwiftUI

extension Font {
    enum OpenSans {
        case regular
        case bold
        
        var value: String {
            switch self {
            case .regular:
                return "OpenSans-Regular"
                
            case .bold:
                return "OpenSans-Bold"
            }
        }
    }
    
    static func openSans(_ type: OpenSans, size: CGFloat) -> Font {
            return .custom(type.value, size: size)
        }
}
