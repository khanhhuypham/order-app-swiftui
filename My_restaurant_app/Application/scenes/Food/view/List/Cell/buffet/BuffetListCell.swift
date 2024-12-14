//
//  BuffetListCell.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 28/09/2024.
//

import SwiftUI
import Combine
struct BuffetListCell: View {
    @Injected(\.fonts) private var fonts
    @Injected(\.colors) private var colors
    @ObservedObject var viewModel:FoodViewModel
    @Binding var item:Buffet
  
    
    var body: some View {
        VStack(alignment:.leading,spacing: 0){
            HStack(spacing:0){
                Button(action: {
                    
                    var list = viewModel.buffets
                    
                    for (i,data) in list.enumerated(){
                 
                        if data.id != item.id {
                            list[i].deSelect()
                        }else{
                            
                            list[i].isSelect
                            ? list[i].deSelect()
                            : list[i].select()
                            //========================  save selected item ============
                        }
                    }
                    viewModel.buffets = list

                    
                }) {
                    Image(item.isSelect ? "icon-radio-check" : "icon-radio-uncheck", bundle: .main)
                        .padding(.trailing, 15)
                        
                }
                .frame(width:45)
                .frame(maxHeight:.infinity)
               
                
                HStack(spacing:0){
                    LogoImageView(imagePath: "",mold:.square)
                      
                    VStack(alignment: .leading,spacing:2) {
                        Text(item.name ?? "")
                            .font(fonts.r_14)
                         
                        
                        Group{
                            Text(item.adult_price.toString+"/"){$0.foregroundColor = ColorUtils.orange_brand_900()} +
                            Text("vé"){ $0.foregroundColor = ColorUtils.gray_600()}
                        }

                    }.font(fonts.m_14)
                    
                    Spacer()
                    
                }.onTapGesture(perform: {
                    item.setQuantity(quantity: item.quantity + 1)
                })
                
                if item.ticketChildren.isEmpty && item.isSelect{
                    actionView.padding(.trailing,8)
                }
            
        
            }
            
            
            if item.adult_discount_percent ?? 0 > 0{
                
                HStack{
                    Image(systemName:"note.text")
                        .padding(.leading,15)
                    Text((item.adult_discount_percent?.toString ?? "") + "%")
                }
                
            }
          

            if !item.ticketChildren.isEmpty && item.isSelect{
                
                ForEach($item.ticketChildren) { child in
                    ChildrenOfBuffetListCell(child: child)
                    .listRowSeparator(.hidden)
                    .buttonStyle(PlainButtonStyle())
                }
            }
                
        }
        .padding(.vertical,8)
        .overlay(
            Rectangle()
                .frame(width: 4) // The height of the underline
                .foregroundColor(Color(ColorUtils.orange_brand_900()))
                .cornerRadius(4, corners: [.bottomLeft,.topLeft])
            , // Color of the underline
            alignment: .trailing // Align it to the bottom of the text
        )
        .frame(maxHeight:.infinity)
        .background(.white)
    }
    

    private var actionView:some View{
        
        HStack(alignment:.center,spacing: 0){
            Button(action: {
//                item.setQuantity(quantity: item.quantity - (item.is_sell_by_weight == ACTIVE ? 0.01 : 1))
            }, label: {
                Image(systemName: "minus")
                    .frame(width: 30,height: 30)
                    .foregroundColor(.white)
                    .background(.gray)
                    .cornerRadius(5)
            })
            .frame(maxWidth:30,maxHeight:.infinity)
         
            
            
            
            TextField("",value: $item.quantity,format: .number)
                .keyboardType(.numberPad)
                .font(fonts.m_12)
                .frame(maxWidth:.infinity,maxHeight:.infinity)
                .multilineTextAlignment(.center)
                .onReceive(Just(item.quantity)) { value in
//                    print(value)
                }
      
            
            Button(action: {
            
//                item.setQuantity(quantity: item.quantity + (item.is_sell_by_weight == ACTIVE ? 0.01 : 1))
                
            }, label: {
                Image(systemName: "plus")
                    .frame(width: 30,height: 30)
                    .foregroundColor(.white)
                    .background(.gray)
                    .cornerRadius(5)
            })
            .frame(maxWidth:30,maxHeight:.infinity)
          
        }
        .frame(maxWidth: 100,maxHeight:40)

    }
    
}

#Preview {

    if let data = Buffet.getDummyData() {
        return ZStack{
            
            Rectangle()
            
            BuffetListCell(viewModel:FoodViewModel(), item: .constant(data))
                .frame(maxHeight:100).background(.white)
            
        }
    }else{
        return Text("Error of parsing JSON data")
    }
    
   

}
