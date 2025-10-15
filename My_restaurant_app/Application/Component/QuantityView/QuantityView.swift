//
//  QuantityView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 09/07/2025.
//

import SwiftUI
import Combine


enum QuantityChangeType {
    case plus
    case minus
    case enterQuantity
}


struct QuantityView:View{
    @Injected(\.fonts) var font: Fonts
    @Injected(\.colors) var color: ColorPalette
    var width:CGFloat = 30
    var height:CGFloat = 30
    @Binding var quantity:Float
    

    var onChange: ((QuantityChangeType,Float) -> Void)? = nil
    
    var body: some View{
        HStack(alignment:.center,spacing: 0){
            
            Button(action: {
                onChange?(.minus,quantity)
            }, label: {
                Image(systemName: "minus")
                    .frame(width: width,height: height)
                    .foregroundColor(.white)
                    .background(color.gray_600)
                    .cornerRadius(4)
                
            }).frame(maxWidth:width,maxHeight:.infinity)
            
            
            TextField("",value: $quantity,format: .number)
                .keyboardType(.numberPad)
//                .font(font.m_12)
                .frame(maxWidth:.infinity,maxHeight:.infinity)
                .multilineTextAlignment(.center)
                .onChange(of: quantity) { newValue in
                    onChange?(.enterQuantity,newValue)
                }

      
            Button(action: {
                onChange?(.plus,quantity)
            }, label: {
                Image(systemName: "plus")
                    .frame(width: width,height: height)
                    .foregroundColor(.white)
                    .background(color.gray_600)
                    .cornerRadius(4)
            })
            .frame(maxWidth:width,maxHeight:.infinity)
          
        }
        .frame(maxWidth: 100,maxHeight:height)
    }
}
