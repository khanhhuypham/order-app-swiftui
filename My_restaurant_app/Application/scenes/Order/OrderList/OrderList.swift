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
    @State private var linkTag:String? = nil
    
    var body: some View {
        
        VStack {
            
            NavigationLink(destination:lazyNavigate(OrderDetailView(order:viewModel.selectedOrder)), tag: "OrderDetail", selection: $linkTag) { EmptyView() }
            NavigationLink(destination:lazyNavigate(FoodView(order:OrderDetail(order:viewModel.selectedOrder ?? Order()))), tag: "FoodView", selection: $linkTag) { EmptyView() }
            NavigationLink(destination:lazyNavigate(Text("Thanh toán")), tag: "Payment", selection: $linkTag) { EmptyView() }
            
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
                            OrderCardView(order:order){tag in
                                viewModel.selectedOrder = order.wrappedValue
                                switch tag{
                                    case 1:
                                        viewModel.presentFullScreen = true
                                    
                                    case 2:
                                        linkTag = "FoodView"
                                        break
                                    
                                    case 3:
                                        linkTag = "Payment"
                                        break
                                    
                                    case 4:
                                        viewModel.presentSheet = true
                                        break
                                    
                                    case 5:
                                        viewModel.presentSheet = true
                                        break
                                    
                                    default:
                                        break
                                    
                                }
                            }
                            .onTapGesture {
                                viewModel.selectedOrder = order.wrappedValue
                                linkTag = "OrderDetail"
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
        .fullScreenCover(isPresented: $viewModel.presentFullScreen,onDismiss: {
            viewModel.presentSheet = true
        },content: {
            BottomSheet(isShowing: $viewModel.presentFullScreen){action in
                viewModel.presentFullScreen = false
                switch action{
                    case .orderHistory:
                        break
            
                    case .moveTable,.mergeTable,.splitFood:
                        
                        break
                    
                   
                    case .sharePoint:
                       
                        break
                    
                    case .cancelOrder:
//                        closeTable(order: order)
                        break
                    
                    default:
                        break
                    
                }
            }
        })
        .sheet(isPresented: $viewModel.presentSheet, content: {
            if let order = viewModel.selectedOrder{
                AreaView(title:String(format: "TÁCH MÓN TỪ BÀN %@",order.table_name))
            }
        })
        .onAppear {
            viewModel.getOrders()
        }

    }
}



#Preview {
    OrderListView(viewModel: OrderListViewModel())
}
