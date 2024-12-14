//
//  NoteManagementView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 22/10/2024.
//

import SwiftUI

struct NoteManagement: View {
    
    @Injected(\.colors) var color: ColorPalette
    @Injected(\.fonts) var font: Fonts
    @ObservedObject var viewModel = NoteManagementViewModel()
    
    var body: some View {
        VStack(spacing:0){
            // Tabs
            List {
                ForEach(Array($viewModel.NoteList.enumerated()),id:\.1.id) {index, item in
                    renderCell(note: item).onTapGesture(perform: {
                        viewModel.showPopup(note:item.wrappedValue)
                    })
                    
                }.defaultListRowStyle()
            }
            .listStyle(.plain)
            .onAppear(perform: {
                viewModel.getNotes()
            })
            
            Divider()
            
            Button(action: {
                viewModel.showPopup(note:Note())
            }) {
                Text("+ THÊM GHI CHÚ")
                    .font(font.sb_16)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height:35)
                    .background(color.orange_brand_900)
                    .cornerRadius(8)
            }.padding()
           
        }
        .fullScreenCover(isPresented: $viewModel.isPresent, content: {
            
            if let popup = viewModel.popup{
                dialog(isPresented: $viewModel.isPresent){
                    AnyView(popup)
                }
            }
            
        })
    }
    
    
    private func renderCell(note:Binding<Note>) -> (some View){
        HStack(alignment:.center,spacing: 5){
            
            Image("icon-doc-text", bundle: .main)
                .foregroundColor(color.gray_600)
            
            Text(note.wrappedValue.content)
                .font(font.r_14)
            Spacer()
        }
        .swipeActions(edge: .trailing){
            
            Button {
                if var first = viewModel.NoteList.first{$0.id == note.wrappedValue.id}{
                    first.delete = ACTIVE
                    viewModel.createNote(note: first)
                }
            } label: {
                Image(systemName: "trash.fill")
            }
            .tint(color.red_600)
            
            Button {
                viewModel.showPopup(note:note.wrappedValue)
            } label: {
                Image("icon-edit", bundle: .main)
            }
            .tint(color.gray_600)
        }
        .fullBox()
        .padding(8)
        .overlay(
            Rectangle()
                .frame(width: 4) // The height of the underline
                .foregroundColor(Color(ColorUtils.gray_600()))
                .cornerRadius(4, corners: [.bottomLeft,.topLeft])
            , // Color of the underline
            alignment: .trailing // Align it to the bottom of the text
        )
        .background(.white)
   
    }
}

#Preview {
    NoteManagement()
}
