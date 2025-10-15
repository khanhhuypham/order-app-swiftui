//
//  GeneralReportView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 03/09/2024.
//

import SwiftUI
import Charts




struct GeneralReportView: View {
    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color
    @StateObject var viewModel = GeneralReportViewModel()
    var body: some View {
        
        VStack{
            HStack(spacing:8){
                
                LogoImageView(imagePath: Constants.branch.image_logo ?? "",mold:.square)
                
                VStack(alignment:.leading,spacing: 4){
                    
                    Text(Constants.branch.name).font(font.b_16)
                    
                    Text(Constants.branch.address).font(font.r_11)
                }
                
                Spacer()
            }.padding(.horizontal,10)
            
            
            ScrollView{
                
                Rectangle()
                    .frame(height: 10) // makes the line itself 8pt thick
                    .foregroundColor(color.gray_200)
                
                ReportOfDailyOrder(viewModel: viewModel)
                
                Rectangle()
                    .frame(height: 10) // makes the line itself 8pt thick
                    .foregroundColor(color.gray_200)
                
                ReportOfDailyRevenue(viewModel: viewModel)
                
                
                Rectangle()
                    .frame(height: 10) // makes the line itself 8pt thick
                    .foregroundColor(color.gray_200)
                
                ReportOfSale(viewModel: viewModel)
                
                
                Rectangle()
                    .frame(height: 10) // makes the line itself 8pt thick
                    .foregroundColor(color.gray_200)
                
                ReportOfRevenueFeeProfit(viewModel: viewModel)
                
                Rectangle()
                    .frame(height: 10) // makes the line itself 8pt thick
                    .foregroundColor(color.gray_200)
                
                ReportOfRevenueOfArea(viewModel: viewModel)
                
                
                Rectangle()
                    .frame(height: 10) // makes the line itself 8pt thick
                    .foregroundColor(color.gray_200)
                
                ReportOfRevenueOfTable(viewModel: viewModel)
                
                Rectangle()
                    .frame(height: 10) // makes the line itself 8pt thick
                    .foregroundColor(color.gray_200)
                
                ReportOfEmployeeRevenue(viewModel: viewModel)
                
                Rectangle()
                    .frame(height: 10) // makes the line itself 8pt thick
                    .foregroundColor(color.gray_200)
                
                ReportOfCategoryRevenue(viewModel: viewModel)
                
                Rectangle()
                    .frame(height: 10) // makes the line itself 8pt thick
                    .foregroundColor(color.gray_200)
                
                ReportOfFoodRevenue(viewModel: viewModel)
                
                Rectangle()
                    .frame(height: 10) // makes the line itself 8pt thick
                    .foregroundColor(color.gray_200)
            }
        }
    }
}


#Preview {
    GeneralReportView()
}
