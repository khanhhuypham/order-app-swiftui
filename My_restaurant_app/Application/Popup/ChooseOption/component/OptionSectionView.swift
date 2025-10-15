//
//  OptionSectionView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 08/07/2025.
//

import SwiftUI

struct OptionSectionView: View {
    @Injected(\.fonts) var font: Fonts
    @Injected(\.colors) var color: ColorPalette

    @Binding var option:FoodOption
    

    var body: some View {

        VStack{
            HStack {
                
                Text(option.name)
                    .font(font.b_14)
                    .foregroundColor(Color(UIColor.darkGray))

                Spacer()

                Text(option.max_items_allowed > 1 ? String(format: "Chọn tối đa %d", option.max_items_allowed) : "Chọn 1")
                    .font(font.sb_13)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(color.orange_brand_900)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
            
            Divider()
            
            ForEach($option.addition_foods) { $item in
                VStack{
                    HStack {
                        
                        if option.max_items_allowed > 1 {
                            Image(item.isSelect ? "icon-check-square" : "icon-uncheck-square", bundle: .main)
                                .onTapGesture {
                                    item.isSelect.toggle()
                                    
                                    item.quantity = item.isSelect ? 1 : 0
                                    
                                }
                        } else {
                            Image(item.isSelect ? "icon-radio-check" : "icon-radio-uncheck", bundle: .main)
                                .onTapGesture {
                                    for (index, food) in option.addition_foods.enumerated() {
                                        option.addition_foods[index].isSelect = (food.id == item.id)
                                        item.quantity = item.isSelect ? 1 : 0
                                    }
                                }
                        }

                        Text(item.name).font(font.r_14)

                        Spacer()

                        if item.isSelect {
                            
                            QuantityView(width: 25,height:25,quantity: Binding<Float>(
                                get: { Float(item.quantity) },
                                set: { item.quantity = Int($0) }
                            )){(type,quantity) in
                              
                                switch type{
                                    case .minus:
                                        item.quantity = Int(quantity - 1)
                                        if  item.quantity <= 0{
                                            item.quantity = 0
                                            item.isSelect = false
                                        }
                                        break
                                    
                                    case .plus:
                                        item.quantity = Int(quantity + 1)
                                    
                                    default:
                                        item.quantity = Int(quantity)
                                        if  item.quantity >= 999{
                                            item.quantity = 999
                                        }
                                        
                                }
                               
                            }
                        }
                        
                    }
                    Divider()
                }
               
            }.frame(height: 30)
        }
       
        .background(.white)

    }
    
    

}


#Preview {
    var food = FoodOption()
    food.name = "Tỉ lệ Đường"
    food.max_items_allowed = 2

    for i in 1...5 {
        var addition_food = FoodAddition()
        addition_food.name = "Món \(i)"
        food.addition_foods.append(addition_food)
    }

    return OptionSectionView(option: .constant(food))
}
