//
//  OrderView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 03/09/2024.
//

import SwiftUI
import AlertToast


struct OrderListView<Model>: View where Model: OrderListViewModel{
    @Injected(\.fonts) var font: Fonts
    @Injected(\.colors) var color: ColorPalette
    @Injected(\.utils.toastUtils) var toast
    
    @ObservedObject var viewModel: OrderListViewModel
    @State private var linkTag:String? = nil
    @State var status: [(value: Int, label: String, isSelect: Bool)] = [
        (value: -1, label: "Tất cả", isSelect: false),
        (value: 0, label: "Của tôi", isSelect: false),
        (value: 1, label: "Đang phục vụ", isSelect: false),
        (value: 2, label: "Yêu cầu thanh toán", isSelect: false),
        (value: 3, label: "Chờ thanh toán", isSelect: false)
    ]
    var body: some View {
        
        VStack {
         
            NavigationLink(destination: OrderDetailView(order:viewModel.selectedOrder), tag: "OrderDetail", selection: $linkTag) { EmptyView() }
            
            NavigationLink(destination: FoodView(order:OrderDetail(order:viewModel.selectedOrder ?? Order()),is_gift: ACTIVE), tag: "FoodView", selection: $linkTag) { EmptyView() }
            
            NavigationLink(destination: PaymentView(order:OrderDetail(order:viewModel.selectedOrder ?? Order())), tag: "Payment", selection: $linkTag) { EmptyView() }
            
     
                        
            ScrollView(.horizontal,showsIndicators: false,content: {
                HStack(spacing:8){
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(color.orange_brand_900)
                            .padding(.leading,10)

                        TextField("Tìm kiếm", text: $viewModel.APIParameter.key_word)
                            .padding(.trailing,20)
                            
                    }
                    .frame(height: 32)
                    .frame(minWidth: 200)
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(color.orange_brand_900, lineWidth: 2))
                  
                    HStack(alignment:.center,spacing:8){
                        
                        Menu {
                            Section("Loại đơn") {
                                ForEach(OrderTypeGroup.allCases, id: \.self) { group in
                                    Button {
                                        viewModel.APIParameter.order_methods = group.methods
                                        viewModel.orderList.removeAll()
                                        Task{
                                            await viewModel.getOrders()
                                        }
                                    } label: {
                                        Label(group.title,
                                              systemImage: viewModel.APIParameter.order_methods.contains(where: {group.methods.contains($0) })
                                              ? "checkmark" : "")
                                    }
                                }
                            }
                        } label: {
                            HStack(spacing: 8) {
                                Text(viewModel.APIParameter.order_methods.contains(where: { OrderTypeGroup.dineIn.methods.contains($0) })
                                     ? "Tại bàn" : "App Food")
                                Image(systemName: "chevron.up.chevron.down")
                            }
                            .font(font.sb_14)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 20)
                            .frame(height: 32)
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(color.orange_brand_900, lineWidth: 2))
                            .foregroundColor(color.orange_brand_900)
                            .cornerRadius(16)
                        }

                
                        ForEach(status.indices, id: \.self) { index in
                            let i = Int(index.description) ?? 0
                            
                            Button(action: {
                                // Select only this index, deselect others
                                for j in status.indices {
                                    status[j].isSelect = (j == index)
                                }
                            }) {
                                Text(status[i].label)
                                    .font(font.sb_14)
                                    .foregroundColor(status[i].isSelect ? .white : color.orange_brand_900)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 20)
                            }
                            .frame(height: 32)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(color.orange_brand_900, lineWidth: 2)
                            )
                            .background(status[i].isSelect ? color.orange_brand_900 : .white)
                            .cornerRadius(16)
                        }
                    }
                }
            })
            .frame(height: 50)
            .padding(.horizontal)
            
            Divider()

            Group {
                if viewModel.orderList.isEmpty {
                    EmptyData{
                        viewModel.orderList.removeAll()
                        Task{
                            await viewModel.getOrders()
                        }
                    }
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
                                
                                if(order.wrappedValue.order_status != .waiting_complete){
                                    viewModel.selectedOrder = order.wrappedValue
                                    linkTag = "OrderDetail"
                                }else{
                                    toast.alertSubject.send(
                                        AlertToast(type: .regular, title: "Warning", subTitle: "Đơn hàng đang chờ thu tiền bạn \n không được phép thao tác.")
                                    )
                                }
                               
                            }
                            .alignmentGuide(.listRowSeparatorLeading) { d in d[.leading] }
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                            .listRowBackground(color.white)
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle("Đơn hàng")
                    .refreshable {
                        
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $viewModel.presentFullScreen,content: {
            BottomSheet(order:viewModel.selectedOrder ?? Order()){action in
                switch action{
                    case .moveTable,.mergeTable,.splitFood,.orderHistory,.sharePoint:
                        viewModel.presentSheet = (show:true,action:action)
                        break
                    
                    case .cancelOrder:
                        Task{
                            await viewModel.closeTable(id: viewModel.selectedOrder?.id ?? 0)
                        }
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
                        OrderLog(orderId: order.id)
                    
    
                    case .moveTable:
                        AreaView(
                            title:String(format: "CHUYỂN TỪ BÀN TỪ BÀN %@ SANG",order.table_name),
                            order: order,
                            orderAction: orderAction,
                            completion: {
                                Task{
                                    await viewModel.getOrders()
                                }
                            }
                        )
                    
                    case .mergeTable:
                        AreaView(
                            title:String(format: "GỘP BÀN %@",order.table_name),
                            order: order,
                            orderAction: orderAction,
                            completion: {
                                Task{
                                    await viewModel.getOrders()
                                }
                            }
                        )
                     
                    case .splitFood:
                        AreaView(
                            title:String(format: "TÁCH MÓN TỪ BÀN %@ SANG",order.table_name),
                            order: order,
                            orderAction: orderAction
                        )
                    
                    case .cancelOrder:
                        EmptyView()
                    
                    case .sharePoint:
//                        SharePoint()
                        EmptyView()
                }
                
                
            }
        })
        .onAppear {
            Task{
                viewModel.orderList.removeAll()
                await viewModel.getOrders()
                viewModel.setupSocketIO()
            }
        }
        .onDisappear{
            viewModel.socketIOLeaveRoom()
        }
        
        
    }
    

}





#Preview {
    OrderListView(viewModel: OrderListViewModel())
}
