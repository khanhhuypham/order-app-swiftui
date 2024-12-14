//
//  HorizontalBtnGroup.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 11/10/2024.
//

import SwiftUI

struct HorizontalBtnGroup: View {
    @Injected(\.fonts) var font: Fonts
    @Injected(\.colors) var color: ColorPalette
    @Binding var btnArray:[(id:Int,title:String,isSelect:Bool)]
    var clickClosure:((Int) -> Void)? = nil

    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                ForEach(Array(btnArray.enumerated()), id: \.offset){i,element in
                    Button(action: {
                        // Action for Món ăn
                        for (j,btn) in btnArray.enumerated(){
                            btnArray[j].isSelect = i == j ? true : false
                        }
                        if let clickClosure = self.clickClosure{
                            clickClosure(element.id)
                        }
                        
                    }) {
                        Text(element.title)
                            .font(font.sb_13)
                            .foregroundColor(element.isSelect ? .white : color.orange_brand_900)
                            .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
//
                    }
                    .overlay(RoundedRectangle(cornerRadius: 20, style: .circular).stroke(color.orange_brand_900, lineWidth: 2))
                    .background(element.isSelect ? color.orange_brand_900 : .white)
                    .cornerRadius(25)
                }
            }
        }
        .padding(.vertical,10)
    }
}

#Preview {
    HorizontalBtnGroup(btnArray: .constant([
        (id:0,title:"Vé buffet",isSelect:false),
        (id:1,title:"Món ăn",isSelect:false),
        (id:2,title:"Nước uống",isSelect:false)
    ]))
}
