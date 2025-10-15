//
//  TodoView.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 14/10/25.
//

import SwiftUI


struct TodoView: View {
    
    @StateObject var viewModel = ToDoListViewModel()

    @State private var isAlertShowing = false
    @State private var itemDescriptionInput = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.items) { item in
                HStack {
                    Text(item.title)
                    Spacer()
                    if item.isCompleted {
                        Image(systemName: "checkmark")
                    }
                }
                .onTapGesture { viewModel.toggleCompletion(for: item) }
                }
            }
            .navigationTitle("ToDo List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isAlertShowing.toggle() }, label: { Image(systemName: "plus") })
                }
            }
            .alert("Add a ToDo Item", isPresented: $isAlertShowing) {
                TextField("Item Description", text: $itemDescriptionInput)
                Button("Cancel", role: .cancel, action: clearInputs)
                Button("OK", action: addItem)
            }
        }
    }
    
    private func addItem() {
      viewModel.addItem(itemDescriptionInput)
      clearInputs()
    }

    private func clearInputs() {
      itemDescriptionInput = ""
    }
}

#Preview{
    TodoView()
}
