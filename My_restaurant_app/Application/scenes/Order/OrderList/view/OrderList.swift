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
            navigationLinks
            headerFilterBar
            Divider()
            contentView
        }
        .fullScreenCover(isPresented: $viewModel.presentFullScreen) {
            fullScreenSheet
        }
        .sheet(isPresented: $viewModel.presentSheet.show) {
            sheetContent
        }
        .onAppear {
            viewModel.setupSocketIO()
            Task {
                await viewModel.clearDataAndCallAPI()
            }
        }
        .onDisappear {
            viewModel.socketIOLeaveRoom()
        }
    }
    
    private var navigationLinks: some View {
        Group {
            NavigationLink(destination: OrderDetailView(order: viewModel.selectedOrder),
                           tag: "OrderDetail", selection: $linkTag) { EmptyView() }

            NavigationLink(destination: FoodView(order: OrderDetail(order: viewModel.selectedOrder ?? Order()), is_gift: ACTIVE),
                           tag: "FoodView", selection: $linkTag) { EmptyView() }

            NavigationLink(destination: PaymentView(order: OrderDetail(order: viewModel.selectedOrder ?? Order())),
                           tag: "Payment", selection: $linkTag) { EmptyView() }
        }
    }
    
    private var headerFilterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                searchField
                orderTypeMenu
                orderStatusButtons
            }
            .padding(.horizontal)
        }
        .frame(height: 50)
    }
    
    
    private var searchField: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(color.orange_brand_900)
                .padding(.leading, 10)

            TextField("Tìm kiếm", text: $viewModel.APIParameter.key_word)
                .padding(.trailing, 20)
        }
        .frame(height: 32)
        .frame(minWidth: 200)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(color.orange_brand_900, lineWidth: 2)
        )
    }

    
    private var orderTypeMenu: some View {
        Menu {
            Section("Loại đơn") {
                ForEach(OrderTypeGroup.allCases, id: \.self) { group in
                    Button {
                        viewModel.APIParameter.order_methods = group.methods
                        Task { await viewModel.clearDataAndCallAPI() }
                    } label: {
                        Label(group.title,
                              systemImage: viewModel.APIParameter.order_methods.contains(where: { group.methods.contains($0) })
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
    }

    private var orderStatusButtons: some View {
        HStack(spacing: 8) {
            ForEach(status.indices, id: \.self) { index in
                let isSelected = status[index].isSelect
                Button {
                    for j in status.indices {
                        status[j].isSelect = (j == index)
                    }
                } label: {
                    Text(status[index].label)
                        .font(font.sb_14)
                        .foregroundColor(isSelected ? .white : color.orange_brand_900)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        .background(isSelected ? color.orange_brand_900 : .white)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(color.orange_brand_900, lineWidth: 2)
                        )
                }
            }
        }
    }
    
    private var contentView: some View {
        Group {
            if viewModel.orderList.isEmpty {
                EmptyData {
                    Task { await viewModel.clearDataAndCallAPI() }
                }
            } else {
                List {
                    ForEach($viewModel.orderList) { order in
                        OrderCardView(order: order) { tag in
                            handleOrderCardAction(tag: tag ?? 0, order: order.wrappedValue)
                        }
                        .onAppear{
                            Task {
                                if let lastItem = viewModel.orderList.last, lastItem.id == order.id {
                                    await viewModel.loadMoreContent()
                                }
                            }
                        }
                        .onTapGesture { handleOrderTap(order: order.wrappedValue) }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                        .listRowBackground(color.white)
                    }
                }
                .refreshable {
                    Task{
                        await viewModel.clearDataAndCallAPI()
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Đơn hàng")
            }
        }
    }


    
    private var fullScreenSheet: some View {
        BottomSheet(order: viewModel.selectedOrder ?? Order()) { action in
            switch action {
                case .moveTable, .mergeTable, .splitFood, .orderHistory, .sharePoint:
                    viewModel.presentSheet = (show: true, action: action)
                case .cancelOrder:
                    Task { await viewModel.closeTable(id: viewModel.selectedOrder?.id ?? 0) }
            default:
                break
            }
        }
        .transition(.opacity)
    }


    @ViewBuilder
    private var sheetContent: some View {
        if let order = viewModel.selectedOrder,
           let action = viewModel.presentSheet.action {
            switch action {
            case .orderHistory:
                OrderLogView(orderId: order.id)

            case .moveTable:
                AreaView(
                    title: "CHUYỂN TỪ BÀN \(order.table_name) SANG",
                    order: order,
                    orderAction: .moveTable
                ) {
                    Task { await viewModel.clearDataAndCallAPI() }
                }

            case .mergeTable:
                AreaView(
                    title: "GỘP BÀN \(order.table_name)",
                    order: order,
                    orderAction: .mergeTable
                ) {
                    Task { await viewModel.clearDataAndCallAPI() }
                }

            case .splitFood:
                AreaView(
                    title: "TÁCH MÓN TỪ BÀN \(order.table_name) SANG",
                    order: order,
                    orderAction: .splitFood,
                    splitFoodCompletion: { (from, to) in
                        viewModel.splitFood = (from, to)
                        viewModel.presentSheet.action = .chooseFoodToSplit
                    }
                )

            case .chooseFoodToSplit:
                if let splitFood = viewModel.splitFood {
                    MoveOrderItems(
                        order: order,
                        from: splitFood.from,
                        to: splitFood.to
                    ) {
                        viewModel.splitFood = nil
                    }
                }

            default:
                EmptyView()
            }
        }
    }


    
    private func handleOrderCardAction(tag: Int, order: Order) {
        viewModel.selectedOrder = order
        switch tag {
            case 1:
                viewModel.presentFullScreen = true
            
            case 2:
                linkTag = "FoodView"
            
            case 3:
                linkTag = "Payment"
            
            case 4, 5:
                viewModel.presentSheet.show = true
            
            default:
                break
        }
    }

    private func handleOrderTap(order: Order) {
        if order.order_status != .waiting_complete {
            viewModel.selectedOrder = order
            linkTag = "OrderDetail"
        } else {
            toast.alertSubject.send(
                AlertToast(
                    type: .regular,
                    title: "Warning",
                    subTitle: "Đơn hàng đang chờ thu tiền bạn \n không được phép thao tác."
                )
            )
        }
    }

    

}





#Preview {
    OrderListView(viewModel: OrderListViewModel())
}
