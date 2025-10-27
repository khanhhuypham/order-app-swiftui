//
//  ReportOfRevenueFeeProfit.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 7/10/25.
//


import SwiftUI

struct ReportOfRevenueOfArea: View {
    
    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color
    @ObservedObject var viewModel:GeneralReportViewModel
    var body: some View {
        
        VStack{
            
            VStack(alignment:.leading){
                
                HStack{
                    Image("", bundle: .main)
                    
                    VStack(alignment:.leading){
                        Text("BÁO CÁO DOANH THU KHUC VỰC")
                            .font(font.m_14)
                        
                        Text(viewModel.areaRevenueReport.total_revenue_amount.toString)
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
                
            }
            .font(font.r_14)
            .foregroundColor(color.gray_600)
            
            Divider()
            
            BtnGroupOfReportType{id in
                var report = viewModel.areaRevenueReport
                report.reportType = id
                report.dateString = Constants.REPORT_TYPE_DICTIONARY[id] ?? ""
                viewModel.areaRevenueReport.data.removeAll()
                Task{
                    await viewModel.getReportAreaRevenue(report: report)
                }
            }.padding(.horizontal,5)
            
            Divider()
            
            
            PieChart(
                data: viewModel.areaRevenueReport.data.enumerated().map { index, item in
                    .init(x: item.area_name, y: Double(item.revenue),color: item.color)
                }
            )
            .padding(.vertical, 20)
            
            
            BarChart(data:viewModel.areaRevenueReport.data.enumerated().map{(i,value) in
                return BarChartData(x:value.area_name, y:Double(value.revenue),color: value.color)
            })
            .padding(.vertical,20)
            .frame(height: 180)
            
        
            ForEach(Array(viewModel.areaRevenueReport.data.enumerated()), id: \.element.area_id) { index, data in
                
                Divider()
                
                HStack {
                    HStack {
                        Text(String(index + 1)) // 👈 Show index starting from 1
                            .foregroundColor(.white)
                            .padding(8)
                            .background(data.color)
                            .clipShape(Circle())
                        
                        Text(data.area_name)
                    }
                    
                    Spacer()
                    
                    // 👇 Fix your percentage string too
                    Text(String(format: "%.0f%%", (Double(data.revenue) / Double(viewModel.areaRevenueReport.total_revenue_amount)) * 100))
              
                    
                    Spacer()
                    
                    Text(data.revenue.toString)
                        .foregroundColor(color.green_600)
                }
                .font(font.m_14)
                .padding(.vertical,5)
                .frame(maxHeight:.infinity)
            
            }

        
        }
        .task{
            await viewModel.getReportAreaRevenue(report: viewModel.areaRevenueReport)
      
        }
    }
    

}
