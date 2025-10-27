//
//  ReportOfDailyOrder.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 7/10/25.
//

import SwiftUI

struct ReportOfSale: View {
    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color
    @ObservedObject var viewModel:GeneralReportViewModel

    
    var body: some View {
        
        VStack{
        
            VStack(alignment:.leading){
                
                HStack{
                    Image("", bundle: .main)
                    
                    VStack(alignment:.leading){
                        Text("DOANH THU BÁN HÀNG")
                            .font(font.m_14)
                        
                        Text(viewModel.saleReport.total_revenue.toString)
                            .font(font.sb_18)
                            .foregroundColor(color.blue_brand_700)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                       
                    }){
                        
                        HStack{
                            Text("Xem chi tiết")
                            Image(systemName: "chevron.right")
                        }.foregroundColor(color.blue_brand_700)
                  
                    }
                }
                
            }
            .font(font.r_14)
            .foregroundColor(color.gray_600)
            
            Divider()
            
            BtnGroupOfReportType{id in
             
                var report = viewModel.saleReport
                report.reportType = id
                report.dateString = Constants.REPORT_TYPE_DICTIONARY[id] ?? ""
                viewModel.saleReport.data.removeAll()
                Task{
                    await viewModel.getReportRevenueGenral(report: report)
                }
            }.padding(.horizontal,5)

            Divider()
            
          
            BarChart(data: viewModel.saleReport.data.enumerated().map{(i,value) in
                let x = ChartUtils.getXLabel(dateTime: value.report_time, reportType: viewModel.saleReport.reportType, dataPointnth:i)
                let y = Double(value.total_revenue)
                return BarChartData(x:x, y:y)
            },scrollabel: true)
            
        }
        .task{
            await viewModel.getReportRevenueGenral(report: viewModel.saleReport)
        }
    }
    
 
}



