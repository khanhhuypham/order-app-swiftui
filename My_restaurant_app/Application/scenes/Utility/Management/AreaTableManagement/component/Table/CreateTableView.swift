//
//  CreateTableView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 17/10/2024.
//

import SwiftUI
import Combine


struct CreateTableView: View {

    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color
    @Binding var isPresent:Bool
    
    @State var table:Table = Table()
    @State var areaArray:[Area] = []
    
    var validForm: Bool {
        guard let name = table.name else{
            return false
        }
        
        return  name.count >= 2 && name.count <= 7
       
    }
    

    
    var onConfirmPress: ((Table) -> Void)? = nil
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {

        VStack{
            Spacer()
            mainContent
            Spacer()
        }.onAppear(perform: {
            
            
            if table.id == 0{
                if let selectedArea = areaArray.first(where: {$0.isSelect}){
                    table.area_id = selectedArea.id
                }else if !areaArray.isEmpty{
                    table.area_id = areaArray[0].id
                }
                
            }else{
                for (index,element) in areaArray.enumerated(){
                    areaArray[index].isSelect = element.id == table.area_id ? true : false
           
                    if element.id == table.area_id{
                        table.area_id = table.id
                    }
                    
                }
            }
                        
        })
        
    }
    
    
    private var mainContent:some View{
        VStack(spacing:0) {
            
            Text(String(format: "%@", table.id == 0 ? "thêm bàn" : "cập nhật bàn").uppercased())
                .font(font.b_18)
                .foregroundColor(color.orange_brand_900)
                .padding(.top,20)
            
            VStack(alignment:.leading,spacing: 15){
                
                TextField("Nhập tên bàn cần tạo mới", text: $table.name.toUnwrapped(defaultValue: "")
                )
                    .font(font.r_13)
                    .commonTextFieldDecor(height: 38)
                
                Menu {
                    ForEach(areaArray, id: \.id) { area in
                        Button(action: {
                            for (index,element) in areaArray.enumerated(){
                                if element.id == area.id{
                                    areaArray[index].isSelect = true
                                    table.area_id = area.id
                                }else{
                                    areaArray[index].isSelect = false
                                }
                            }
                        }) {
                            Label(area.name, systemImage: area.isSelect ? "checkmark" : "")
                        }
                        
                     }
                } label: {
                    HStack{
                        Text(areaArray.first{$0.isSelect}?.name ?? (areaArray.first?.name ?? "")).font(font.r_13)
                        Spacer()
                        Image(systemName: "chevron.down")
                    }
                    .commonTextFieldDecor(height: 38)
                }
              
                
                HStack(spacing:2){
                    Text("Số khách:")
                    
                    TextField("", value: $table.slot_number, format: .number)
                        .keyboardType(.numberPad)
                        .foregroundColor(color.orange_brand_900)
                    
    
                }
                .font(font.r_13)
                .commonTextFieldDecor(height: 38)
        
                if table.id ?? 0 > 0{
         
                    Button(action: {
                        table.active?.toggle()
                    }) {
                        HStack{
                            Image(table.active ?? false ? "icon-check-square" : "icon-uncheck-square", bundle: .main)
                            Text("ĐANG HOẠT ĐỘNG")
                                .font(font.r_14)
                                .foregroundColor(.black)
                            
                        }.frame(maxWidth:.infinity,alignment: .leading)
                      
                    }
                }
                
            }
            .padding(.vertical,20).padding(.horizontal,20)

       

            HStack(spacing:0){
                Button {
                    isPresent = false
                } label: {
                    Text("HUỶ")
                        .font(font.b_18)
                        .frame(maxWidth: .infinity,maxHeight:.infinity)
                        .foregroundColor(color.red_600)
                        .background(color.gray_200)
                }.buttonStyle(.plain)
                
                Button {
                 
                    
                    if let confirm = self.onConfirmPress,validForm{
                  
                        if table.id == nil{
                            table.active = true
                        }
                            
                        confirm(table)
                        isPresent = false
                    }
                    
                } label: {
                    Text(String(format: "%@", table.id == nil ? "thêm" : "cập nhật").uppercased())
                        .font(font.b_18)
                        .frame(maxWidth: .infinity,maxHeight:.infinity)
                        .foregroundColor(.white)
                        .background(validForm ? color.orange_brand_900 : color.gray_600)
                        .disabled(validForm)
            
                }
                .buttonStyle(.plain)
            }.frame(height: 50)
            
        }
        .background(.white)
        .shadowedStyle()
        .cornerRadius(5)
        .padding(.horizontal, 40)
        .onAppear(perform: {
            
        })
    }
    
}



#Preview {
    ZStack {
        Rectangle()
        CreateTableView(isPresent:.constant(true))
    }
   
}
