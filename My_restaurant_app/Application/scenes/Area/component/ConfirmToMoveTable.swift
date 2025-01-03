//
//  ConfirmToMoveTable.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 03/01/2025.
//

import SwiftUI




struct ConfirmToMoveTable: View {
    @Injected(\.fonts) var font: Fonts
    @Injected(\.colors) var color: ColorPalette
    @State private var valid:Bool = false
    @Binding var isPresent:Bool
    @State var from:Table
    @State var to:Table
    
    var completion:(() -> Void)? = nil
    
    
    var body: some View {
        
        VStack(spacing:0) {
            
            Text("XÁC NHẬN CHUYỂN BÀN")
                .font(font.b_18)
                .foregroundColor(color.orange_brand_900)
                .padding(.top,20)
            
        
            HStack(spacing:20){
                TableView(table:from)
                Image(systemName: "arrowshape.right.fill")
                    .frame(width: 25,height: 25)
                    .foregroundColor(.red)
                TableView(table:to)
            }.padding(.vertical,20)

   
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
                    completion?()
                    
                } label: {	
                    Text("XÁC NHẬN")
                        .font(font.b_18)
                        .frame(maxWidth: .infinity,maxHeight:.infinity)
                    
                }
                .foregroundColor(.white)
                .background(color.orange_brand_900)
                .buttonStyle(.plain)
            }.frame(height: 50)
            
        }
        .background(.white)
        .shadowedStyle()
        .cornerRadius(10)
        .padding(.horizontal, 40)
        .background(BackgroundClearView())
        .onAppear(perform: {
            
        })
        
    }
}

//#Preview {
//    ZStack {
//        ConfirmToMoveTableView(
//            isPresent: .constant(true),
//            from:Table(name: "A"),
//            to:Table(name: "B"))
//    }
//}
