//
//  MenuManagement.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 12/10/2024.
//

import SwiftUI

struct MenuManagement: View {
    @Injected(\.colors) var color: ColorPalette
    @Injected(\.fonts) var font: Fonts
    @ObservedObject var viewModel = MenuManagementViewModel()
    var body: some View {
        VStack(spacing:0){
            // Tabs
            Divider()
            TabHeader(tabArray: $viewModel.tabArray){id in
                dLog(id)
                viewModel.tab = id
            }.frame(height: 50)
            
            if viewModel.tab != 2 {
                Rectangle()
                    .foregroundColor(color.gray_200)
                    .frame(height: 10)
            }
            
            switch viewModel.tab{
                case 1:
                    CategoryManagement()
                
                case 2:
                    FoodManagement()
                
                default:
                    NoteManagement()
            }
            
            Spacer()
    
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
           ToolbarItem(placement: .principal) {
               Text("QUẢN LÝ THỰC ĐƠN")
                   .font(font.b_16)
                   .foregroundColor(color.orange_brand_900)
           }
        }
        .onAppear(perform: {
            
        })
            
    }
    
  
    
    
    
    
}

#Preview {
    MenuManagement()
}
