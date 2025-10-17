//
//  OrderListCell.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 17/09/2024.
//

import SwiftUI

struct OrderListItem: View {
    @Injected(\.colors) var color: ColorPalette
    @Injected(\.fonts) var font: Fonts
    @Binding var item:OrderItem
    
    @State private var data:(
        presentChilrenItem:Bool,
        presentNote: Bool,
        presentGift:Bool,
        presentActionView: Bool,
        presentDiscountView: Bool,
        presentDiscountAmount: Bool,
        totalPrice:String,
        discountedPrice:String
    ) = (false,false,false,false,false,false,"","")
    

    
    var onIncrease:(()->Void)? = nil
    
    var onDecrease:(()->Void)? = nil
    

    var body: some View {
        
        HStack(alignment:.center,spacing: 0){
            
            HStack(spacing:8){
                
                LogoImageView(imagePath:MediaUtils.getFullMediaLink(string: item.food_avatar),mold:.square).frame(width: 40).frame(height: 40)
                
                mainContent.frame(maxWidth: .infinity,alignment: .leading)
                
            }.padding(.vertical,15)
            
        
            actionView.frame(width: 115)
        }
        .background(item.status.bgColor)
        .onAppear(perform: {
    
            data.totalPrice = (!item.order_detail_additions.isEmpty || !item.order_detail_options.isEmpty ? item.total_price_include_addition_foods : item.total_price).toString
            
            data.discountedPrice = item.discount_price.toString
            _ = item.service_time_used
            _ = TimeUtils.getSecondSFromDateString(dateString: item.service_end_time ?? "")
            
            data.presentChilrenItem = !item.order_detail_additions.isEmpty || !item.order_detail_combo.isEmpty || !item.order_detail_options.isEmpty

            data.presentNote = item.note.isEmpty ? false : true

            data.presentDiscountView = item.discount_percent == 0 ? false : true
            
            data.presentDiscountAmount = false

            data.presentGift = item.is_gift == DEACTIVE ? false : true

            data.presentActionView = item.status == .pending ? true : false
            
            if(item.is_gift == 1){
               data.presentDiscountAmount = false
            }else{
               data.presentDiscountAmount = item.discount_amount > 0 ? true : false
            }
            
//            if item.is_booking_item == ACTIVE{
//                switch item.category_type {
//                    case .drink:
//                        presentActionView = true
//                        break
//
//                    case .food:
//                        presentActionView = false
//                        break
//
//                    case .service:
//                        presentActionView = false
//                        break
//
//                    default:
//                        presentActionView = true
//                        break
//                    }
//            }
            
            
        })
    
       
    }

    
    private var mainContent: some View {
        
        VStack(alignment:.leading,spacing: 0){
            
            Text(item.name)
                .font(font.sb_14)
             
            
            if data.presentDiscountView{
                HStack{
                    Image("icon-discount.fill",bundle:.main)
                        .resizable()
                        .frame(width: 20,height: 16)
                  
                    Text(String(format: "Giảm giá: %d%%", item.discount_percent))
                        .font(font.r_11)
        
                }.foregroundColor(color.blue_brand_700)
            }
          
            if data.presentChilrenItem{
                
                VStack(alignment:.leading,spacing:0){
                    
                    if item.order_detail_additions.count > 0 {
                        
                        Text("[Món bán kèm]"){ $0.foregroundColor = ColorUtils.orange_brand_900()}
                        ForEach(Array(item.order_detail_additions.enumerated()), id: \.element) { (i,value) in
                            Group{
                                Text(String(format:"+ %@",value.name)).foregroundColor(color.gray_600) +
                                Text(String(format:" x %.0f",value.quantity)).foregroundColor(color.orange_brand_900) +
                                Text(" = " + value.total_price.toString).foregroundColor(color.gray_600)
                            }
                        }
             
                    }else if item.order_detail_combo.count > 0 {
                        
                        ForEach(Array(item.order_detail_combo.enumerated()), id: \.element) { (i,value) in
                            Group{
                                Text(String(format:"+ %@ ",value.name)){ $0.foregroundColor = ColorUtils.gray_600()} +
                                Text(String(format:"x %.0f",value.quantity)){ $0.foregroundColor = ColorUtils.orange_brand_900()} +
                                Text(" phần"){ $0.foregroundColor = ColorUtils.gray_600()}
                            }
                          
                        }
                    }

                    if !item.order_detail_options.isEmpty{
                        ForEach(item.order_detail_options.flatMap{$0.food_option_foods}.filter{$0.status == ACTIVE}) {value in
                            if value.price > 0{
                                Group{
                                    Text(String(format:"+ %@",value.food_name)).foregroundColor(color.gray_600) +
                                    Text(String(format:" x %.0f",value.quantity)).foregroundColor(color.orange_brand_900) +
                                    Text(String(format:" = %@",(value.quantity*Float(value.price)).toString)).foregroundColor(color.gray_600)
                                }
                                
                            }else{
                                Group{
                                    Text(String(format:"+ %@",value.food_name)).foregroundColor(color.gray_600) +
                                    Text(String(format:" x %.0f",value.quantity)).foregroundColor(color.orange_brand_900)
                                }
                            }
                        }
                    }
                    
                }
                .font(.system(size: 12,weight: .regular))
                .lineLimit(0)
                .frame(maxWidth: .infinity,alignment: .leading)
          
            }

            
            if data.presentNote{
                HStack{
                    Image("icon-doc-text.fill", bundle: .main)
                        .resizable()
                        .frame(width: 18,height: 18)
                        .foregroundColor(.orange)
                    
                    Text(item.note)
                        .font(.subheadline)
                    
                }
            }
            
           
            if data.presentGift{
                HStack{
                    Image(systemName: "gift.fill").frame(width: 16,height: 16)
                        .foregroundColor(.orange)
                    Text("Trị giá:")
                        .font(.subheadline)
                    Text((item.price * item.quantity).toString)
                        .font(.subheadline)
                        .foregroundColor(.orange)
                }
                
            }
            
        
            Text(item.status.description)
                .font(font.b_12)
                .foregroundColor(item.status.fgColor)
        }
        
    }
    

  
    
