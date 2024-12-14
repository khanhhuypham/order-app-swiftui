//
//  FoodListCell.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 21/09/2024.
//

import SwiftUI
import Combine
struct FoodListCell: View {
    @Injected(\.fonts) private var fonts
    @Injected(\.colors) private var colors
    @Binding var item:Food

    var body: some View {
        VStack(alignment:.leading,spacing:0){
            HStack(spacing:0){
                
                Button(action: {
                    
                    item.isSelect
                    ? item.deSelect()
                    : item.select()
                    
                }) {
                    Image(item.isSelect ? "icon-check-square" : "icon-uncheck-square", bundle: .main)
                }
                .frame(width:45)
                .frame(maxHeight:.infinity)
                
                HStack(spacing:5){
                    
                    LogoImageView(imagePath: item.avatar,mold:.square)
                    
                    VStack(alignment:.leading,spacing:2) {
                        Text(item.name)
                            .font(fonts.r_14)


                        if item.temporary_price < 0 {
                            Group{
                                Text(String(format:"%@/%@",item.price.toString,item.unit_type )){$0.strokeColor = ColorUtils.red_600()} +
                                Text(item.temporary_price.toString){ $0.foregroundColor = ColorUtils.green_600()} +
                                Text(item.unit_type){ $0.foregroundColor = ColorUtils.gray_600()}
                            }
                            
                        }else{
                            
                            Group{
                                Text(item.price.toString){ $0.foregroundColor = ColorUtils.orange_brand_900()} +
                                Text(String(format:"/%@",item.unit_type )){ $0.foregroundColor = ColorUtils.gray_600()}
                            }
                          
                        }
                    }
                    .font(fonts.m_14)
                    
                    Spacer()
                    
                }.onTapGesture(perform: {
                    item.setQuantity(quantity: item.quantity + (item.is_sell_by_weight ? 0.01 : 1))
                })
                
                if item.isSelect{
                    actionView.padding(.trailing,8)
                }
          
            }
            
            
            if item.discount_percent > 0{
                
                HStack{
                    
                    Image("icon-discount.fill", bundle: .main)
                        .resizable()
                        .frame(width: 16,height: 16)
                        .padding(.leading,15)
                    
                    Text(item.discount_percent.toString + "%")
                        .font(fonts.m_14)
                        .foregroundColor(Color(ColorUtils.blue_brand_700()))
                }.padding(.vertical,5)
                
            }
          
            
            if !item.note.isEmpty{
                HStack(spacing:4){
                    Image("icon-note-file", bundle: .main)
                        .resizable()
                        .frame(width: 16,height: 16)
                        .padding(.leading,15)
                        .foregroundColor(Color(ColorUtils.gray_600()))
                    
                    Text(item.note)
                        .font(fonts.m_14)
                        .foregroundColor(Color(ColorUtils.orange_brand_700()))
                }.padding(.vertical,5)
            }
            
          
            
            if !item.addition_foods.isEmpty && item.isSelect{
                ForEach($item.addition_foods) { child in
                    ChildrenOfFoodListCell(child: child)
                    .listRowSeparator(.hidden)
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding(.vertical,8)
        .overlay(
            Rectangle()
                .frame(width: 4) // The height of the underline
                .foregroundColor(Color(ColorUtils.gray_600()))
                .cornerRadius(4, corners: [.bottomLeft,.topLeft])
            , // Color of the underline
            alignment: .trailing // Align it to the bottom of the text
        )
        .frame(maxHeight:.infinity)
        .background(.white)
    }
    

    private var actionView:some View{
        
        HStack(alignment:.center,spacing: 0){
            
            if item.category_type != .service{
                
                Button(action: {
                    item.setQuantity(quantity: item.quantity - (item.is_sell_by_weight ? 0.01 : 1))
                }, label: {
                    Image(systemName: "minus")
                        .frame(width: 30,height: 30)
                        .foregroundColor(.white)
                        .background(.gray)
                        .cornerRadius(5)
                })
                .frame(maxWidth:30,maxHeight:.infinity)

            }
            
            TextField("",value: $item.quantity,format: .number)
                .keyboardType(.numberPad)
                .font(fonts.m_12)
                .frame(maxWidth:.infinity,maxHeight:.infinity)
                .multilineTextAlignment(.center)
                .onReceive(Just(item.quantity)) { value in
//                    print(value)
                }
      
            
            if item.category_type != .service{
                Button(action: {
                    
                    item.setQuantity(quantity: item.quantity + (item.is_sell_by_weight ? 0.01 : 1))
                    
                }, label: {
                    Image(systemName: "plus")
                        .frame(width: 30,height: 30)
                        .foregroundColor(.white)
                        .background(.gray)
                        .cornerRadius(5)
                })
                .frame(maxWidth:30,maxHeight:.infinity)
            }
          
        }
        .frame(maxWidth: 100,maxHeight:40)

    }
    
}

#Preview {

    if let data = Food.getDummyData() {
        return ZStack{
            
            Rectangle()
            
            FoodListCell(item: .constant(data))
                .frame(maxHeight:100).background(.white)
            
        }
    }else{
        return Text("Error of parsing JSON data")
    }
    
   

}
