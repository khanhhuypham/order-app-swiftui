//
//  NoteView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 20/09/2024.
//

import SwiftUI

import Combine



struct NoteView: View {

    @Binding var isPresent:Bool
    var id = 0
    @State var inputText = ""
    var completion:((Int,String) -> Void)? = nil
    
    var body: some View {
        PopupWrapper(){
            NoteContent(isPresent: $isPresent,id:id,inputText:inputText,completion:completion)
        }
    }
}



private struct NoteContent: View {
    @Injected(\.fonts) var font: Fonts
    @Injected(\.colors) var color: ColorPalette
    @ObservedObject var viewModel = NoteViewModel()
    @State private var valid:Bool = false
    @Binding var isPresent:Bool
    var id = 0
    @State var inputText = ""
    var completion:((Int,String) -> Void)? = nil
    
    var body: some View {
        
        VStack(spacing:0) {
            
            Text("THÊM GHI CHÚ")
                .font(font.b_18)
                .foregroundColor(color.orange_brand_900)
                .padding(.top,20)
         
            
            VStack{
                
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
                .font(font.r_16)
                .padding(.horizontal)
                .frame(height: 100)
                .padding(.top,20).padding(.horizontal,8)
                
                Text(String(format: "%d/50", inputText.count))
                    .font(font.m_14)
                    .padding(.trailing,20)
                    .frame(maxWidth:.infinity,alignment: .trailing)
                
                TagListLayout(viewModel.noteList, spacing: 4){ note in
                    Text(note.content)
                       .font(font.m_12)
                       .padding(.horizontal, 14)
                       .padding(.vertical, 7)
                       .background(color.orange_brand_900)
                       .foregroundColor(.white)
                       .cornerRadius(5)
                       .onTapGesture(perform: {
                           if let position = viewModel.noteList.firstIndex(where: {$0.id == note.id}){
                               completion?(note.id, note.content)
                               viewModel.noteList.remove(at: position)
                         
                           }
                       })
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
                    completion?(id, inputText)
                    
                } label: {
                    Text("CẬP NHẬT")
                        .font(font.b_18)
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
        .task{
            await PermissionUtils.GPBH_1 ? viewModel.notes() : viewModel.notesByFood(foodId: id)
        }
        
    }
}



#Preview {
    ZStack {
        NoteView(isPresent:.constant(true))
    }
}



