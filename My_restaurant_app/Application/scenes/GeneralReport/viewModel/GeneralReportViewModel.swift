//
//  OrderDetailViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 12/09/2024.
//

import UIKit
import SwiftUI

class GeneralReportViewModel: ObservableObject {



    @Published var dailyOrderReport = DailyOrderReport.init(reportType: REPORT_TYPE_TODAY, dateString: TimeUtils.getCurrentDateTime().dateTimeNow)
    
    @Published var toDayRenueReport = RevenueReport.init(reportType: REPORT_TYPE_TODAY, dateString: TimeUtils.getCurrentDateTime().dateTimeNow)
    
    @Published var foodAppReport = FoodAppReport.init(reportType: REPORT_TYPE_TODAY, dateString: TimeUtils.getCurrentDateTime().dateTimeNow)
    
    @Published var saleReport = SaleReport.init(
        reportType: REPORT_TYPE_THIS_MONTH,
        dateString: TimeUtils.getCurrentDateTime().thisMonth,
        fromDate: TimeUtils.getToday(),
        toDate: TimeUtils.getToday()
    )
    
    @Published var revenueCostProfitReport = RevenueFeeProfitReport.init(reportType: REPORT_TYPE_THIS_MONTH, dateString: TimeUtils.getCurrentDateTime().thisMonth)
    
    
    @Published var areaRevenueReport = AreaRevenueReport.init(
        reportType: REPORT_TYPE_THIS_MONTH,
        dateString: TimeUtils.getCurrentDateTime().thisMonth,
        fromDate: TimeUtils.getToday(),
        toDate: TimeUtils.getToday()
    )
    
    
    @Published var tableRevenueReport = TableRevenueReport.init(
        reportType: REPORT_TYPE_THIS_MONTH,
        dateString: TimeUtils.getCurrentDateTime().thisMonth,
        fromDate: TimeUtils.getToday(),
        toDate: TimeUtils.getToday()
    )
    
    @Published var employeeRevenueReport = EmployeeRevenueReport.init(
        reportType: REPORT_TYPE_THIS_MONTH,
        dateString: TimeUtils.getCurrentDateTime().thisMonth,
        fromDate: TimeUtils.getToday(),
        toDate: TimeUtils.getToday()
    )
    
    
    @Published public var categoryRevenueReport = RevenueCategoryReport.init(
        reportType: REPORT_TYPE_THIS_MONTH,
        dateString: TimeUtils.getCurrentDateTime().thisMonth,
        fromDate: TimeUtils.getToday(),
        toDate: TimeUtils.getToday()
    )
    
    @Published var foodReport = FoodRevenueReport.init(
        reportType: REPORT_TYPE_THIS_MONTH,
        dateString: TimeUtils.getCurrentDateTime().thisMonth,
        fromDate: TimeUtils.getToday(),
        toDate: TimeUtils.getToday()
    )
    
    
    
    
}

extension GeneralReportViewModel{
    @MainActor
    func getDailyReport()async{
        let result:Result<APIResponse<DailyOrderReport>, Error> = await NetworkManager.callAPIResultAsync(netWorkManger: .report_revenue_activities_in_day_by_branch(
            restaurant_brand_id: Constants.brand.id,
            branch_id: Constants.branch.id,
            report_type: dailyOrderReport.reportType,
            date_string: dailyOrderReport.dateString,
            from_date: "",
            to_date: ""
        ))
        

        switch result {

            case .success(var res):
            
                if res.status == .ok, let data = res.data{
                    dailyOrderReport = data
                }
                

            case .failure(let error):
               dLog("Error: \(error)")
        }
    
    }
    
