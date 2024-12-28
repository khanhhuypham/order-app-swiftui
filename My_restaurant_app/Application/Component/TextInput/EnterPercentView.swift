//
//  EnterPercentView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 20/09/2024.
//

import SwiftUI
import PopupView
import Combine



struct EnterPercentView: View {
    @Binding var isPresent:Bool
    var id = 0
    var percent:Int? = nil
    var title:String = "GIẢM GIÁ MÓN"
    var placeholder:String = "Vui lòng nhập % bạn muốn giảm giá"
    var completion:((Int,Int) -> Void)? = nil
    var body: some View {
        dialog(isPresented: $isPresent){
            EnterPercentContent(isPresent: $isPresent,id: id,percent: percent,title: title,placeholder:placeholder,completion: completion)
        }
    }

}

struct EnterPercentContent: View {
    @Injected(\.fonts) var font: Fonts
    @Injected(\.colors) var color: ColorPalette
    @Binding var isPresent:Bool
    var id:Int
    @State var percent:Int? = nil
    var title:String
    var placeholder:String
    var completion:((Int,Int) -> Void)? = nil
    var body: some View {
        
        
        VStack(spacing:0) {
            
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(color.orange_brand_900)
                .padding(.top,20)
          
            TextField(placeholder,value: $percent,format: .number)
                .keyboardType(.numberPad)
                .font(font.r_13)
                .frame(height: 38)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 6))
                .cornerRadius(8)
                .overlay(
                  // Placeholder and border overlay
                  RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(uiColor: .systemGray3), lineWidth: 1) // Border
                )
                .background(color.gray_200)
                .padding(.vertical,20).padding(.horizontal,20)
                .onReceive(Just(percent)) { value in
                    
                    if value ?? 0 > 100{
                        self.percent = 100
                    }
                    
                }
    
            
    
            HStack(spacing:0){
                Button {
                    isPresent = false
                } label: {
                    Text("HUỶ")
                        .font(font.b_18)
                        .frame(maxWidth: .infinity,maxHeight:.infinity)
                        .foregroundColor(color.red_600)
                        .background(color.gray_200)
                }.buttonStyle(.plain)
                
                Button {
                    isPresent = false
                    if let percent = self.percent{
                        completion?(self.id,percent)
                    }
                    
                } label: {
                    Text("ĐỒNG Ý")
                        .font(font.b_18)
                        .frame(maxWidth: .infinity,maxHeight:.infinity)
                        .foregroundColor(.white)
                        .background(color.orange_brand_900)
            
                }
                .buttonStyle(.plain)
            }.frame(height: 50)
            
        }
        .background(.white)
        .shadowedStyle()
        .cornerRadius(10)
        .padding(.horizontal, 40)
        .onAppear(perform: {
            
        })
  
    }
}

#Preview {

    ZStack {
        EnterPercentView(isPresent: .constant(true))
    }
}
