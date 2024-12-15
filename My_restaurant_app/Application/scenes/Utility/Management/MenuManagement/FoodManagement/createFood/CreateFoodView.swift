//
//  CreateFood.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 30/11/2024.
//

import SwiftUI

struct CreateFoodView: View {
    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color
    var item:Food = Food()
    
    @ObservedObject var viewModel = CreateFoodViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var isSeasonalPrice: Bool = false
    @State private var isPrintEnabled = true
    @State private var isPrintStamp = false
    @State private var isApplyVAT = false
    @State private var selectedPrinter = ""
    

    var body: some View {
        VStack{
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    
                    // Image picker placeholder
                    Button(action: {
                        // Action for selecting image
                    }) {
                        VStack {
                            Image(systemName: "photo")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)
                            Image(systemName: "camera.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.blue)
                        }
                        .frame(width: 100, height: 100)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }
                    
                    // Dish name input field
                    TextField("Name", text: $viewModel.food.name)
                        .font(font.r_13)
                        .commonTextFieldDecor(height: 38)
                

                    
                    TextField("Nhập số tiền", value: $viewModel.food.price,format:.number)
                        .keyboardType(.decimalPad)
                        .font(font.r_13)
                        .commonTextFieldDecor(height: 38)
                  
                
                    
                    HStack(spacing:20) {
                        Text("Category:")
                            .font(font.r_14)
                            .foregroundColor(color.gray_600)
                        
                        Menu {
                            ForEach(viewModel.categories, id: \.id) { category in
                                Button(action: {
                                    for (i,cate) in viewModel.categories.enumerated(){
                                        if cate.id == category.id{
                                            viewModel.categories[i].isSelect = true
                                            viewModel.food.category_id = cate.id
                                        }else{
                                            viewModel.categories[i].isSelect = false
                                        }
                                    }
                                }) {
                                    Label(category.name, systemImage: category.isSelect ? "checkmark" : "")
                                }
                            }
                            .frame(maxHeight: 100)
                            
                        } label: {
                            HStack {
                                Text(viewModel.categories.first(where:{$0.isSelect})?.name ?? "").font(font.r_14).foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.down").foregroundColor(.gray)
                            }.commonTextFieldDecor(height: 40)
                        }.menuIndicator(.hidden)
                    }

                    
                    HStack(spacing:20) {
                        Text("Unit type:")
                            .font(font.r_14)
                            .foregroundColor(color.gray_600)
                        
                        Menu {
                            ForEach(viewModel.units, id: \.id) { unit in
                                Button(action: {

                                    for (i,element) in viewModel.units.enumerated(){
                                        if element.id == unit.id{
                                            viewModel.units[i].isSelect = true
                                            viewModel.food.unit_id = unit.id
                                        }else{
                                            viewModel.units[i].isSelect = false
                                        }
                   
                                    }
                                }) {
                          
                                    Label(unit.name, systemImage: unit.isSelect ? "checkmark" : "")
                                }
                            }
                        } label: {
                            HStack {
                                Text(viewModel.units.first(where:{$0.isSelect})?.name ?? "").font(font.r_14).foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.down").foregroundColor(.gray)
                            }
                            .commonTextFieldDecor(height: 40)
                        }
                    }
                    
                    
                    let _ = { // look here. "let _ =" is required
                        print(viewModel.food.children.map{$0.id})
                        print(viewModel.childrenItem.map{(item) in (id: item.id,name: item.name)})
                    }() // look here. "()" is also required
                        
                    
                    EmbeddedDropDown(
                        selectedIds: Binding(
                            get: {
                                // Map the `id`s from the `children` array
                                viewModel.food.children.map { $0.id }
                            },
                            set: { _ in}
                        ),
                        optionArray: viewModel.childrenItem.map{(item) in (id: item.id,name: item.name)},
                        onSelect: { name, id in  // Handle item selection
                            print("Selected: \(name) with ID \(id)")
                            
                            if let child = viewModel.childrenItem.first(where: {$0.id == id}){
                                if !viewModel.food.children.map{$0.id}.contains(child.id){
                                    viewModel.food.children.append(child)
                                }
                            }
                            
                        },
                        onDelete: { name, id in  // Handle item deletion (if necessary)
                            if let child = viewModel.childrenItem.first(where: {$0.id == id}){
                                if viewModel.food.children.map{$0.id}.contains(child.id){
                                    viewModel.food.children.removeAll(where: {$0.id == id})
                                }
                            }
                        }
                    )
                    
                    
                    .padding(EdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 6))
                    .overlay(
                      // Placeholder and border overlay
                      RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(uiColor: .black).opacity(0.6), lineWidth: 0.3) // Border
                    )

           
            