    private var actionView: some View{
        
        HStack(alignment:.center,spacing:0){
            
            VStack(alignment:.center,spacing: 0){
            
                Text(item.discount_amount > 0 ? data.discountedPrice : data.totalPrice)
                    .foregroundColor(color.gray_600)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                
                if data.presentDiscountAmount{
                    
                    if item.discount_amount > 0{
                        
                        Text(data.totalPrice){ $0.strikethroughStyle = .single}
                            .foregroundColor(color.gray_600)
        
                    }else{
                        Text(data.totalPrice)
                            .foregroundColor(color.gray_600)
                        
                    }
        
                }
                
                HStack {
                    if data.presentActionView{
                        
                        QuantityView(width: 25,height:25, quantity: $item.quantity){(type,quantity) in
                            
                            dLog(quantity)
                            
                            switch type{
                                case .minus:
                                    item.setQuantity(quantity: item.quantity - (item.is_sell_by_weight == ACTIVE ? 0.01 : 1))
                                    
                                case .plus:
                                    
                                    item.setQuantity(quantity: item.quantity + (item.is_sell_by_weight == ACTIVE ? 0.01 : 1))
                                
                                default:
                                    break
                                
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .font(font.r_14)
                        .foregroundColor(color.red_600)
 
                    }else{
                        Text("Số lượng:"){ $0.font = Font.system(size: 14)}
                        Text(item.quantity.toString) { $0.foregroundColor = .red }
                    }
                    
                }

            }
            .font(font.r_12)
            .frame(maxWidth: .infinity,alignment:.center)
            .padding(.trailing,5)
            
            if item.status != .cancel{
                handDrawer
                    .frame(maxWidth:6,maxHeight: .infinity)
                    .cornerRadius(6, corners: [.bottomLeft,.topLeft])
            }
        }
        
    }
    
    private var handDrawer: some View {
        
        switch item.status {
            case .pending:
                return color.gray_600
            
            case .cooking:
                return color.blue_brand_700
                
            case .done:
            
                if item.category_type == .buffet_ticket{
                    return color.blue_brand_700
                }else{
                    return item.buffet_ticket_id ?? 0 > 0 ? color.red_600 : color.green_600
                }
                

            case .not_enough:
                return color.red_600
            
            case .cancel:
                return color.red_600
            
            case .servic_block_using:
                return color.blue_brand_700
            
            case .servic_block_stopped:
                return color.blue_brand_700
        }

           
    }
    
}
