//
//  ReportOfDailyOrder.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 7/10/25.
//


//
//  ReportOfDailyOrder.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 7/10/25.
//

import SwiftUI


struct ReportOfDailyRevenue: View {
    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color
    @ObservedObject var viewModel:GeneralReportViewModel
    var body: some View {
        
        VStack{
            DailyRevenueCollectionReport
            
            Rectangle()
                .frame(height: 10) // makes the line itself 8pt thick
                .foregroundColor(color.gray_200)
            
            TemporaryTodayRevenueReport
        }
        .onAppear{
            viewModel.getTodayRevenueReport()
            viewModel.getDailyRevenueReportOfFoodApp()
        }
    }
    
    private var DailyRevenueCollectionReport:some View{
        VStack(alignment:.leading){
            
            HStack{
                Image("icon-coins", bundle: .main)
                    .resizable()
                    .frame(width: 25, height: 25)
                
                VStack(alignment:.leading){
                    Text("TIỀN THU TRONG NGÀY")
                    Text(viewModel.dailyOrderReport.total_amount.toString)
                        .font(font.sb_18)
                        .foregroundColor(color.blue_brand_700)
                }
              
            }
            
            Divider()
            
            HStack{
                Text("Bán hàng")
                    .font(font.r_14)
                Spacer()
                
                Text("0")
                    .font(font.r_14)
                    .foregroundColor(color.blue_brand_700)
            }
            
            Divider()
            
            HStack{
                Text("Tiền mặt")
                    .font(font.r_14)
                    .padding(.leading,16)
                Spacer()
                
                Text(viewModel.dailyOrderReport.cash_amount.toString)
                    .font(font.sb_14)
                    .foregroundColor(color.blue_brand_700)
            }
            
            Divider()
            
            HStack{
                Text("Tiền thẻ")
                    .font(font.r_14)
                    .padding(.leading,16)
                Spacer()
                
                Text(viewModel.dailyOrderReport.bank_amount.toString)
                    .font(font.sb_14)
                    .foregroundColor(color.blue_brand_700)
            }
            
            Divider()
            
            HStack{
                Text("Chuyển khoản")
                    .font(font.r_14)
                    .padding(.leading,16)
                Spacer()
                
                Text(viewModel.dailyOrderReport.transfer_amount.toString)
                    .font(font.sb_14)
                    .foregroundColor(color.blue_brand_700)
            }
            
            Divider()
            
            HStack{
                Text("Sử dụng điểm")
                    .font(font.r_14)
                Spacer()
                
                Text(viewModel.dailyOrderReport.revenue_paid.toString)
                    .font(font.r_14)
                    .foregroundColor(color.blue_brand_700)
            }
            
            Divider()
            
            HStack{
                Text("Khách đặt cọc")
                    .font(font.r_14)
                Spacer()
                
                Text(viewModel.dailyOrderReport.deposit_amount.toString)
                    .font(font.r_14)
                    .foregroundColor(color.blue_brand_700)
            }
            
            Divider()
            
            HStack{
                Text("Doanh thu bán hàng app food")
                    .foregroundColor(.black)
                    .font(font.sb_14)
                Spacer()
                
                Text(viewModel.foodAppReport.total_revenue_amount.toString)
                    .font(font.r_14)
                    .foregroundColor(color.blue_brand_700)
            }
            
            
            Divider()
            
            HStack{
                
                Circle()
                    .frame(width: 14,height: 14)
                    .foregroundColor(.blue)
                
                Text("GrabFood")
                    .foregroundColor(.black)
                    .font(font.r_16)
                Spacer()
                
                Text(viewModel.foodAppReport.total_amount_GRF.toString)
                    .font(font.r_14)
                    .foregroundColor(color.blue_brand_700)
            }
            
            
            Divider()
            
            HStack{
                
                Circle()
                    .frame(width: 14,height: 14)
                    .foregroundColor(.red)
                
                Text("SPFood")
                    .foregroundColor(.black)
                    .font(font.r_16)
                Spacer()
                
                Text(viewModel.foodAppReport.total_amount_SHF.toString)
                    .font(font.r_14)
                    .foregroundColor(color.blue_brand_700)
            }
            
            Divider()
            
            HStack{
                
                Circle()
                    .frame(width: 14,height: 14)
                    .foregroundColor(.orange)
                
                Text("BeeFood")
                    .foregroundColor(.black)
                    .font(font.r_16)
                
                Spacer()
                
                Text(viewModel.foodAppReport.total_amount_BEF.toString)
                    .font(font.r_14)
                    .foregroundColor(color.blue_brand_700)
            }
        }
        .foregroundColor(color.gray_600)
    }
        
    private var TemporaryTodayRevenueReport:some View{
        VStack{
    
            VStack(alignment:.leading){
                
                HStack{
                    Image("", bundle: .main)
                    
                    VStack(alignment:.leading){
                        Text("DOANH THU TẠM TÍNH HÔM NAY")
                            .font(font.m_14)
                        
                        Text((viewModel.dailyOrderReport.total_amount + viewModel.dailyOrderReport.revenue_serving).toString)
                            .font(font.sb_18)
                            .foregroundColor(color.blue_brand_700)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                       
                    }){
                        HStack{
                            Text("Xem chi tiết")
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(color.blue_brand_700)
                  
                    }
                }
                
                Divider()
                
                HStack{
                    Text("Đã thanh toán")
                    Spacer()
                    Text(viewModel.dailyOrderReport.total_amount.toString)
                        .foregroundColor(color.green_600)
                }
                
                Divider()
                
                HStack{
                    Text("Đang phục vụ (tính cả bàn mang về)")
                    Spacer()
                    Text(viewModel.dailyOrderReport.revenue_serving.toString)
                        .foregroundColor(color.blue_brand_700)
                }
            }
            .font(font.r_14)
            .foregroundColor(color.gray_600)
            
            Divider()
            
            LineChartView(data: chartData)
                .padding(.vertical,20)
                .frame(height: 180)
            
        }
    }
    
    
    var chartData : [LineChartData] = {
    
        let data: [LineChartData] = [
            .init(day: "00:00", amount: 120000),
            .init(day: "03:00", amount: 160000),
            .init(day: "06:00", amount: 90000),
            .init(day: "09:00", amount: 300000),
            .init(day: "12:00", amount: 100000),
            .init(day: "15:00", amount: 200000),
            .init(day: "18:00", amount: 111000),
            .init(day: "21:00", amount: 245000),
        ]
        
        return data
    }()
}

//
//#Preview {
//    ReportOfDailyRevenue()
//}
