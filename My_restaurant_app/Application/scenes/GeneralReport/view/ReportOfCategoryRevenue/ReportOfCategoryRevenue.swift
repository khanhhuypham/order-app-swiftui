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

struct ReportOfCategoryRevenue: View {
    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color
    @ObservedObject var viewModel:GeneralReportViewModel

    
    var body: some View {
        
        VStack{
        
            VStack(alignment:.leading){
                
                HStack{
                    HStack{
                        Image("", bundle: .main)
                        
                        Text("DOANH THU THEO DOANH MỤC")
                            .font(font.m_14)
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
            .frame(height:35)
            
            Divider()
            
            BtnGroupOfReportType{id in
             
                var report = viewModel.categoryRevenueReport
                report.reportType = id
                report.dateString = Constants.REPORT_TYPE_DICTIONARY[id] ?? ""

                viewModel.categoryRevenueReport.data.removeAll()
                Task{
                    await viewModel.getReportRevenueByCategory(report: report)
                }
            }.padding(.horizontal,5)

            Divider()
            
            HStack{
                PieChart(
                    data: viewModel.categoryRevenueReport.data.enumerated().map { index, item in
                        .init(x: item.category_name, y: Double(item.total_amount),color: item.color)
                    },
                    addLegend: false
                )
                .frame(maxWidth:.infinity)
                .padding(.vertical, 20)
                
                
                VStack{
                    
                    VStack(alignment:.leading){
                        Text("TỔNG DOANH THU")
                            .font(font.m_14)
                        
                        Text(viewModel.categoryRevenueReport.total_amount.toString)
                            .font(font.sb_14)
                            .foregroundColor(color.green_600)
                    }
                    
                    List{
                        ForEach(viewModel.categoryRevenueReport.data, id: \.category_id){ item in
                            HStack{
                                HStack{
                                    Circle().foregroundColor(item.color).frame(width: 20, height: 20)
                                    
                                    Text(item.category_name)
                                        .font(font.r_14)
                                        .foregroundColor(.black)
                                }
                              
                                Spacer()
                                Text(String(format: "%.2f%%",
                                    (Double(item.total_amount) / Double(viewModel.categoryRevenueReport.total_amount)) * 100
                                ))
                                .font(font.r_14)
                                .foregroundColor(.black)

                            }
                        }
                    }
                    .background(.white)
                    .frame(width:180)
                    .listStyle(.plain)
                }
                
            }
            .frame(height:200)
            
           
            
        }
        .task{
            await viewModel.getReportRevenueByCategory(report: viewModel.categoryRevenueReport)
        }
    }
    
 
}



