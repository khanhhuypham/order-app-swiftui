//
//  Confirm_Cancel_Btn_Group.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 01/01/2025.
//

import SwiftUI

struct Confirm_Cancel_Btn_Group: View {
    @Injected(\.fonts) var font: Fonts
    @Injected(\.colors) var color: ColorPalette
    @State var validForm = true
    
    
    
    var body: some View {
       
        HStack(spacing:0){
            Button {

            } label: {
                Text("HUỶ")
                    .font(font.b_18)
                    .frame(maxWidth: .infinity,maxHeight:.infinity)
                    .foregroundColor(color.red_600)
                    .background(color.gray_200)
            }.buttonStyle(.plain)
            
            Button {
             
            } label: {
                Text(String("cập nhật").uppercased())
                    .font(font.b_18)
                    .frame(maxWidth: .infinity,maxHeight:.infinity)
                    .foregroundColor(.white)
                    .background(validForm ? color.orange_brand_900 : color.gray_600)
                    .disabled(validForm)
            }
            .buttonStyle(.plain)
        }.frame(height: 50)
    }
}

#Preview {
    Confirm_Cancel_Btn_Group()
}
