//
//  QuicklyCreateTableView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 17/10/2024.
//

import SwiftUI



struct QuicklyCreateTableView: View {

    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color
    @Binding var isPresent:Bool
    @State private var tables:[CreateTableQuickly] = []
    @State var areaArray:[Area] = []
    
    
    @State var parameter:(
        area_id:Int,
        name:String,
        numberFrom:Int,
        numberTo:Int,
        slot:Int
    ) = (
        area_id:0,
        name:"",
        numberFrom:0,
        numberTo:0,
        slot:0
    )
    
    var validForm: Bool {

        let condition1 = parameter.name.count > 0 && parameter.name.count <= 4
        
        let condition2 = (parameter.numberFrom > 0 && parameter.numberFrom  <= 999) &&  parameter.numberFrom < parameter.numberTo
        
        let condition3 = (parameter.numberTo > 0 && parameter.numberTo  <= 999) && parameter.numberTo > parameter.numberFrom
        
//        let condition4 = parameter.slot > 0 && parameter.slot <= 999
        
        let condition5 = parameter.area_id > 0
        
        return condition1 && condition2 && condition3 && condition5
       
    }
    
    
    var onConfirmPress: (([CreateTableQuickly],Int) -> Void)? = nil
    
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
         
            if let selectedArea = areaArray.first(where: {$0.isSelect}){

                parameter.area_id = selectedArea.id ?? 0
            }else{
                areaArray[0].isSelect = true
                parameter.area_id = areaArray[0].id ?? 0
            }

        })
        
    }
    
    
    private var mainContent:some View{
        VStack(spacing:0) {
            
            Text("thêm bàn nhanh".uppercased())
                .font(font.b_18)
                .foregroundColor(color.orange_brand_900)
                .padding(.top,20)
            
            VStack(alignment:.leading,spacing: 15){
                
                TextField("Tên bắt đầu", text: $parameter.name)
                    .font(font.r_13)
                    .commonTextFieldDecor(height: 38)
                
                HStack(spacing:2){
                    Text("Số bắt đầu:")
                    
                    TextField("0", value: $parameter.numberFrom, format: .number)
                        .keyboardType(.numberPad)
                        .foregroundColor(color.orange_brand_900)
                    
                }
                .font(font.r_13)
                .commonTextFieldDecor(height: 38)
               
                
                HStack(spacing:2){
                    Text("Số kết thúc:")
                    
                    TextField("0", value: $parameter.numberTo, format: .number)
                        .keyboardType(.numberPad)
                        . foregroundColor(color.orange_brand_900)
                    
              
                }
                .font(font.r_13)
                .commonTextFieldDecor(height: 38)
                
                
                Menu {
                    ForEach(areaArray, id: \.id) { area in
                        
                        Button(action: {
                            
                            for (index,element) in areaArray.enumerated(){
                                if element.id == area.id{
                                    areaArray[index].isSelect = true
                                    parameter.area_id = area.id ?? 0
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
                    
                    TextField("0", value: $parameter.slot, format: .number)
                        .keyboardType(.numberPad)
                        .foregroundColor(color.orange_brand_900)
                    
              
                }
                .font(font.r_13)
                .commonTextFieldDecor(height: 38)
        
                Text("Ví dụ: Cần tạo 3 bàn có tên là Bàn1 , Bàn2, Bàn3 Ký tự bắt đầu là Bàn Số bắt đầu là 1 và số kết thúc là 3")
                    .font(font.r_13)
                    .foregroundColor(color.orange_brand_900)
            }
            .padding(.vertical,20).padding(.horizontal,20)
       

            btnGroup
            
        }
        .background(.white)
        .shadowedStyle()
        .cornerRadius(5)
        .padding(.horizontal, 40)
        .onAppear(perform: {
            
        })
    }
    
    private var btnGroup:some View{
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
                    
                    for i in (parameter.numberFrom...parameter.numberTo){
                        tables.append(
                            CreateTableQuickly.init(
                                area_id:parameter.area_id,
                                name: String(format: "%@%d",parameter.name,i),
                                total_slot: parameter.slot
                            )
                        )
                    }
                   
                    
                    confirm(tables,areaArray.first{$0.isSelect}?.id ?? -1)
                    isPresent = false
                }
                
            } label: {
                Text("thêm".uppercased())
                    .font(font.b_18)
                    .frame(maxWidth: .infinity,maxHeight:.infinity)
                    .foregroundColor(.white)
                    .background(validForm ? color.orange_brand_900 : color.gray_600)
                    .disabled(validForm)
        
            }
            .buttonStyle(.plain)
        }.frame(height: 50)
    }
    
}



#Preview {
    ZStack {
        Rectangle()
        QuicklyCreateTableView(isPresent:.constant(true))
    }
   
}
