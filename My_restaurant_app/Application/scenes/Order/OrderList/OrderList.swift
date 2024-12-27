//
//  OrderView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 03/09/2024.
//

import SwiftUI

import AlertToast
struct OrderListView<Model>: View where Model: OrderListViewModel{
    @Injected(\.fonts) var fonts: Fonts
    @Injected(\.colors) var color: ColorPalette
  
    @ObservedObject var viewModel: OrderListViewModel
//    @State private var selection: String? = nil
    @State private var routeLink:(tag:String?,order:Order) = (tag:nil,order:Order())
    
    var body: some View {
        
        VStack {
            
            NavigationLink(destination: OrderDetailView(order:routeLink.order), tag: "OrderDetail", selection: $routeLink.tag) { EmptyView() }
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(color.orange_brand_900)
                    .padding(.leading,10)

                TextField("Tìm kiếm", text: $viewModel.APIParameter.key_word)
                    .padding(.trailing,20)
                    
            }
            .frame(height: 34)
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(color.orange_brand_900, lineWidth: 2))
            .padding(.horizontal,15)
            

            Group {
                if viewModel.orderList.isEmpty {
                    EmptyData()
                } else {
                    
                    List {
                        ForEach($viewModel.orderList){order in
                            OrderCardView(order:order).onTapGesture {
                                routeLink = (tag:"OrderDetail",order:order.wrappedValue)
                            }
                            .alignmentGuide(.listRowSeparatorLeading) { d in d[.leading] }
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                            .listRowBackground(color.white)
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle("Đơn hàng")
                    .refreshable {}

                }
            }
        }
        .onAppear {
            viewModel.getOrders()
        }
    }
}



#Preview {
    OrderListView(viewModel: OrderListViewModel())
}
