//
//  RadioButton.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 01/01/2025.
//

import SwiftUI

struct RadioButton: View {
    @Injected(\.fonts) var font: Fonts
    @Injected(\.colors) var color: ColorPalette
    let id: Int
    let label: String
    let isSelected: Bool
    let action: () -> Void
    

    var body: some View {
        Button(action: self.action) {
            HStack{
                Image(self.isSelected 
                    ? "icon-radio-check"
                    : "icon-radio-uncheck",
                      bundle: .main)
                Text(self.label)
                    .foregroundColor(.black)
                    .font(font.r_14)
            }
         
        }
    }
}

#Preview{
    RadioButton(id:0, label: "Huy", isSelected: true, action: {
        dLog("sdsad")
    })
}
