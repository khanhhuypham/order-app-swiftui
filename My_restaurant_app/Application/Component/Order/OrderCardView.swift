//
//  OrderCardView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 09/09/2024.
//

import SwiftUI

struct OrderCardView: View {
    @Injected(\.colors) private var color
    @Injected(\.fonts) private var font
    @Binding var order:Order
    @State private var isActive = false
    
    
    var btnClosure:((Int?) -> Void)? = nil
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    

    var body: some View {
        Button(action: {

            if order.order_status == .waiting_complete{
                isActive = false
            }else{
                isActive = true
            }
        }, label: {
            
            HStack(alignment:.top){
                
                VStack(alignment: .leading,spacing:5){
                    
              
                    VStack{
                        
                        Text(order.order_status.description.uppercased()).font(font.b_13)

                        if let booking_id = order.booking_infor_id,booking_id > 0{
                            
                            Text("Booking").font(font.r_12)
                            
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .foregroundColor(order.order_status.fgColor)
                    .background(order.order_status.bgColor)
                    .cornerRadius(5)
                    .overlay(
                        
                        Text(order.order_detail_pending_quantity.description)
                            .font(font.sb_12)
                            .frame(width: 30,height: 18)
                            .foregroundColor(.white)
                            .background(color.red_600)
                            .cornerRadius(5)
                            .offset(x: -5, y: -10)
                            .isHidden(order.order_detail_pending_quantity == 0)
                        
                        ,alignment: .topLeading
                    )
                   
                    VStack{
                        Text(String(format: "%@%@",order.order_method.prefix ,order.table_name))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                         
                        Text(order.table_merge_list_name.joined(separator: ",")).font(font.m_13).foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(order.order_status.fgColor)
                    .padding()
                    .background(order.order_status.bgColor)
                    .cornerRadius(8)
                    
                 
                    
                    if order.order_status != .waiting_complete && (order.order_method == .EAT_IN || order.order_method == .TAKE_AWAY){
                        // Bottom Icon Buttons
                        HStack(spacing: 5) {
                            
                            Button(action: {
                                btnClosure?(1)
                            }) {
                                
                                Image("icon-three-dot", bundle: .main)
                                    .padding(8)
                                    .frame(maxWidth: .infinity)
                            }
                            .foregroundColor(order.order_status.fgColor)
                            .background(order.order_status.bgColor)
                            .cornerRadius(5)
                            .disabled(order.booking_status == .status_booking_setup)
                            
                            
                            
                            Button(action: {
                                btnClosure?(2)
                            }) {
                                
                                Image("icon-gift", bundle: .main)
                                    .padding(8)
                                    .frame(maxWidth: .infinity)
                            }
                            .foregroundColor(order.order_status.fgColor)
                            .background(order.order_status.bgColor)
                            .cornerRadius(5)
                            .disabled(order.booking_status == .status_booking_setup)
                            
                            
                            Button(action: {
                                btnClosure?(3)
                            }) {
                                Image("icon-document-with-stick", bundle: .main)
                                    .padding(8)
                                    .frame(maxWidth: .infinity)
                                
                            }
                            .foregroundColor(order.order_status.fgColor)
                            .background(order.order_status.bgColor)
                            .cornerRadius(5)
                            
                            
                            if PermissionUtils.GPQT_2_and_above{
                                
                                Button(action: {
                                    btnClosure?(4)
                                }) {
                                    Image("icon-scanner", bundle: .main)
                                        .padding(8)
                                        .frame(maxWidth: .infinity)
                                    
                                }
                                .foregroundColor(order.order_status.fgColor)
                                .background(order.order_status.bgColor)
                                .cornerRadius(5)
                                .disabled(order.booking_status == .status_booking_setup)
                            }
                            
                            
                            
                            if  (PermissionUtils.GPBH_2 || PermissionUtils.GPBH_3) && Constants.brand.setting?.payment_type == .pay_os{
                                Button(action: {
                                    btnClosure?(5)
                                }) {
                                    Image("icon-qr-code", bundle: .main)
                                        .padding(8)
                                        .frame(maxWidth: .infinity)
                                    
                                }
                                .foregroundColor(order.order_status.fgColor)
                                .background(order.order_status.bgColor)
                                .cornerRadius(5)
                            }
                            
                        }
                        .frame(height:35)
                        .frame(maxWidth:.infinity,alignment:.leading)
                    }
                    
                }
                .frame(maxWidth: .infinity)
                
                VStack (alignment:.leading,spacing: 10){
                    
                    Text(String(order.total_amount.toString))
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(order.order_status.fgColor)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                  
                    HStack(spacing: 4) {
                        Image(systemName: "doc.text")
                            .foregroundColor(.gray)
                        Text(String(format: "#%d", order.id_in_branch))
                            .font(.caption)
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .foregroundColor(.gray)
                        Text(order.using_time_minutes_string)
                            .font(.caption)
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "person.2").foregroundColor(.gray)
                        TextField("", value: $order.using_slot, formatter: formatter)
                            .keyboardType(.numberPad)
                            .font(font.r_12)
                            .multilineTextAlignment(.center)
                            .frame(width: 40, height: 25)
                            .background(order.order_status.bgColor)
                            .overlay(
                              RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 0.5)
                                .foregroundColor(order.order_status.fgColor)
                            )
                            .shadow(color: Color.gray.opacity(0.1),radius: 3, x: 1, y: 2)
                           
                    }
                    
                }.frame(maxWidth: 120)

            }
        })
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.gray.opacity(0.3), radius: 8, x: 0, y: 4)
    }
}


#Preview {
    var jsonString = """
        {
            "id": 418007,
            "note": "",
            "restaurant_id": 165,
            "restaurant_brand_id": 154,
            "branch_id": 626,
            "area_id": 0,
            "customer_id": 0,
            "order_id_server": 418007,
            "table_id": 0,
            "table_name": "1",
            "table_merged_names": [],
            "total_amount": 1500,
            "created_at": "13/01/2024 14:00",
            "using_slot": 1,
            "using_time_minutes": 345470,
            "using_time_minutes_string": "5757:50",
            "order_status": 4,
            "is_share_point": 0,
            "is_online": 0,
            "is_take_away": 1,
            "is_return_deposit": 0,
            "total_order_detail_customer_request": 0,
            "booking_infor_id": 0,
            "branch_address": "303 Phạm Văn Đồng, Phường 01, Quận Gò Vấp, Thành Phố Hồ Chí Minh",
            "is_allow_request_payment": 0,
            "deposit_amount": 0,
            "employee_target_revenue_per_customer": 0,
            "employee_id": 2308,
            "booking_status": 0,
            "wireless_call_system_number": 0,
            "total_amount_avg_per_customer": 1500.0000,
            "booking_infor_id": 2,
            "buffet_ticket_id": 0
        }
    """
    
    if let jsonData = jsonString.data(using: .utf8) {
        do {
            // Decode the JSON into a User instance
            let order = try JSONDecoder().decode(Order.self, from: jsonData)
            
            return OrderCardView(order: .constant(order))
        } catch {
          
            return Text("Failed to decode JSON: \(error.localizedDescription)")
        }
    }
    return EmptyView()
  
    
}



