//
//  OrderLog.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 13/10/25.
//

import SwiftUI



struct OrderLog: View {
    var orderId:Int
    @Injected(\.fonts) var font: Fonts
    @Injected(\.colors) var color: ColorPalette
    @StateObject var viewModel = OrderLogViewModel()
     

    var body: some View {
        
        VStack {
            Text("Lịch sử đơn hàng")
                .foregroundColor(color.orange_brand_900)
                .font(font.sb_18)
                .padding(.vertical,10)
            
            Divider()
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(color.orange_brand_900)
                    .padding(.leading,10)

                TextField("Tìm kiếm", text: $viewModel.searchKey)
                    .padding(.trailing,20)
                    
            }
            .frame(height: 32)
            .frame(maxWidth: .infinity)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(color.orange_brand_900, lineWidth: 2))
            .padding(8)
            
            Rectangle().foregroundStyle(color.gray_200).frame(height:8)
            
            Spacer()
            
    
            List{
                ForEach(viewModel.dataArray, id: \.id){data in
                    VStack(alignment: .leading, spacing: 5){
                        Text(data.created_at)
                            .font(font.sb_14)
                            .foregroundColor(color.blue_brand_700)
                        
                        Text(String(format:"• %@ • %@",data.full_name, data.user_name))
                            .font(font.r_14)
                            .foregroundColor(color.gray_600)
                        
                        Text(data.content)
                            .font(font.r_14)
                            .foregroundColor(.black)
                        
                    }
                }
            }
            .listStyle(.plain)
        
        }
        .navigationTitle("Lịch sử đơn hàng")
        .onAppear {
            viewModel.getOrderLog(orderId: orderId)
        }
    
        
        
    }
    

}





