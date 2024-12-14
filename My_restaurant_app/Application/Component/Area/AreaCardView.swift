//
//  AreaView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 11/10/2024.
//

import SwiftUI

struct AreaCardView: View {
    @Injected(\.colors) var color: ColorPalette
    @Injected(\.fonts) var font: Fonts
    @Binding var item:Area

    var body:some View{
        ZStack {
            Rectangle()
                .fill(item.status == ACTIVE ? color.blue_brand_700 : color.gray_400)
                .cornerRadius(8)


           // Content (Icon and Text)
           VStack {
               Image("icon-area", bundle: .main)
                   .resizable()
                   .frame(width: 40,height: 40)
                   .foregroundColor(.white)
                   .padding(.bottom, 5)

               Text(item.name)
                   .font(font.b_16)
                   .foregroundColor(.white)
                   .multilineTextAlignment(.center)
           }
       }
//       .frame(width: 100)
    }
    
}

#Preview {
    ZStack {
        Rectangle()
            .ignoresSafeArea()
        AreaCardView(item: .constant(Area()))
    }
}
