//
//  FoodAdditionView.swift
//  SwiftUI-Demo3
//
//  Created by Pham Khanh Huy on 23/09/2024.
//


import SwiftUI
import Combine
struct ChildrenOfFoodListCell: View {
    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color
    var type:FOOD_ADDITION_TYPE
    @Binding var child:FoodAddition
    
    var body: some View {

        HStack(spacing:0) {
            
            if type == .addition{
                
                Button(action: {
                   
                    child.isSelect
                    ? child.deSelect()
                    : child.select()
                    
                }) {
                    Image(child.isSelect ? "icon-check-square" : "icon-uncheck-square", bundle: .main)
                        .padding(.leading, 20)
                    
                }.frame(width: 50,height: 50)
                
            }else{
                Rectangle()
                    .fill(.clear)
                    .frame(width: 50, height: 50)
            }
            
    
            VStack(alignment: .leading,spacing:-10) {
                Text(child.name)
                    .font(font.m_12)
                    .fullBox(alignment: .leading)
                   
                Text(child.price.toString)
                    .font(font.m_12)
                    .foregroundColor(color.orange_brand_900)
                    .fullBox(alignment: .leading)
                   
            }
            .onTapGesture(perform: {
                child.setQuantity(quantity: child.quantity + 1)
            })
            
            if type == .addition{
                
                actionView.padding(.trailing,8)
                
            }else if type == .combo{
                
                Text(child.combo_quantity.description)
                    .font(font.m_12)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 80,maxHeight:40)
                
            }else if type == .option{
                
                Text(child.quantity.description)
                    .font(font.m_12)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 80,maxHeight:40)
            }
        
           
        
        }
    }
    
    private var actionView:some View{
        HStack(alignment:.center,spacing: 0){
            
            Button(action: {
                child.setQuantity(quantity: child.quantity - 1)
            }, label: {
                
                Image(systemName: "minus")
                    .frame(width: 25,height: 25)
                    .foregroundColor(.white)
                    .background(.gray)
                    .cornerRadius(5)
                
                
            })
            .frame(maxWidth: 25,maxHeight:.infinity)
           
            
            TextField("",value: $child.quantity,format: .number)
                .keyboardType(.numberPad)
                .font(font.m_12)
                .multilineTextAlignment(.center)
                .frame(maxWidth:.infinity,maxHeight:.infinity)
                .onReceive(Just(child.quantity)) { value in
//                    print(value)
                }
            
            Button(action: {
                child.setQuantity(quantity: child.quantity + 1)
            }, label: {
                Image(systemName: "plus")
                    .frame(width: 25,height: 25)
                    .foregroundColor(.white)
                    .background(.gray)
                    .cornerRadius(5)
            })
            .frame(maxWidth: 25,maxHeight:.infinity)
        }
        .frame(maxWidth: 80,maxHeight:40)
    }
}

#Preview {
    
    if let data = FoodAddition.getDummyData().first {
        return ZStack{
            
            Rectangle()
            
            ChildrenOfFoodListCell(type:.addition,child: .constant(data))
                .background(.white)
                .frame(maxHeight:80).background(.white)
        }
    }else{
        return Text("Error of parsing JSON data")
    }
    
    
}
