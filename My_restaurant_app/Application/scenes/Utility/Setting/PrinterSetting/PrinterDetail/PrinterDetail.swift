//
//  PrinterDetail.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 01/01/2025.
//

import SwiftUI

struct PrinterDetail: View {
    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color
    @Environment(\.presentationMode) var router
    @State private var papersize = 50
    @State private var selectedId = "option1"
    
    var printer = Printer()
    @ObservedObject var viewModel = PrinterDetailViewModel()
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    var body: some View {
        VStack(alignment:.leading,spacing:20){

            Picker("Connection Type", selection: $viewModel.printer.connection_type) {
                Text("WIFI").tag(CONNECTION_TYPE.wifi)
                Text("Bluetooth").tag(CONNECTION_TYPE.blueTooth)
            }
            .pickerStyle(.segmented)
            .frame(width:200,alignment: .leading)
        
            VStack(spacing:10){

                HStack {
                    Text("Địa chỉ:")
                        .foregroundColor(color.gray_600)
                        .frame(width:80,alignment: .leading)
                    
                    TextField("IP Address", text: $viewModel.printer.ip_address)
                        .keyboardType(.decimalPad)
                        .commonTextFieldDecor(height: 38)
                }
                
                HStack {
                    Text("Port:")
                        .foregroundColor(color.gray_600)
                        .frame(width:80,alignment: .leading)
                    
                    TextField("Port", text:  Binding(
                        get: { String(viewModel.printer.port) },
                        set: { newValue in
                            viewModel.printer.port = newValue
                        }
                    ))
                    .keyboardType(.numberPad)
                    .commonTextFieldDecor(height: 38)
                    
                }
            }
        
            if viewModel.printer.type == .stamp{
                VStack(alignment:.leading,spacing: 15){
                    
                    Text("Kích thước khổ giấy")
                        .foregroundColor(color.gray_600)
                    
                    RadioButton(id:0, label: "60x40(mm)", isSelected: viewModel.printer.paper_size == 60) {
                        viewModel.printer.paper_size = 60
                    }
                    
                    RadioButton(id:1, label: "50x30(mm)", isSelected: viewModel.printer.paper_size == 50) {
                        viewModel.printer.paper_size = 50
                    }
                    
                    RadioButton(id:2, label: "40x30(mm)", isSelected: viewModel.printer.paper_size == 40) {
                        viewModel.printer.paper_size = 40
                    }
                    
                    RadioButton(id:3, label: "30x20(mm)", isSelected: viewModel.printer.paper_size == 30) {
                        viewModel.printer.paper_size = 30
                    }
                
                }
                
                VStack(alignment:.leading,spacing: 15){
                    
                    Text("Chiều khổ giấy").foregroundColor(color.gray_600)
                    
                    RadioButton(id:0, label: "0(degree)", isSelected: viewModel.printer.direction == 0) {
                        viewModel.printer.direction = 0
                    }
                    
                    RadioButton(id:1, label: "180(degree)", isSelected: viewModel.printer.direction == 1) {
                        viewModel.printer.direction = 1
                    }
                    
                 
                }
            }else if viewModel.printer.type == .chef || viewModel.printer.type == .bar{
                
                VStack(alignment:.leading,spacing: 15){
                    
                    Text("Phương thức in")
                        .foregroundColor(color.gray_600)
                    
                    RadioButton(id:0, label: "In order trên 1 phiếu", isSelected: !viewModel.printer.print_each_paper) {
                        viewModel.printer.print_each_paper = false
                    }
                    
                    RadioButton(id:1, label: "In riêng từng món", isSelected: viewModel.printer.print_each_paper) {
                        viewModel.printer.print_each_paper = true
                    }
                
                }
                
                Stepper( value: $viewModel.printer.number_of_copies, in: 1...5){
                    HStack{
                        Text("Số giấy in")
                        
                        TextField("", value: $viewModel.printer.number_of_copies, formatter: formatter)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .commonTextFieldDecor(height: 35)
                            .frame(width: 35)
                    }
                 
                }.frame(width: 220)
               
            }
                    
            
            Toggle(isOn: $viewModel.printer.active, label: {
                Text("Bật/Tắt máy in:")
            })
            .toggleStyle(SwitchToggleStyle(tint: .orange))
            .frame(width: 180)
               
            Spacer()
            
            HStack(spacing:20){
                Button {
                    self.router.wrappedValue.dismiss()
                } label: {

                    Label(title: {
                        Text("In thử").font(font.b_18)
                    }, icon: {
                        Image("icon-printer", bundle: .main)
                    }).frame(maxWidth: .infinity,maxHeight:.infinity)
                        .foregroundColor(.white)
                        .background(color.green_600)
                    
                }
                .cornerRadius(8)
                .buttonStyle(.plain)
                
                Button {
                    Task{
                        await viewModel.updatePrinter()
                    }
                } label: {
                    Label(title: {
                        Text("cập nhật").font(font.b_18)
                    }, icon: {
                        Image("icon-checkmark",bundle: .main)
                    })
                    .frame(maxWidth: .infinity,maxHeight:.infinity)
                    .foregroundColor(.white)
                    .background(color.orange_brand_900)
                }
                .cornerRadius(8)
                .buttonStyle(.plain)
            }.frame(height: 50)
            
        }
        .font(font.r_15)
        .onAppear(perform: {
            
            dLog(self.printer)
            viewModel.printer = self.printer
        })
        .onChange(of:viewModel.navigateTag) { tag in
            self.router.wrappedValue.dismiss()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
           ToolbarItem(placement: .principal) {
               Text("CẬP NHẬT THÔNG TIN MÁY IN")
                   .fontWeight(.semibold)
                   .foregroundColor(color.orange_brand_900)
           }
        }

    }
}



#Preview {
    PrinterDetail()
}
