//
//  Binding + extension.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 18/10/2024.
//

import SwiftUI

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
