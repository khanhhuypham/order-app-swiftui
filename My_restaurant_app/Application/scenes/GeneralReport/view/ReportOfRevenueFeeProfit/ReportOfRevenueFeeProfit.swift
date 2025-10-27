//
//  ReportOfSale.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 7/10/25.
//

import SwiftUI

struct ReportOfRevenueFeeProfit: View {
    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color
    @ObservedObject var viewModel:GeneralReportViewModel
    var body: some View {
        
        
        VStack{
        

            VStack(alignment:.leading){
                
                HStack{
                    Image("", bundle: .main)
                    
                    Text("DOANH THU, CHI PHÍ, LỢI NHUẬN")
                        .font(font.m_14)
                  
                }
                
                Divider()
                
                BtnGroupOfReportType{id in
                    var report = viewModel.revenueCostProfitReport
                    report.reportType = id
                    report.dateString = Constants.REPORT_TYPE_DICTIONARY[id] ?? ""
                    viewModel.saleReport.data.removeAll()
                    Task{
                        await viewModel.reportRevenueCostProfit(report: report)
                    }
                }.padding(.horizontal,5)
                
                Divider()
                
                HStack{
                    Text("Doanh thu")
                    Spacer()
                    Text(viewModel.revenueCostProfitReport.total_revenue_amount.toString)
                      
                }
                .foregroundColor(color.green_600)
                
                Divider()
                
                HStack{
                    Text("Chi phí")
                    Spacer()
                    Text(viewModel.revenueCostProfitReport.total_cost_amount.toString)
                       
                }
                .foregroundColor(color.red_600)
                
                Divider()
                
                HStack{
                    Text("Lợi nhuận")
                    Spacer()
                    Text(viewModel.revenueCostProfitReport.total_profit_amount.toString)
                }
                .foregroundColor(color.orange_brand_900)
            }
            .font(font.r_14)
            .foregroundColor(color.gray_600)
            
            Divider()
            
//            BarChart(data: [])
//                .padding(.top,20)
//                .frame(height: 180)
//            
            BarChart(data: [
                BarChartData(x:"Doanh thu", y:Double(viewModel.revenueCostProfitReport.data.first?.total_revenue_amount ?? 0),color:color.green_600),
                BarChartData(x:"Chi phí", y:Double(viewModel.revenueCostProfitReport.data.first?.total_cost_amount ?? 0),color:color.blue_brand_700),
                BarChartData(x:"Lợi nhuận", y:Double(viewModel.revenueCostProfitReport.data.first?.total_profit_amount ?? 0),color:color.orange_brand_900)
            ])
            .padding(.top,20)
            .frame(height: 180)
            
            
        }
        .task{
            await viewModel.reportRevenueCostProfit(report: viewModel.revenueCostProfitReport)
      
        }
    }

}
