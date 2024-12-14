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
                LogoImageView(imagePath: item.avatar,mold:.square)
                    .frame(width: 40).frame(height: 40)
                
                mainContent
                    .frame(maxWidth: .infinity,alignment: .leading)
            }
            .padding(.vertical,15)
            
        
            actionView.frame(width: 115)
        }
        
        .background(item.status.bgColor)
        .onAppear(perform: {
            
//            data.totalPrice = (item.order_detail_additions.count > 0 ? Double(item.total_price_include_addition_foods) : item.total_price).toString
            
            data.discountedPrice = item.discount_price.toString
            _ = item.service_time_used
            _ = TimeUtils.getSecondSFromDateString(dateString: item.service_end_time ?? "")
            
            data.presentChilrenItem = !item.order_detail_additions.isEmpty || !item.order_detail_combo.isEmpty

            data.presentNote = item.note.isEmpty ? false : true

            data.presentDiscountView = item.discount_percent == 0 ? false : true
            
            data.presentDiscountAmount = false

            data.presentGift = item.is_gift ? false : true

            data.presentActionView = item.status == .pending ? true : false
            
            if(item.is_gift){
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
             
            
            if item.discount_percent > 0{
                HStack{
                    Image("icon-discount.fill",bundle:.main)
                        .resizable()
                        .frame(width: 20,height: 16)
                  
                    Text(String(format: "Giảm giá: %d%%", item.discount_percent))
                        .font(font.r_11)
        
                }.foregroundColor(color.blue_brand_700)
            }
          
            if !item.children.isEmpty{
                
                VStack(alignment:.leading,spacing:0){
                    
                    if item.children.count > 0 {
                        
                        Text("[Món bán kèm]"){ $0.foregroundColor = ColorUtils.orange_brand_900()}
                        ForEach(Array(item.children.enumerated()), id: \.element.id) { (i,value) in
                            Group{
                                Text(String(format:"+ %@",value.name)){$0.foregroundColor = ColorUtils.gray_600()} +
                                Text(String(format:" x %.0f",value.quantity)){ $0.foregroundColor = ColorUtils.orange_brand_900()} +
                                Text(" = " + value.price.toString){ $0.foregroundColor = ColorUtils.gray_600()}
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
                    
                }
                .font(.system(size: 12,weight: .regular))
                .lineLimit(0)
                .multilineTextAlignment(.leading)
            }

            
            
            if !item.note.isEmpty{
                HStack{
                    Image("icon-doc-text.fill", bundle: .main)
                        .resizable()
                        .frame(width: 18,height: 18)
                        .foregroundColor(.orange)
                    
                    Text(item.note)
                        .font(.subheadline)
                    
                }
            }
            
           
            if item.is_gift{
                HStack{
                    Image(systemName: "gift.fill").frame(width: 16,height: 16)
                        .foregroundColor(.orange)
                    Text("Trị giá:")
                        .font(.subheadline)
                    Text((item.price * Double(item.quantity)).toString)
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
            
             
                if item.discount_amount > 0{
                
                    VStack{
                        
                        Text(item.discount_amount.toString)
                            .foregroundColor(color.gray_600)
                           
                        
                        Text(item.price.toString){ $0.strikethroughStyle = .single}
                            .font(font.r_13)
                            .foregroundColor(color.gray_600)
                    }
                    .font(font.m_16)
                    .frame(maxWidth: .infinity, alignment: .center)
    
                }else{
                    Text(item.price.toString)
                        .foregroundColor(color.gray_600)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(font.m_15)
                }
        
                
                
                HStack {
                    if item.status == .pending && !item.is_gift{
                     
                        Button(action: {
                            (self.onDecrease ?? {})()
                        }, label: {
                            Text("-").font(.system(size: 30,weight: .medium))
                                .frame(width: 30,height: 30)
                        })
                        .foregroundColor(.white)
                        .background(.gray)
                        .cornerRadius(5)
    
                        TextField("0",value:$item.quantity,format: .number)
                            .keyboardType(.numberPad)
                            .foregroundColor(color.red_600)
                            .font(font.r_14)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth:.infinity)
    
                        Button(action: {
                            (self.onIncrease ?? {})()
                        }, label: {
                            Text("+")
                                .font(font.m_16)
                                .frame(width: 30,height: 30)
                        })
                        .foregroundColor(.white)
                        .background(.gray)
                        .cornerRadius(5)
                        
                    }else{
                        Text("Số lượng:")
                            .font(font.r_15)
                        
                        Text(item.quantity.toString)
                            .font(font.r_15)
                            .foregroundColor(.red)
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
