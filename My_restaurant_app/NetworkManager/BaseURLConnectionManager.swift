//
//  BaseURLConnectionManager.swift
//  TECHRES-ORDER
//
//  Created by Pham Khanh Huy on 15/8/25.
//

import Foundation

extension NetworkManager {
    
    var baseURL: URL {
        
        switch self {
            
            //MARK: Authentication API
            case .loginUsingCode(_,_,_,_):
                return URL(string: onlineBaseUrl)!
            
            case .getCodeAuthenticationList:
                return URL(string: onlineBaseUrl)!
            
            //MARK: API REPORT ========
            case .report_revenue_by_time(_, _, _, _, _, _):
                return URL(string: onlineBaseUrl)!
                
            case .report_revenue_activities_in_day_by_branch(_, _, _, _, _, _):
                return URL(string: onlineBaseUrl)!
                
            case .report_revenue_fee_profit(_,_,_,_,_,_,_):
                return URL(string: onlineBaseUrl)!
                
            case .report_revenue_by_category(_, _, _, _, _, _):
                return URL(string: onlineBaseUrl)!
                
            case .report_revenue_by_employee(_, _, _, _, _, _, _):
                return URL(string: onlineBaseUrl)!
                
            case .report_business_analytics(_, _, _, _, _, _, _, _, _, _, _, _, _):
                return URL(string: onlineBaseUrl)!
                
            case .report_food(_,_,_,_,_,_,_,_,_,_,_,_,_):
                return URL(string: onlineBaseUrl)!
                
            case .report_cancel_food(_,_,_,_,_,_,_,_,_,_,_,_):
                return URL(string: onlineBaseUrl)!
                
            case .report_gifted_food(_,_,_,_,_,_,_,_,_,_,_,_):
                return URL(string: onlineBaseUrl)!
                
            case .report_discount(_,_,_,_,_,_):
                return URL(string: onlineBaseUrl)!
                
            case .report_VAT(_,_,_,_,_,_):
                return URL(string: onlineBaseUrl)!
            
            case .report_area_revenue(_,_,_,_,_,_):
                return URL(string: onlineBaseUrl)!
                
            case .report_table_revenue(_,_,_,_,_,_,_):
                return URL(string: onlineBaseUrl)!
            
            //MARK: API REPORT SEEMT
            case .getDailyRevenueReportOfFoodApp(_,_,_,_,_,_,_):
                return URL(string: onlineBaseUrl)!
            
            //===================================================
            case .ordersHistory(_,_,_,_, _,_,_,_):
                return URL(string: onlineBaseUrl)!
            
            case .getTotalAmountOfOrders(_,_,_,_,_,_):
                return URL(string: onlineBaseUrl)!
            
       
            
            default:
                return URL(string: environmentMode.baseUrl)!
        }
        
    }
    
}
