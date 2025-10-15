//
//  ContentView.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 14/10/25.
//
import SwiftUI

struct CounterView: View {
    @StateObject var viewModel = CounterViewModel()

    var body: some View {
        VStack {
            Text("Count: \(viewModel.count)")
            Button("Increment", action: viewModel.increment)
            Button("Decrement", action: viewModel.decrement)
        }
    }
}
