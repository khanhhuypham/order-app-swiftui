//
//  ChildrenOfBuffetListCell.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 07/10/2024.
//

import SwiftUI
import Combine
struct ChildrenOfBuffetListCell: View {
    
    @Injected(\.fonts) private var fonts
    
    @Binding var child:BuffetTicketChild
    
    var body: some View {

        HStack(spacing:0) {
            Button(action: {
               
                child.isSelect
                ? child.deSelect()
                : child.select()
                
            }) {
                
                Image(child.isSelect ? "icon-check-square" : "icon-uncheck-square", bundle: .main)
                    .padding(.leading, 20)
                
            }.frame(width: 50,height: 50)
        

            VStack(alignment: .leading,spacing:-10) {
                Text(child.name)
                    .font(fonts.m_12)
                    .fullBox(alignment: .leading)
                   
                Text(String(format: "%@/vé", child.price.toString))
                    .font(fonts.m_12)
                    .fullBox(alignment: .leading)
                   
            }
            .onTapGesture(perform: {
                child.setQuantity(quantity: child.quantity + 1)
            })
       
            Spacer()
            
            actionView
            
            .padding(.trailing,8)
        
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
