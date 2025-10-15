//
//  InvoiceCell.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 29/9/25.
//

import SwiftUI

struct OrderHistoryCell: View {
    @Injected(\.colors) private var color
    @Injected(\.fonts) private var font
    @Binding var order:Order
    
  
    
    var body: some View {
        HStack(alignment:.top){
            
            VStack(alignment: .leading,spacing:5){
            
                VStack{
                    Text(order.order_status.description.uppercased()).font(font.b_13)
                }
                .frame(maxWidth: .infinity)
                .padding(8)
                .foregroundColor(order.order_status.fgColor)
                .background(order.order_status.bgColor)
                .cornerRadius(5)
                
               
                VStack{
                    Text(String(format: "%@%@",order.order_method.prefix ,order.table_name))
                        .font(.headline)
                        .fontWeight(.bold)
                     
                    Text(order.table_merge_list_name.joined(separator: ",")).font(font.m_13).foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(order.order_status.fgColor)
                .padding()
                .background(order.order_status.bgColor)
                .cornerRadius(8)
                
            }
            .frame(maxWidth: .infinity)
            
            VStack (alignment:.leading,spacing: 10){
                
                Text(String(order.total_amount.toString))
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(order.order_status.fgColor)
                    .frame(maxWidth: .infinity, alignment: .trailing)
              
                HStack(spacing: 4) {
                    Image(systemName: "doc.text").foregroundColor(.gray)
                    Text(String(format: "#%d", order.id_in_branch)).font(font.r_12)
                   
                }
                
                HStack(spacing: 4) {
                    Image(systemName:"calendar").foregroundColor(.gray)
                    Text(order.payment_date ?? "").font(font.r_12)
                }
                
                HStack(spacing: 4) {
                    Image(systemName: "person.2").foregroundColor(.gray)
                    Text(order.employee?.name ?? "").font(font.r_12)
                }
                
            }.frame(maxWidth: 150)

        }
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
            let invoice = try JSONDecoder().decode(Order.self, from: jsonData)
            
            return OrderHistoryCell(order: .constant(invoice))
        } catch {
          
            return Text("Failed to decode JSON: \(error.localizedDescription)")
        }
    }
    return EmptyView()
  
    
}



