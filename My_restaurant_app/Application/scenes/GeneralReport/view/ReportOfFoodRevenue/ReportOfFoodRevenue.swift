//
//  ReportOfEmployeeRevenue.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 10/10/25.
//


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

struct ReportOfFoodRevenue: View {
    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color
    @ObservedObject var viewModel:GeneralReportViewModel

    
    var body: some View {
        
        VStack{
        
            VStack(alignment:.leading){
                
                HStack{
                    Image("", bundle: .main)
                    
                    VStack(alignment:.leading){
                        Text("DOANH THU MÓN ĂN")
                            .font(font.m_14)
                        
                        Text(viewModel.foodReport.total_amount.toString)
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
             
                var report = viewModel.foodReport
                report.reportType = id
                report.dateString = Constants.REPORT_TYPE_DICTIONARY[id] ?? ""
                viewModel.foodReport.data.removeAll()
                Task{
                    await viewModel.getFoodReport(report: report)
                }
                
            }.padding(.horizontal,5)

            Divider()
            
          
            BarChart(data: viewModel.foodReport.data.enumerated().map{(i,value) in
                let x = String(value.food_name.count <= 15 ? value.food_name : value.food_name.prefix(15) + "...")
                let y = Double(value.total_amount)
                return BarChartData(x:x, y:y)
            },scrollabel: true)
            .frame(height: 180)
            .padding(.vertical,10)
        }
        .task{
            await viewModel.getFoodReport(report: viewModel.foodReport)
        }
    }
    
 
}



