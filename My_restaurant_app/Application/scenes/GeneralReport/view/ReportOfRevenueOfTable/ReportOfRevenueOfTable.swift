//
//  ReportOfRevenueOfArea.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 7/10/25.
//


import SwiftUI

struct ReportOfRevenueOfTable: View {
    
    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color
    @ObservedObject var viewModel:GeneralReportViewModel


    var body: some View {
        
        VStack{
        
            VStack(alignment:.leading){
                
                HStack{
                    Image("", bundle: .main)
                    
                    VStack(alignment:.leading){
                        Text("BÁO CÁO DOANH THU BÀN")
                            .font(font.m_14)
                        
                        Text(viewModel.tableRevenueReport.total_revenue.toString)
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
                var report = viewModel.tableRevenueReport
                report.reportType = id
                report.dateString = Constants.REPORT_TYPE_DICTIONARY[id] ?? ""
                viewModel.tableRevenueReport.data.removeAll()
                Task{
                    await viewModel.getReportTableRevenue(report: report)
                }
            }.padding(.horizontal,5)
            
            Divider()
            
            PieChart(
                data: viewModel.tableRevenueReport.data.enumerated().map { index, item in
                    .init(x: item.table_name, y: Double(item.revenue),color: item.color)
                },
                addLegend: false
            )
            .padding(.vertical, 20)
            
            
            BarChart(data:viewModel.tableRevenueReport.data.enumerated().map{(i,value) in
                return BarChartData(x:value.table_name, y:Double(value.revenue),color: value.color)
            },scrollabel: true, visibleColumn:8)
            .padding(.vertical,20)
            .frame(height: 180)
            
      
            
            ForEach(Array(viewModel.tableRevenueReport.data.enumerated()), id: \.element.table_id) { index, data in
                
                Divider()
                
                HStack {
                    HStack {
                        Text(String(index + 1)) // 👈 Show index starting from 1
                            .foregroundColor(.white)
                            .padding(8)
                            .background(data.color)
                            .clipShape(Circle())
                        
                        Text(data.table_name)
                    }
                    
                    Spacer()
                    
                    // 👇 Fix your percentage string too
                    Text(String(format: "%.2f%%", (Double(data.revenue) / Double(viewModel.tableRevenueReport.total_revenue)) * 100))
              
                    
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
            await viewModel.getReportTableRevenue(report: viewModel.tableRevenueReport)
        }
 
    
    }
}
