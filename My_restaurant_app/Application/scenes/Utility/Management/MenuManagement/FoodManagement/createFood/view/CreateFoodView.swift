//
//  CreateFood.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 2/10/25.
//


import SwiftUI

struct CreateFoodView: View {
    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color
    var item:Food = Food()
    
    @StateObject var viewModel = CreateFoodViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    @State private var isSeasonalPrice: Bool = false
    @State private var isPrintEnabled = true
    @State private var isApplyVAT = false

    

    var body: some View {
        
        VStack{
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    
                    // Image picker placeholder
                    Button(action: {
                        // Action for selecting image
                    }) {
                        ZStack {
                            
                            LogoImageView(
                                imagePath: MediaUtils.getFullMediaLink(string: viewModel.food.avatar),
                                width: 100,
                                height: 100,
                                mold:.square
                            )
                             
                            
                            Image(systemName: "camera.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.blue)
                                .offset(x:35,y:35)
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
                        Text("Danh mục:")
                            .font(font.r_14)
                            .foregroundColor(color.gray_600)
                            .frame(width: 100)
                        
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
                                Text(viewModel.categories.first(where:{$0.isSelect})?.name ?? "")
                                    .font(font.r_14)
                                    .foregroundColor(.black)
                                Spacer()
                                
                                Image(systemName: "chevron.down").foregroundColor(.gray)
                            }.commonTextFieldDecor(height: 40)
                        }.menuIndicator(.hidden)
                    }

                    
                    HStack(spacing:20) {
                        Text("Đơn vị:")
                            .font(font.r_14)
                            .foregroundColor(color.gray_600)
                            .frame(width: 100)
                        
                        Menu {
                            ForEach(viewModel.units) { unit in
                                Button(action: {

                                    for (i,element) in viewModel.units.enumerated(){
                                        if element.id == unit.id{
                                            viewModel.units[i].isSelect = true
//                                            viewModel.food.unit_id = unit.id
                                        }else{
                                            viewModel.units[i].isSelect = false
                                        }
                   
                                    }
                                }) {
                                    Label(unit.name ?? "", systemImage: unit.isSelect ? "checkmark" : "")
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
                    
                                
//                    HStack {
//                        Button(action: {
//                        
//                            viewModel.food.sell_by_weight.toggle()
//                            
//                        }) {
//                            Image(viewModel.food.sell_by_weight ? "icon-check-square" : "icon-uncheck-square", bundle: .main)
//                                .resizable()
//                                .frame(width: 20, height: 20)
//                        }
//                        Text("Bán theo kg")
//                            .font(font.r_14)
//
//                        Spacer()
//                    }.commonTextFieldDecor(height: 45)

                    
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
                                Text("Chọn bếp:")
                                    .font(font.r_14)
                                    .foregroundColor(color.gray_600)
                                    .frame(width: 100)
                                
                                Menu {
                                    ForEach(viewModel.printers) { printer in
                                        Button(action: {
                                            for (i,element) in viewModel.printers.enumerated(){
                                                if element.id == printer.id{
                                                    viewModel.printers[i].isSelect = true
//                                                    viewModel.food.printer_id = printer.id
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
                            viewModel.food.allow_print_stamp.toggle()
                            
                        }) {
                            Image(viewModel.food.allow_print_stamp ? "icon-check-square" : "icon-uncheck-square", bundle: .main)
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
                                if !isApplyVAT{
                                    viewModel.food.vat_id = 0
                                }
                                
                                
                            }) {
                                Image(isApplyVAT ? "icon-check-square" : "icon-uncheck-square", bundle: .main)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                            Text("Thuế")
                                .font(font.r_14)
        
                            Spacer()
                        }
                    
                        
                        if isApplyVAT {
                            // Label and Picker for selecting printer
                            HStack {
                                Text("Chọn thuế:").font(font.r_14).frame(width: 100)
                                
                                
                                Menu {
                                    ForEach(viewModel.vats) { vat in
                                        Button(action: {
                                            for (i,element) in viewModel.vats.enumerated(){
                                                if element.id == vat.id{
                                                    viewModel.vats[i].isSelect = true
                                                    viewModel.food.vat_id = vat.id
                                                }else{
                                                    viewModel.vats[i].isSelect = false
                                                }
                                            }
                                        }) {
                                            Label(vat.vat_config_name, systemImage:vat.isSelect ? "checkmark" : "")
                                        }
                                    }
                                } label: {
                                    HStack {
                                        Text(viewModel.vats.first(where:{$0.isSelect})?.vat_config_name ?? "Vui lòng chọn vat").font(font.r_14)
                                            .foregroundColor(viewModel.vats.first(where:{$0.isSelect}) == nil ? color.gray_600 : .black)
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
            
            viewModel.food = CreateFood(food:item)
            
            isApplyVAT = viewModel.food.vat_id > 0

            dLog(viewModel.food.vat_id > 0)
            
            Task{
                await viewModel.getPrinters()
            }
            Task{
                await viewModel.getCategories()
            }
            
            Task{
                await viewModel.getChildrenItem()
            }
            
            Task{
                await viewModel.getUnits()
            }
            
            
            Task{
                await viewModel.getVats()
            }
            
            Task{
                await viewModel.getChildrenItem()
            }
            
        
        })
        
    }
 
        
}

#Preview {
    CreateFoodView()
}
