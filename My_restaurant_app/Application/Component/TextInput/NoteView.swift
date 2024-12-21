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
   
    var body: some View {
        PopupWrapper(isPresented: $isPresent){
            NoteContent(isPresent: $isPresent,id:id,inputText: inputText)
        }.background(.clear)
    }
}



private struct NoteContent: View {
    @Binding var isPresent:Bool
    var delegate:NotFoodDelegate?
    var id = 0


    @State private var valid:Bool = false
    @State var inputText = ""
    
    var body: some View {
        
        VStack(spacing:0) {
            
            Text("THÊM GHI CHÚ")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(Color(ColorUtils.orange_brand_900()))
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
            .font(.system(size: 16, weight: .regular))
            .padding(.horizontal)
            .frame(height: 100)
            .padding(.vertical,20).padding(.horizontal,8)
            
            
            Text(String(format: "%d/50", inputText.count))
                .font(.system(size: 14, weight: .medium))
                .padding(.trailing,20)
                .padding(.bottom,5)
                .frame(maxWidth:.infinity,alignment: .trailing)
            
            
            HStack(spacing:0){
                Button {
                    isPresent = false
                } label: {
                    Text("HUỶ")
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity,maxHeight:.infinity)
                        .foregroundColor(Color(ColorUtils.red_600()))
                        .background(Color(ColorUtils.gray_200()))
                }.buttonStyle(.plain)
                
                Button {
                    isPresent = false
                    delegate?.callBackNoteFood(id:self.id, note:inputText)
                } label: {
                    Text("CẬP NHẬT")
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity,maxHeight:.infinity)
                    
                }
                .foregroundColor(.white)
                .background( valid ? Color(ColorUtils.orange_brand_900()) : .gray)
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



