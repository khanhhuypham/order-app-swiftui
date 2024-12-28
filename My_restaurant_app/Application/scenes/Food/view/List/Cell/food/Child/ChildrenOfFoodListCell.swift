//
//  FoodAdditionView.swift
//  SwiftUI-Demo3
//
//  Created by Pham Khanh Huy on 23/09/2024.
//


import SwiftUI
import Combine
struct ChildrenOfFoodListCell: View {
    @Injected(\.fonts) private var fonts
    @Injected(\.colors) private var color
    @Binding var child:ChildrenItem
    var category_type:CATEGORY_TYPE
    var body: some View {

        HStack(spacing:0) {
            
            if category_type == .combo{
                Rectangle()
                    .frame(width: 50,height: 50)
                    .foregroundColor(.clear)
            }else{
                
                Button(action: {
                    child.isSelect
                    ? child.deSelect()
                    : child.select()
                    
                }) {
                    Image(child.isSelect ? "icon-check-square" : "icon-uncheck-square", bundle: .main)
                        .padding(.leading, 20)
                    
            
                }.frame(width: 50,height: 50)
            }
        

            VStack(alignment: .leading,spacing:-10) {
                Text(child.name)
                    .fullBox(alignment: .leading)
                
                Group{
                    Text(child.price.toString){ $0.foregroundColor = color.orange_brand_900} +
                    Text(String(format:"/%@",child.unit_type )){ $0.foregroundColor = color.gray_600}
                }
                   
            }
            .font(fonts.r_14)
            .onTapGesture(perform: {
                if category_type != .combo{
                    child.setQuantity(quantity: child.quantity + 1)
                }

            })
            
            
            if category_type == .combo{
                Text(child.quantity.description)
                    .font(fonts.r_13)
                    .padding(.trailing,20)
                   
            }else{
                actionView
                .padding(.trailing,8)
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
                .font(fonts.m_12)
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

//#Preview {
//    if let data = FoodAddition.getDummyData().first {
//        return ZStack{
//            
//            Rectangle()
//            
//            ChildrenOfFoodListCell(child: .constant(data))
//                .background(.white)
//                .frame(maxHeight:80).background(.white)
//        }
//    }else{
//        return Text("Error of parsing JSON data")
//    }
//}
