//
//  PrinterSetting.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 16/12/2024.
//

import SwiftUI

struct PrinterSetting: View {
    @Injected(\.colors) var color: ColorPalette
    @Injected(\.fonts) var font: Fonts
    @ObservedObject var viewModel = PrinterSettingViewModel()
    
    var body: some View {
        
        
        VStack(spacing:0){
            // Tabs
            List {
                
                Section(header: renderHeader(title: "PRINT RECEIPT")) {
                    ForEach(Array(viewModel.printers.enumerated().filter{$0.element.type == .cashier}), id: \.element.id) { index, printer in
                        renderCell(printer: $viewModel.printers[index]) // Pass the binding
                    }
                    .defaultListRowStyle()
                }
                
                Section(header: renderHeader(title: "PRINT STAMP")) {
                    ForEach(Array(viewModel.printers.enumerated().filter{$0.element.type == .stamp}), id: \.element.id) { index, _ in
                        renderCell(printer: $viewModel.printers[index]) // Pass the binding of the specific printer
                    }
                    .defaultListRowStyle()
                }

                Section(header: renderHeader(title: "PRINT CHEF/BAR")) {
                    ForEach(Array(viewModel.printers.enumerated().filter{$0.element.type == .chef || $0.element.type == .bar}), id: \.element.id) { index, _ in
                        renderCell(printer: $viewModel.printers[index]) // Pass the binding of the specific printer
                    }
                    .defaultListRowStyle()
                }
               
            }
            .listStyle(.plain)
            .onAppear(perform: {
                viewModel.getPrinters()
            })
            
        }
   
    }
    
    private func renderHeader(title:String) -> (some View){
        HStack(alignment:.center,spacing: 5){
            
            Image("icon-printer-orange", bundle: .main)
            
            Text(title)
                .font(font.b_16)
                .foregroundColor(color.orange_brand_900)
            Spacer()
           
        }
  
   
    }
    
    private func renderCell(printer:Binding<Printer>) -> (some View){
        HStack(alignment:.center,spacing: 5){
            
            VStack(alignment:.leading){
                
                Text(printer.wrappedValue.name)
                    .font(font.m_14)
                
                Text(String(format: "%@:%@",printer.wrappedValue.ip_address ,printer.wrappedValue.port.description))
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
        .padding(8)
        .background(.white)
   
    }
}

#Preview {
    PrinterSetting()
}
