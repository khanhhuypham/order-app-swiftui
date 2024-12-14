//
//  CategoryManagement.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 22/10/2024.
//

import SwiftUI

struct CategoryManagement: View {
    
    @Injected(\.colors) var color: ColorPalette
    @Injected(\.fonts) var font: Fonts
    @ObservedObject var viewModel = CategoryManagementViewModel()
    
    var body: some View {
        
        
        VStack(spacing:0){
            // Tabs
            List {
                ForEach(Array($viewModel.categories.enumerated()),id:\.1.id) {index, item in
                   
                    renderCell(category: item).onTapGesture(perform: {
                        viewModel.showPopup(category: item.wrappedValue)
                    })
                }.defaultListRowStyle()
            }
            .listStyle(.plain)
            .onAppear(perform: {
                viewModel.getCategories()
            })
            Divider()
            
            Button(action: {
                viewModel.showPopup(category: Category())
            }) {
                Text("+ THÊM DANH MỤC")
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
    
    private func renderCell(category:Binding<Category>) -> (some View){
        HStack(alignment:.center,spacing: 5){
            
            Image("icon-fire", bundle: .main)

            VStack(alignment:.leading){
                Text(category.wrappedValue.name)
                    .font(font.r_16)
                Text(category.wrappedValue.status == ACTIVE ? "ĐANG KINH DOANH" : "NGỪNG KINH DOANH")
                    .font(font.m_12)
                    .foregroundColor(category.wrappedValue.status == ACTIVE ? color.green_600 : color.red_600)
            }
            Spacer()
            Image(systemName: "chevron.right")
            
        }
        .padding(8)
        .background(.white)
   
    }
    
   
}

#Preview {
    CategoryManagement()
}
