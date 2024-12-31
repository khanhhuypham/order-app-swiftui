//
//  ReceiptManagementView.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 31/12/2024.
//

import SwiftUI

struct ReceiptManagement: View {
    @Injected(\.fonts) var font: Fonts
    @Injected(\.colors) var color: ColorPalette
    @ObservedObject var viewModel: ReceiptManagementViewModel = ReceiptManagementViewModel()
    @State private var routeLink:(tag:String?,order:Order) = (tag:nil,order:Order())
    
    var body: some View {
        
        VStack {

            Group {
                if viewModel.orderList.isEmpty {
                    EmptyData()
                } else {
                    
                    List {
                        ForEach($viewModel.orderList){order in
                            OrderCardView(order:order).onTapGesture {
                                routeLink = (tag:"Payment",order:order.wrappedValue)
                            }
                            .alignmentGuide(.listRowSeparatorLeading) { d in d[.leading] }
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                            .listRowBackground(color.white)
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle("Quản lý đơn hàng")
                    .refreshable {}
                }
            }
            
            HStack{
                VStack(alignment:.leading,spacing: 5){
                    Text("Doanh thu tạm tính")
                    Text("20,119,867")
                        .font(font.m_16)
                        .foregroundColor(color.orange_brand_900)
                }
                Spacer()
                VStack(alignment:.trailing,spacing: 5){
                    Text("Tổng hoá đơn")
                    Text("20")
                        .font(font.m_16)
                        .foregroundColor(color.orange_brand_900)
                }
            }
            .font(font.m_14)
            .padding(.top,10) // Add padding to prevent overlap. VERY important
            .overlay(alignment: .top) { // The overlay for the border
                Rectangle().frame(height: 1).foregroundColor(.blue)
            }
       

            
            
        }
        .onAppear {
            viewModel.getOrders()
        }
    }
}

