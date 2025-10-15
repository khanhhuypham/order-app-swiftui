//
//  ReportOfSale.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 10/10/25.
//


//
//  ReportOfDailyOrder.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 7/10/25.
//

import SwiftUI

struct ReportOfEmployeeRevenue: View {
    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color
    @ObservedObject var viewModel:GeneralReportViewModel

    
    var body: some View {
        
        VStack{
        
            VStack(alignment:.leading){
                
                HStack{
                    Image("", bundle: .main)
                    
                    VStack(alignment:.leading){
                        Text("DOANH THU NHÂN VIÊN")
                            .font(font.m_14)
                        
                        Text(viewModel.employeeRevenueReport.total_revenue.toString)
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
             
                var report = viewModel.employeeRevenueReport
                report.reportType = id
                report.dateString = Constants.REPORT_TYPE_DICTIONARY[id] ?? ""

                viewModel.employeeRevenueReport.data.removeAll()
                viewModel.getReportEmployeeRevenue(report: report)
            }.padding(.horizontal,5)

            Divider()
            
          
            BarChart(data: viewModel.employeeRevenueReport.data.enumerated().map{(i,value) in
                let x = String(value.employee_name.count <= 15 ? value.employee_name : value.employee_name.prefix(15) + "...")
                let y = Double(value.revenue)
                return BarChartData(x:x, y:y)
            },scrollabel: true)
            .frame(height: 180)
            .padding(.vertical,10)
            
        }
        .onAppear{
            viewModel.getReportEmployeeRevenue(report: viewModel.employeeRevenueReport)
        }
    }
    
 
}



