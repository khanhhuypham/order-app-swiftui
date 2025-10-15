//
//  CounterViewModel.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 14/10/25.
//
import SwiftUI

class CounterViewModel: ObservableObject {
  @Published var count: Int = 0

  func increment() {
    count += 1
  }

  func decrement() {
    count -= 1
  }
}
