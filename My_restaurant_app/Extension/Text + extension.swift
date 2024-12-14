//
//  Text + extension.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 13/09/2024.
//
/// extension to make applying AttributedString even easier

import Foundation
import SwiftUI
extension Text {
    init(_ string: String, configure: ((inout AttributedString) -> Void)) {
        var attributedString = AttributedString(string) /// create an `AttributedString`
        configure(&attributedString) /// configure using the closure
        self.init(attributedString) /// initialize a `Text`
    }
    
}


