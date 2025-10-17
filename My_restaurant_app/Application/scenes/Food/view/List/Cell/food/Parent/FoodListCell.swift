//
//  FoodListCell.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 21/09/2024.
//

import SwiftUI
import Combine

struct FoodListCell: View {
    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color
    @ObservedObject var viewModel:FoodViewModel

    @State var disable:Bool = false
    
    @Binding var item:Food

    var body: some View {
        VStack(alignment:.leading,spacing:0){
            HStack(spacing:0){
                
                if disable{
                    
                    Image("icon-uncheck-disable", bundle: .main)
                          .resizable()
                          .frame(width: 20, height: 20)
                          .frame(width:45)
                    
                }else{
                    
                    Button(action: {
                        
          
                        
                        if !item.food_options.isEmpty{
                            
                            if item.isSelect{
                                item.deSelect()
                            }else{
                                viewModel.presentSheet = (true,item)
                            }

                           
                        }else{
                            
                            item.isSelect ? item.deSelect() : item.select()
                            
                            
                        }
                        
                    }) {
                        Image(item.isSelect ? "icon-check-square" : "icon-uncheck-square", bundle: .main)
                              .resizable()
                              .frame(width: 20, height: 20)
                              .padding(10) // Add padding around the icon
                        
                    }
                    .frame(width:45)
                    .frame(maxHeight:.infinity)
              
                }
                
                HStack(spacing:5){
                    
                    LogoImageView(imagePath: MediaUtils.getFullMediaLink(string: item.avatar),mold:.square)
                    
                    VStack(alignment:.leading,spacing:2){
                        
                        Text(item.name).font(font.r_14)

                        if item.temporary_price < 0 {
                            Group{
                                Text(String(format:"%@/%@",item.price,item.unit_type )){$0.strokeColor = ColorUtils.red_600()} +
                                Text(item.price_with_temporary.toString){ $0.foregroundColor = color.green_600} +
                                Text(item.unit_type){ $0.foregroundColor = color.gray_600}
                            }
                            
                        }else{
                            
                            Group{
                                Text(item.price_with_temporary.toString).font(font.b_12).foregroundColor(color.orange_brand_900) +
                                Text(String(format:"/%@",item.unit_type )).font(font.b_12).foregroundColor(color.gray_600)
                            }
                          
                        }
                    }.font(font.m_14)
                    
                    Spacer()
                    
                    if item.is_sell_by_weight == ACTIVE{
                        Image("icon-scale", bundle: .main)
                            .resizable()
                            .frame(width: 18,height: 18)
                            .padding(.trailing,15)
                    }
                    
                    if disable{
                        
                        if item.is_out_stock == ACTIVE{
                            Text("HẾT MÓN").font(font.m_10).foregroundColor(.red).padding(.trailing,15)
                        }else{
                            Text("CHƯA CÓ BẾP").font(font.m_10).foregroundColor(.red).padding(.trailing,15)
                        }
                
                    }
 
                }
                .onTapGesture(perform: {
           
                    if !item.food_options.isEmpty{
                        viewModel.presentSheet = (true,item)
                    }else{
                        item.setQuantity(quantity: item.quantity + (item.is_sell_by_weight == ACTIVE ? 0.01 : 1))
                    }
                    
                })
                
                if item.isSelect{
                    
                    
                    if item.category_type == .service{
                        
                        Text(item.quantity.toString).font(font.r_14).padding(.trailing,20)
                        
                    }else{
                        
                        QuantityView(width: 25,height:25, quantity: $item.quantity){(type,quantity) in
                            switch type{
                                case .minus:
                                    item.setQuantity(quantity: item.quantity - (item.is_sell_by_weight == ACTIVE ? 0.01 : 1))
                              
                                case .plus:
                          
                                    item.setQuantity(quantity: item.quantity + (item.is_sell_by_weight == ACTIVE ? 0.01 : 1))

                                default:
                                    break
                                    
                            }
                        }
                        .padding(.trailing,8)
                        .font(font.r_14)
                    }
                }
                
                
            }
            
            
            if item.discount_percent > 0{
                
                HStack{
                    
                    Image("icon-discount.fill", bundle: .main)
                        .resizable()
                        .frame(width: 16,height: 16)
                        .padding(.leading,15)
                    
                    Text(item.discount_percent.toString + "%")
                        .font(font.m_14)
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
                        .font(font.m_14)
                        .foregroundColor(Color(ColorUtils.orange_brand_700()))
                }.padding(.vertical,5)
            }
            
            if !item.addition_foods.isEmpty && item.isSelect{
                ForEach($item.addition_foods) { child in
                    ChildrenOfFoodListCell(type:.addition,child: child)
                    .listRowSeparator(.hidden)
                    .buttonStyle(PlainButtonStyle())
                }
            }
            
            if !item.food_in_combo.isEmpty && item.isSelect{
                ForEach($item.food_in_combo) { child in
                    ChildrenOfFoodListCell(type:.combo,child: child)
                    .listRowSeparator(.hidden)
                    .buttonStyle(PlainButtonStyle())
                }
            }
            
            if !item.food_options.isEmpty && item.isSelect{
                ForEach($item.food_options.flatMap{$0.addition_foods}.filter{$0.isSelect.wrappedValue}) { child in
                    ChildrenOfFoodListCell(type:.option,child: child)
                    .listRowSeparator(.hidden)
                    .buttonStyle(PlainButtonStyle())
                }
            }

        }
        .buttonStyle(PlainButtonStyle())
        .padding(.vertical,8)
        .overlay(
            Rectangle()
                .frame(width: disable ? 0 : 6) // The height of the underline
                .foregroundColor(Color(ColorUtils.gray_600()))
                .cornerRadius(6, corners: [.bottomLeft,.topLeft])
            , // Color of the underline
            alignment: .trailing // Align it to the bottom of the text
        )
        .frame(maxHeight:.infinity)
        .background(.white)
        .onAppear(perform: {

            disable = (item.is_out_stock == ACTIVE) || (item.category_type != .service && item.restaurant_kitchen_place_id == 0)
            
        })
        
    }
    

    

}

#Preview {

    if let data = Food.getDummyData() {
        return ZStack{
            
            Rectangle()
            
            FoodListCell(viewModel:FoodViewModel(),item: .constant(data))
                .frame(maxHeight:100).background(.white)
            
        }
    }else{
        return Text("Error of parsing JSON data")
    }
    
   

}
