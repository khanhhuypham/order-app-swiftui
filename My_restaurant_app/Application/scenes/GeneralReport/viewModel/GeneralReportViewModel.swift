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
    
    func getDailyReport(){
       
        NetworkManager.callAPI(netWorkManger: .report_revenue_activities_in_day_by_branch(
            restaurant_brand_id: Constants.brand.id,
            branch_id: Constants.branch.id,
            report_type: dailyOrderReport.reportType,
            date_string: dailyOrderReport.dateString,
            from_date: "",
            to_date: ""
        )){[weak self] (result: Result<APIResponse<DailyOrderReport>, Error>) in
            guard let self = self else {
                return
            }
            
            switch result {

                case .success(var res):
                
                    if res.status == .ok{
                        dailyOrderReport = res.data
                    }
                    

                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
    }
    
    func getDailyRevenueReportOfFoodApp(){
       
        NetworkManager.callAPI(netWorkManger: .getDailyRevenueReportOfFoodApp(
            restaurant_id: Constants.restaurant_id,
            restaurant_brand_id: Constants.brand.id,
            branch_id: Constants.branch.id,
            food_channel_id: -1,
            date_string: foodAppReport.dateString,
            report_type: foodAppReport.reportType,
            hour_to_take_report: Constants.setting.hour_to_take_report
        )){[weak self] (result: Result<APIResponse<FoodAppReport>, Error>) in
            guard let self = self else {
                return
            }
            
            switch result {

                case .success(var res):
                
                    if res.status == .ok{
                        foodAppReport = res.data
                    }
                    

                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
    }
    

    
    func getTodayRevenueReport(){
       
        NetworkManager.callAPI(netWorkManger: .report_revenue_by_time(
            restaurant_brand_id: Constants.brand.id,
            branch_id: Constants.branch.id,
            report_type: toDayRenueReport.reportType,
            date_string: toDayRenueReport.dateString,
            from_date: "",
            to_date: ""
        )){[weak self] (result: Result<APIResponse<RevenueReport>, Error>) in
            guard let self = self else {
                return
            }
            
            switch result {

                case .success(var res):
                
                    if res.status == .ok{
                        toDayRenueReport = res.data
                    }
                    

                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
    }
    
    func getReportRevenueGenral(report:SaleReport){
       
        NetworkManager.callAPI(netWorkManger: .getReportRevenueGenral(
            restaurant_brand_id: Constants.brand.id,
            branch_id: Constants.branch.id,
            report_type: report.reportType,
            date_string: report.dateString,
            from_date: report.fromDate,
            to_date: report.toDate
        )){[weak self] (result: Result<APIResponse<SaleReport>, Error>) in
            guard let self = self else {
                return
            }
            
            switch result {

                case .success(var res):
                
                    if res.status == .ok{
                        res.data.reportType = report.reportType
                        res.data.dateString = report.dateString
                        res.data.fromDate = report.fromDate
                        res.data.toDate = report.toDate
               
                        saleReport = res.data
                    }
                    

                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
    }
    
    
    func reportRevenueCostProfit(report:RevenueFeeProfitReport){
       
        NetworkManager.callAPI(netWorkManger: .report_revenue_fee_profit(
            restaurant_brand_id: Constants.brand.id,
            branch_id: Constants.branch.id,
            is_count_to_revenue: ACTIVE,
            report_type: report.reportType,
            date_string: report.dateString,
            from_date: "",
            to_date: ""
        )){[weak self] (result: Result<APIResponse<RevenueFeeProfitReport>, Error>) in
            guard let self = self else {
                return
            }
            
            switch result {

                case .success(var res):
                
                    if res.status == .ok{
                        res.data.reportType = report.reportType
                        res.data.dateString = report.dateString
    
                        revenueCostProfitReport = res.data
                    }
                    

                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
    }
    
    
    
    func getReportAreaRevenue(report:AreaRevenueReport){
        NetworkManager.callAPI(netWorkManger: .report_area_revenue(
            restaurant_brand_id: Constants.brand.id,
            branch_id: Constants.branch.id,
            report_type:report.reportType,
            date_string: report.dateString,
            from_date: report.fromDate,
            to_date:  report.toDate
        )){[weak self] (result: Result<APIResponse<AreaRevenueReport>, Error>) in
            guard let self = self else {
                return
            }
            
            switch result {

                case .success(var res):
                
                    if res.status == .ok{
                        res.data.reportType = report.reportType
                        res.data.dateString = report.dateString
                        res.data.fromDate = report.fromDate
                        res.data.toDate = report.toDate
                        res.data.data = res.data.data.map{element in
                            var newElement = element
                            newElement.color =  Color(
                                red: .random(in: 0.3...1),
                                green: .random(in: 0.3...1),
                                blue: .random(in: 0.3...1)
                            )
                            return newElement
                        }
                        areaRevenueReport = res.data
                    }
                    

                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
    }
    
    
    func getReportTableRevenue(report:TableRevenueReport){
        NetworkManager.callAPI(netWorkManger: .report_table_revenue(
            restaurant_brand_id: Constants.brand.id,
            branch_id: Constants.branch.id,
            area_id: -1,
            report_type: report.reportType,
            date_string: report.dateString,
            from_date: report.fromDate,
            to_date: report.toDate
        )){[weak self] (result: Result<APIResponse<TableRevenueReport>, Error>) in
            guard let self = self else {
                return
            }
            
            switch result {

                case .success(var res):
                
                    if res.status == .ok{
                        res.data.reportType = report.reportType
                        res.data.dateString = report.dateString
                        res.data.fromDate = report.fromDate
                        res.data.toDate = report.toDate
                        res.data.data = res.data.data.filter{$0.revenue > 0}
                        res.data.data.sort(by: {$0.revenue > $1.revenue})
                        
                        res.data.data = res.data.data.map{element in
                            var newElement = element
                            newElement.color =  Color(
                                red: .random(in: 0.3...1),
                                green: .random(in: 0.3...1),
                                blue: .random(in: 0.3...1)
                            )
                            return newElement
                        }
                        
                    
                        
                        tableRevenueReport = res.data
                    }
                    

                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
    }
    
    func getReportEmployeeRevenue(report:EmployeeRevenueReport){
        NetworkManager.callAPI(netWorkManger: .report_employee_revenue(
            restaurant_brand_id: Constants.brand.id,
            branch_id: Constants.branch.id,
            report_type: report.reportType,
            date_string: report.dateString,
            from_date: report.fromDate,
            to_date: report.toDate
        )){[weak self] (result: Result<APIResponse<EmployeeRevenueReport>, Error>) in
            guard let self = self else {
                return
            }
            
            switch result {

                case .success(var res):
                
                    if res.status == .ok{
                        res.data.reportType = report.reportType
                        res.data.dateString = report.dateString
                        res.data.fromDate = report.fromDate
                        res.data.toDate = report.toDate
                        res.data.data.sort(by: {$0.revenue > $1.revenue})
                        employeeRevenueReport = res.data
                    }
                    

                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
    }
    

    
    
    func getReportRevenueByCategory(report:RevenueCategoryReport){
        NetworkManager.callAPI(netWorkManger: .report_revenue_by_category(
            restaurant_brand_id: Constants.brand.id,
            branch_id: Constants.branch.id,
            report_type: report.reportType,
            date_string: report.dateString,
            from_date: report.fromDate,
            to_date: report.toDate
        )){[weak self] (result: Result<APIResponse<RevenueCategoryReport>, Error>) in
            guard let self = self else {
                return
            }
            
            switch result {

                case .success(var res):
                
                    if res.status == .ok{
                        res.data.reportType = report.reportType
                        res.data.dateString = report.dateString
                        res.data.fromDate = report.fromDate
                        res.data.toDate = report.toDate
                        res.data.data.sort(by: {$0.total_amount > $1.total_amount})
                        
                        res.data.data = res.data.data.map{element in
                            var newElement = element
                            newElement.color =  Color(
                                red: .random(in: 0.3...1),
                                green: .random(in: 0.3...1),
                                blue: .random(in: 0.3...1)
                            )
                            return newElement
                        }
                        
                        categoryRevenueReport = res.data
                    }
                    

                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
    }
    
    
    
    func getFoodReport(report:FoodRevenueReport){
        NetworkManager.callAPI(netWorkManger: .report_food(
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
        )){[weak self] (result: Result<APIResponse<FoodRevenueReport>, Error>) in
            guard let self = self else {
                return
            }
            
            switch result {

                case .success(var res):
                
                    if res.status == .ok{
                        res.data.reportType = report.reportType
                        res.data.dateString = report.dateString
                        res.data.fromDate = report.fromDate
                        res.data.toDate = report.toDate
                        res.data.data.sort(by: {$0.total_amount > $1.total_amount})
                        foodReport = res.data
                    }
                    

                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
    }
    
    
    
  
  
}
