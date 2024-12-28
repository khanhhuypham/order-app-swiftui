//
//  NoteView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 20/09/2024.
//

import SwiftUI
import PopupView
import Combine


struct NoteView: View {
    @Binding var isPresent:Bool
    var id = 0
    @State var inputText = ""
    var completion:((Int,String) -> Void)? = nil
    

    var body: some View {
        PopupWrapper(isPresented: $isPresent){
            NoteContent(isPresent: $isPresent,id:id,inputText:inputText,completion:completion)
        }
    }
}



private struct NoteContent: View {
    @Injected(\.fonts) var fonts: Fonts
    @Injected(\.colors) var color: ColorPalette
    @State private var valid:Bool = false
    @Binding var isPresent:Bool
    var id = 0
    @State var inputText = ""
    var completion:((Int,String) -> Void)? = nil
    
    var body: some View {
        
        VStack(spacing:0) {
            
            Text("THÊM GHI CHÚ")
                .font(fonts.b_18)
                .foregroundColor(color.orange_brand_900)
                .padding(.top,20)
            
        
            ZStack(alignment: .topLeading) {
                // Placeholder text
                TextEditor(text: $inputText).onChange(of: inputText, perform: { text in
                    inputText = String(text.prefix(50))
                    valid = text.count > 2
                })
                
                
                if inputText.isEmpty {
                    Text("Ghi chú món ăn")
                        .foregroundColor(.gray)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 8)
                } 
                
            }
            .font(fonts.r_16)
            .padding(.horizontal)
            .frame(height: 100)
            .padding(.vertical,20).padding(.horizontal,8)
            
            
            Text(String(format: "%d/50", inputText.count))
                .font(fonts.m_14)
                .padding(.trailing,20)
                .padding(.bottom,5)
                .frame(maxWidth:.infinity,alignment: .trailing)
            
            
            HStack(spacing:0){
                Button {
                    isPresent = false
                } label: {
                    Text("HUỶ")
                        .font(fonts.b_18)
                        .frame(maxWidth: .infinity,maxHeight:.infinity)
                        .foregroundColor(color.red_600)
                        .background(color.gray_200)
                }.buttonStyle(.plain)
                
                Button {
                    isPresent = false
                    completion?(id, inputText)
                    
                } label: {
                    Text("CẬP NHẬT")
                        .font(fonts.b_18)
                        .frame(maxWidth: .infinity,maxHeight:.infinity)
                    
                }
                .foregroundColor(.white)
                .background( valid ? color.orange_brand_900 : .gray)
                .allowsHitTesting(valid)
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
        NoteView(isPresent:.constant(true))
    }
}



