//
//  PrinterSetting.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 16/12/2024.
//

import SwiftUI

struct PrinterList: View {
    @Injected(\.colors) var color: ColorPalette
    @Injected(\.fonts) var font: Fonts
    var foodAppPrinter: Bool
    @ObservedObject var viewModel = PrinterListViewModel()
    @State private var routeLink:(tag:String?,data:Printer) = (tag:nil,data:Printer())
    var body: some View {

        VStack(spacing:0){
            NavigationLink(destination:lazyNavigate(PrinterDetail(printer: routeLink.data)), tag: "PrinterDetail", selection: $routeLink.tag) { EmptyView() }
            List {
                
                Section(header: renderHeader(title: "IN HOÁ ĐƠN")) {
                    ForEach(
                        Array(
                            viewModel.printers
                            .enumerated()
                            .filter{
                                foodAppPrinter
                                ? $0.element.type == .cashier_of_food_app
                                : $0.element.type == .cashier
                            }), id: \.element.id
                    ){ index, printer in
                        renderCell(printer: $viewModel.printers[index]).onTapGesture(perform:{
                            routeLink = (tag:"PrinterDetail",data:printer)
                        })
                    }
                    .defaultListRowStyle()
                }
                
                Section(header: renderHeader(title: "IN NHÃN DÁN")) {
                    ForEach(
                        Array(
                            viewModel.printers
                            .enumerated()
                            .filter{
                                foodAppPrinter
                                ? $0.element.type == .stamp_of_food_app
                                : $0.element.type == .stamp
                            }), id: \.element.id)
                    { index,printer in
                        renderCell(printer: $viewModel.printers[index]).onTapGesture(perform:{
                        
                            routeLink = (tag:"PrinterDetail",data:printer)
                        })
                    }.defaultListRowStyle()
                }
                
                if foodAppPrinter == false {
                    Section(header: renderHeader(title: "IN BẾP/BAR")) {
                        ForEach(Array(viewModel.printers.enumerated().filter{$0.element.type == .chef || $0.element.type == .bar}), id: \.element.id) { index, printer in
                            renderCell(printer: $viewModel.printers[index]).onTapGesture(perform:{
                                
                                routeLink = (tag:"PrinterDetail",data:printer)
                            })	// Pass the binding of the specific printer
                        }
                        .defaultListRowStyle()
                    }
                }
            }
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
               ToolbarItem(placement: .principal) {
                   Text("THIẾT LẬP MÁY IN")
                       .fontWeight(.semibold)
                       .foregroundColor(color.orange_brand_900)
               }
            }
            .onAppear(perform: {
                viewModel.foodAppPrinter = self.foodAppPrinter
            })
            .task{
                await viewModel.getPrinters()
            }
            
        }
   
    }
    
    private func renderHeader(title:String) -> (some View){
        HStack(alignment:.center,spacing: 5){
            Image("icon-printer.fill", bundle: .main)
            
            Text(title).font(font.b_16)
                
            Spacer()
        }.foregroundColor(color.orange_brand_900)
    }
    
    private func renderCell(printer:Binding<Printer>) -> (some View){
        HStack(alignment:.center,spacing: 5){
            
            VStack(alignment:.leading){
                
                Text(printer.wrappedValue.name)
                    .font(font.m_14)
                
                Text(
                    (printer.wrappedValue.connection_type == .wifi || printer.wrappedValue.connection_type == .blueTooth)
                    ? String(format: "%@:%@",printer.wrappedValue.ip_address ,printer.wrappedValue.port.description)
                    : printer.wrappedValue.connection_type.description
                )
                .font(font.r_12)
                .foregroundColor(color.gray_600)
            }
            Spacer()
            HStack(alignment:.center,spacing: 5){
                
                Text(printer.wrappedValue.active ? "ĐANG HOẠT ĐỘNG" : "NGỪNG HOẠT ĐỘNG")
                    .font(font.m_12)
                    .foregroundColor(printer.wrappedValue.active ? color.blue_brand_700 : color.gray_600)
                
                Image("icon-gear", bundle: .main)
                    .foregroundColor(color.gray_600)
                
            }
           
        }
        .padding(10)
        .padding(.leading,10)
        .background(.white)
   
    }
}

#Preview {
    PrinterList(foodAppPrinter: false)
}