                    HStack {
                        Button(action: {
                        
                            viewModel.food.sell_by_weight.toggle()
                        }) {
                            Image(viewModel.food.sell_by_weight ? "icon-check-square" : "icon-uncheck-square", bundle: .main)
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        Text("Bán theo kg")
                            .font(font.r_14)

                        Spacer()
                    }.commonTextFieldDecor(height: 45)

                    
                    HStack {
                        Button(action: {
                            isSeasonalPrice.toggle()
                        }) {
                            Image(isSeasonalPrice ? "icon-check-square" : "icon-uncheck-square", bundle: .main)
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        Text("Giá theo thời vụ")
                            .font(font.r_14)

                        Spacer()
                    }.commonTextFieldDecor(height: 45)

                    

                    VStack(alignment: .leading, spacing: 16) {
     
                            HStack {
                                Button(action: {
                                    isPrintEnabled.toggle()
                                }) {
                                    Image(isPrintEnabled ? "icon-check-square" : "icon-uncheck-square", bundle: .main)
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                }
                                Text("In phiếu bếp/bar")
                                    .font(font.r_14)
            
                                Spacer()
                            }
                        
                            
                            if isPrintEnabled {
                                HStack(spacing:20) {
                                    Text("Printer:")
                                        .font(font.r_14)
                                        .foregroundColor(color.gray_600)
                                    
                                    Menu {
                                        ForEach(viewModel.printers, id: \.id) { printer in
                                            Button(action: {
                                                for (i,element) in viewModel.printers.enumerated(){
                                                    if element.id == printer.id{
                                                        viewModel.printers[i].isSelect = true
                                                        viewModel.food.printer_id = printer.id
                                                    }else{
                                                        viewModel.printers[i].isSelect = false
                                                    }
                                                }
                                            }) {
                                                Label(printer.name, systemImage:printer.isSelect ? "checkmark" : "")
                                            }
                                        }
                                    } label: {
                                        HStack {
                                            Text(viewModel.printers.first(where:{$0.isSelect})?.name ?? "Please choose printer").font(font.r_14)
                                                .foregroundColor(viewModel.printers.first(where:{$0.isSelect}) == nil ? color.gray_600 : .black)
                                            Spacer()
                                            Image(systemName: "chevron.down").foregroundColor(.gray)
                                        }
                                        .commonTextFieldDecor(height: 40)
                                    }
                                }
                            }
                        }
                        .foregroundColor(.black)
                        .padding(EdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 6))
                        .overlay(
                          // Placeholder and border overlay
                          RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(uiColor: .black).opacity(0.6), lineWidth: 0.3) // Border
                        )
                  
                
                    
                    HStack {
                        Button(action: {
                            isPrintStamp.toggle()
                            
                        }) {
                            Image(isPrintStamp ? "icon-check-square" : "icon-uncheck-square", bundle: .main)
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        Text("In stamp")
                            .font(font.r_14)

                        Spacer()
                    }
                    .commonTextFieldDecor(height: 45)

                    
                    
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Button(action: {
                                isApplyVAT.toggle()
                            }) {
                                Image(isApplyVAT ? "icon-check-square" : "icon-uncheck-square", bundle: .main)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                            Text("Tax")
                                .font(font.r_14)
        
                            Spacer()
                        }
                    
                        
                        if isApplyVAT {
                            // Label and Picker for selecting printer
                            HStack {
                                Text("VAT:").font(font.r_14)
                                
                                Picker(selection: $selectedPrinter, label: Text(selectedPrinter.isEmpty ? "Vui lòng chọn máy in" : selectedPrinter)) {
                                    ForEach(viewModel.printers, id: \.id) { printer in
                                        Text(printer.name).tag(printer.id)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .background(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                            }
                        }
                    }
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 6))
                    .overlay(
                      // Placeholder and border overlay
                      RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(uiColor: .black).opacity(0.6), lineWidth: 0.3) // Border
                    )
              
                }

            }
            .padding(.horizontal) // Optional
            
            // Buttons
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("HỦY")
                        .font(font.b_16)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.red, lineWidth: 1)
                        )
                }
                
                Button(action: {
                    viewModel.createItem(item: viewModel.food)
                }) {
                    Text("THÊM")
                        .font(font.b_16)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .background(color.orange_brand_900)
                        .cornerRadius(8)
                }
            }
            .frame(maxHeight:45)
            .padding()
       
        }.onAppear(perform: {
           
            viewModel.getCategories()
            viewModel.getPrinters()
            viewModel.getUnits()
            viewModel.getChildrenItem()
            viewModel.food = item
            viewModel.bind(view: self)
        })
        
    }
 
        
}

#Preview {
    CreateFoodView()
}










