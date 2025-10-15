//
//  TodoViewModel.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 14/10/25.
//

import SwiftUI



struct ToDoItem: Identifiable {
    let id = UUID()
    let title: String
    var isCompleted = false
}


class ToDoListViewModel: ObservableObject {
    @Published var items: [ToDoItem] = []

    func addItem(_ title: String) {
        items.append(ToDoItem(title: title))
    }

    func toggleCompletion(for item: ToDoItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
          items[index].isCompleted.toggle()
        }
    }
}
