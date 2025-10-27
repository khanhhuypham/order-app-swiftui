//
//  ReportOfDailyOrder.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 7/10/25.
//

import SwiftUI


struct ReportOfDailyOrder: View {
    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color
    @ObservedObject var viewModel:GeneralReportViewModel
    var body: some View {
        
        VStack(alignment:.leading){
            HStack{
                Image("icon-doc-text", bundle: .main)
                    .resizable()
                    .frame(width: 25, height: 25)
                Text("ĐƠN HÀNG HÔM NAY")
            }
            
            Divider()
            
            HStack{
                Text("Đã thanh toán")
                    .font(font.r_16)
                Spacer()
                Text(viewModel.dailyOrderReport.order_served.toString)
                    .font(font.sb_16)
                    .foregroundColor(color.green_600)
            }
            
            Divider()
            
            HStack{
                Text("Đang phục vụ")
                    .font(font.r_16)
                
                Spacer()
                
                Text(viewModel.dailyOrderReport.order_serving.toString)
                    .font(font.sb_16)
                    .foregroundColor(color.blue_brand_700)
            }
        }
        .foregroundColor(color.gray_600)
        .task{
            await viewModel.getDailyReport()
      
        }
 
    
    }
}


//#Preview {
//    ReportOfDailyOrder()
//}