    @MainActor
    func getDailyRevenueReportOfFoodApp()async{
        let result: Result<APIResponse<FoodAppReport>, Error> = await NetworkManager.callAPIResultAsync(netWorkManger:.getDailyRevenueReportOfFoodApp(
            restaurant_id: Constants.restaurant_id,
            restaurant_brand_id: Constants.brand.id,
            branch_id: Constants.branch.id,
            food_channel_id: -1,
            date_string: foodAppReport.dateString,
            report_type: foodAppReport.reportType,
            hour_to_take_report: Constants.setting.hour_to_take_report
        ))
        
        switch result {

            case .success(var res):
            
                if res.status == .ok,let data = res.data{
                    foodAppReport = data
                }
                

            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    

    @MainActor
    func getTodayRevenueReport()async{
        let result: Result<APIResponse<RevenueReport>, Error> = await NetworkManager.callAPIResultAsync(netWorkManger:.report_revenue_by_time(
            restaurant_brand_id: Constants.brand.id,
            branch_id: Constants.branch.id,
            report_type: toDayRenueReport.reportType,
            date_string: toDayRenueReport.dateString,
            from_date: "",
            to_date: ""
        ))
       
        switch result {

            case .success(var res):
            
                if res.status == .ok,let data = res.data{
                    toDayRenueReport = data
                }
                

            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
    func getReportRevenueGenral(report:SaleReport)async{
        let result: Result<APIResponse<SaleReport>, Error> = await NetworkManager.callAPIResultAsync(netWorkManger: .getReportRevenueGenral(
            restaurant_brand_id: Constants.brand.id,
            branch_id: Constants.branch.id,
            report_type: report.reportType,
            date_string: report.dateString,
            from_date: report.fromDate,
            to_date: report.toDate
        ))
       
        switch result {

            case .success(let res):
            
                if res.status == .ok,var data = res.data{
                    data.reportType = report.reportType
                    data.dateString = report.dateString
                    data.fromDate = report.fromDate
                    data.toDate = report.toDate
           
                    saleReport = data
                }
                

            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
    @MainActor
    func reportRevenueCostProfit(report:RevenueFeeProfitReport)async{
        let result: Result<APIResponse<RevenueFeeProfitReport>, Error> = await NetworkManager.callAPIResultAsync(netWorkManger: .report_revenue_fee_profit(
            restaurant_brand_id: Constants.brand.id,
            branch_id: Constants.branch.id,
            is_count_to_revenue: ACTIVE,
            report_type: report.reportType,
            date_string: report.dateString,
            from_date: "",
            to_date: ""
        ))
       
        switch result {

            case .success(let res):
            
                if res.status == .ok,var data = res.data{
                    data.reportType = report.reportType
                    data.dateString = report.dateString

                    revenueCostProfitReport = data
                }
                

            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
    
    @MainActor
    func getReportAreaRevenue(report:AreaRevenueReport) async{
        let result:Result<APIResponse<AreaRevenueReport>, Error> = await NetworkManager.callAPIResultAsync(netWorkManger: .report_area_revenue(
            restaurant_brand_id: Constants.brand.id,
            branch_id: Constants.branch.id,
            report_type:report.reportType,
            date_string: report.dateString,
            from_date: report.fromDate,
            to_date:  report.toDate
        ))
       
        switch result {

            case .success(let res):
            
                if res.status == .ok,var data = res.data{
                    data.reportType = report.reportType
                    data.dateString = report.dateString
                    data.fromDate = report.fromDate
                    data.toDate = report.toDate
                    data.data = data.data.map{element in
                        var newElement = element
                        newElement.color =  Color(
                            red: .random(in: 0.3...1),
                            green: .random(in: 0.3...1),
                            blue: .random(in: 0.3...1)
                        )
                        return newElement
                    }
                    areaRevenueReport = data
                }
                

            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
    @MainActor
    func getReportTableRevenue(report:TableRevenueReport) async{
        
        let result:Result<APIResponse<TableRevenueReport>, Error> = await NetworkManager.callAPIResultAsync(netWorkManger: .report_table_revenue(
            restaurant_brand_id: Constants.brand.id,
            branch_id: Constants.branch.id,
            area_id: -1,
            report_type: report.reportType,
            date_string: report.dateString,
            from_date: report.fromDate,
            to_date: report.toDate
        ))
        switch result {

            case .success(let res):
            
                if res.status == .ok,var data = res.data{
                    data.reportType = report.reportType
                    data.dateString = report.dateString
                    data.fromDate = report.fromDate
                    data.toDate = report.toDate
                    data.data = data.data.filter{$0.revenue > 0}
                    data.data.sort(by: {$0.revenue > $1.revenue})
                    
                    data.data = data.data.map{element in
                        var newElement = element
                        newElement.color =  Color(
                            red: .random(in: 0.3...1),
                            green: .random(in: 0.3...1),
                            blue: .random(in: 0.3...1)
                        )
                        return newElement
                    }
                    
                
                    
                    tableRevenueReport = data
                }
                

            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
    @MainActor
    func getReportEmployeeRevenue(report:EmployeeRevenueReport) async{
        let result:Result<APIResponse<EmployeeRevenueReport>, Error> = await NetworkManager.callAPIResultAsync(netWorkManger:.report_employee_revenue(
            restaurant_brand_id: Constants.brand.id,
            branch_id: Constants.branch.id,
            report_type: report.reportType,
            date_string: report.dateString,
            from_date: report.fromDate,
            to_date: report.toDate
        ))
        switch result {

            case .success(let res):
            
                if res.status == .ok,var data = res.data{
                    data.reportType = report.reportType
                    data.dateString = report.dateString
                    data.fromDate = report.fromDate
                    data.toDate = report.toDate
                    data.data.sort(by: {$0.revenue > $1.revenue})
                    employeeRevenueReport = data
                }
                

            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    

    
    @MainActor
    func getReportRevenueByCategory(report:RevenueCategoryReport) async{
        let result:Result<APIResponse<RevenueCategoryReport>, Error> = await NetworkManager.callAPIResultAsync(netWorkManger: .report_revenue_by_category(
            restaurant_brand_id: Constants.brand.id,
            branch_id: Constants.branch.id,
            report_type: report.reportType,
            date_string: report.dateString,
            from_date: report.fromDate,
            to_date: report.toDate
        ))
        switch result {

            case .success(let res):
            
                if res.status == .ok,var data = res.data{
                    data.reportType = report.reportType
                    data.dateString = report.dateString
                    data.fromDate = report.fromDate
                    data.toDate = report.toDate
                    data.data.sort(by: {$0.total_amount > $1.total_amount})
                    
                    data.data = data.data.map{element in
                        var newElement = element
                        newElement.color =  Color(
                            red: .random(in: 0.3...1),
                            green: .random(in: 0.3...1),
                            blue: .random(in: 0.3...1)
                        )
                        return newElement
                    }
                    
                    categoryRevenueReport = data
                }
                

            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
    
    @MainActor
    func getFoodReport(report:FoodRevenueReport) async{
        let result:Result<APIResponse<FoodRevenueReport>, Error> = await NetworkManager.callAPIResultAsync(netWorkManger: .report_food(
            restaurant_brand_id: Constants.brand.id,
            branch_id: Constants.branch.id,
            report_type: report.reportType,
            date_string: report.dateString,
            from_date: report.fromDate,
            to_date: report.fromDate,
            category_id: ALL,
            category_types: "1",
            is_combo:ALL,
            is_goods:DEACTIVE,
            is_cancelled_food:DEACTIVE,
            is_gift:DEACTIVE,
            is_take_away_food:ALL
        ))
        
        switch result {

            case .success(let res):
            
                if res.status == .ok,var data = res.data{
                    data.reportType = report.reportType
                    data.dateString = report.dateString
                    data.fromDate = report.fromDate
                    data.toDate = report.toDate
                    data.data.sort(by: {$0.total_amount > $1.total_amount})
                    foodReport = data
                }
                

            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
    
    
  
  
}
