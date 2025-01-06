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
                                        viewModel.presentSheet.show = true
                                        break
                                    
                                    case 5:
                                        viewModel.presentSheet.show = true
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
        .fullScreenCover(isPresented: $viewModel.presentFullScreen,content: {
            BottomSheet{action in
                switch action{
                    case .moveTable,.mergeTable,.splitFood,.orderHistory,.sharePoint:
                        viewModel.presentSheet = (show:true,action:action)
                        break
                    
                    case .cancelOrder:
                        viewModel.cancelOrder(id: viewModel.selectedOrder?.id ?? 0)
                        break
                    
                    default:
                        break
                    
                }
            }.transition(.opacity)
        })
        .sheet(isPresented: $viewModel.presentSheet.show,content: {
            
            if let order = viewModel.selectedOrder,let orderAction = viewModel.presentSheet.action{
                
                
                switch orderAction {
                    case .orderHistory:
                        OrderHistory()
                        .transition(.opacity)
                        
                    case .moveTable:
                        AreaView(
                            title:String(format: "CHUYỂN TỪ BÀN TỪ BÀN %@ SANG",order.table_name),
                            orderAction: orderAction,
                            selectedId:order.table_id,
                            completion: viewModel.getOrders
                        )
                    
                    case .mergeTable:
                        AreaView(
                            title:String(format: "GỘP BÀN %@",order.table_name),
                            orderAction: orderAction,
                            selectedId:order.table_id
                        )
                     
                    case .splitFood:
                        AreaView(
                            title:String(format: "TÁCH MÓN TỪ BÀN %@ SANG",order.table_name),
                            orderAction: orderAction,
                            selectedId:order.table_id
                        )
                    
                    case .cancelOrder:
                        EmptyView()
                    
                    case .sharePoint:
                        SharePoint()
                }
                
                
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
