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
                ForEach(Array($viewModel.printers.enumerated()),id:\.1.id) {index, printer in
                   
                    renderCell(printer: printer).onTapGesture(perform: {
//                        viewModel.showPopup(category: item.wrappedValue)
                    })
                    
                }.defaultListRowStyle()
            }
            .listStyle(.plain)
            .onAppear(perform: {
//                viewModel.getCategories()
            })
            
           
        }
   
        
    }
    
    private func renderCell(printer:Binding<Printer>) -> (some View){
        HStack(alignment:.center,spacing: 5){
            
            Image("icon-fire", bundle: .main)

            VStack(alignment:.leading){
                Text(printer.wrappedValue.name)
                    .font(font.r_16)
                Text(printer.wrappedValue.active ? "ĐANG KINH DOANH" : "NGỪNG KINH DOANH")
                    .font(font.m_12)
                    .foregroundColor(printer.wrappedValue.active ? color.green_600 : color.red_600)
            }
            Spacer()
            Image(systemName: "chevron.right")
            
        }
        .padding(8)
        .background(.white)
   
    }
}

#Preview {
    PrinterSetting()
}
