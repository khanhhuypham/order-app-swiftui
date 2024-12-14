//
//  DropDown.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 02/12/2024.
//

import SwiftUI

struct DropDownMenu: View {
    var friuts = [
        "apple",
        "banana",
        "orange",
        "kiwi",
        "kiwi",
        "kiwi"
        
    ]
    @State private var selectedFruit: String = "banana"

    var body: some View {
        VStack {
            Picker("fruits", selection: $selectedFruit) {
                ForEach(friuts, id: \.self) { fruit in
                    Text(fruit)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color(UIColor.lightGray).opacity(0.4))

    }
}
#Preview {
    DropDownMenu()
}
