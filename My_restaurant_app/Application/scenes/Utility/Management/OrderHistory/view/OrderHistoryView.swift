//
//  AreaManageView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 11/10/2024.
//

import SwiftUI

struct OrderHistoryView: View {
    @Injected(\.colors) var color: ColorPalette
    @Injected(\.fonts) var font: Fonts
    
    @StateObject var viewModel = OrderHistoryViewModel()
    @State private var selectedOrder: OrderDetail?
    var body: some View {
        Group {
            Divider()
            
            filterBar
           
            Divider()
            
            orderHistoryList
            
            Divider()
            
            BottomBar
        
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
           ToolbarItem(placement: .principal) {
               Text("QUÁN LÝ HOÁ ĐƠN")
                   .fontWeight(.semibold)
                   .foregroundColor(color.orange_brand_900)
           }
        }
        .onAppear{
            viewModel.getInvoiceList()
            viewModel.getTotalAmountOfOrders()
        }

    }
    
    private var filterBar:some View{
        BtnGroupOfReportType(
            useTextField:true,
            textFieldClosure: {str in
                var p = viewModel.APIParameter
                p.key_search = str
                viewModel.APIParameter = p
                viewModel.getInvoiceList()
                viewModel.getTotalAmountOfOrders()
            },
            clickClosure: {id in
                var p = viewModel.APIParameter
                p.from_date = REPORT_TYPE(rawValue: id)?.from_date ?? ""
                p.to_date = REPORT_TYPE(rawValue: id)?.to_date ?? ""
                viewModel.APIParameter = p
                viewModel.getInvoiceList()
                viewModel.getTotalAmountOfOrders()
            }
        ).padding(.horizontal,5)
    }
    
    @ViewBuilder
    private var orderHistoryList:some View{
        
        if viewModel.invoiceList.isEmpty {
            
           EmptyData {
               viewModel.getInvoiceList()
               viewModel.getTotalAmountOfOrders()
           }
            
        } else{
            
            List {
                ForEach($viewModel.invoiceList) { invoice in
                    OrderHistoryCell(order: invoice)
                        .onTapGesture {
                            selectedOrder = OrderDetail(order: invoice.wrappedValue)
                        }
                        .alignmentGuide(.listRowSeparatorLeading) { d in d[.leading] }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                        .listRowBackground(color.white)
                }
            }
            .background(
                NavigationLink(destination: PaymentView(order: selectedOrder ?? OrderDetail(order: .init())), isActive: Binding(
                    get: { selectedOrder != nil },
                    set: { if !$0 { selectedOrder = nil } }
                )) {
                    EmptyView()
                }
            )
            .listStyle(.plain)
            .refreshable {
                viewModel.getInvoiceList()
                viewModel.getTotalAmountOfOrders()
            }
        }
    }
    
    private var BottomBar: some View {
        HStack{
            VStack(alignment: .leading){
                Text("Doanh thu tạm tính").font(font.sb_14)
                Text(viewModel.orderStatstic.total_amount.toString).foregroundColor(color.orange_brand_900).font(font.sb_16)
            }
            Spacer()
            
            VStack(alignment: .trailing){
                Text("Tổng hoá đơn").font(font.sb_14)
                Text(viewModel.totalOrder.toString).foregroundColor(color.orange_brand_900).font(font.sb_16)
            }
        }.padding(.horizontal)
    }
    


}

#Preview {
    OrderHistoryView()
}
