//
//  EnterTextField.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 16/10/2024.
//

import SwiftUI
import Combine


struct EnterTextView: View {
    @Binding var isPresent:Bool
    var body: some View {
        PopupWrapper(){
            EnterTextContent(isPresent: $isPresent)
        }
    }
}


private struct EnterTextContent: View {
    @Binding var isPresent:Bool
    var delegate:EnterPercentDelegate?
    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color

    var id = 0
    @State var text:String = ""
    var title:String = "Thêm khu vực"
    var placeholder:String = "Tên khu vực"
    var titleOfBtnConfirm:String = "THÊM MỚI"
    var onConfirmPress: () -> Void = {}

    var body: some View {
        
        VStack{
            Spacer()
            mainContent
            Spacer()
        }.background(.clear)
    }
    
    private var mainContent:some View{
        VStack(spacing:0) {
            
            Text(title)
                .font(font.b_18)
                .foregroundColor(color.orange_brand_900)
                .padding(.top,20)
            

            TextField(placeholder, text: $text)
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
                } label: {
                    Text(titleOfBtnConfirm)
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
        EnterTextView(isPresent:.constant(true))
    }
   
}
