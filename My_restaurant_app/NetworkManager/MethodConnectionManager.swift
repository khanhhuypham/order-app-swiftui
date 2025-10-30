//
//  MethodConnectionParameter.swift
//  aloline-phamkhanhhuy
//
//  Created by Pham Khanh Huy on 16/02/2024.
//



extension NetworkManager{
    
    var method: Method {
        switch self{
            //MARK: authentication
            case .sessions:
                return .GET
            
            case .config(_):
                return .GET
            
            case .login(_,_):
                return .POST
            
            case .loginUsingCode(_,_,_,_):
                return .POST
            
            case .getCodeAuthenticationList:
                return .GET
            
            case .postCreateAuthenticationCode(_,_):
                return .POST
        
            case .postChangeStatusOfAuthenticationCode(_):
                return .POST
            
            //MARK: restaurant setting
            case .setting(_):
                return .GET
            
            case .brands(_, _):
                return .GET
            
            case .branches(_, _):
                return .GET
            
            case .getBrandSetting(_):
                return .GET
            
            case .postApplyOnlyCashAmount(_):
                return .POST
            
            case .getApplyOnlyCashAmount(_):
                return .GET
            
            //MARK: ================
            
            case .orders(_, _, _, _,_,_,_):
                return .GET
            
            case .order(_,_,_,_):
                return .GET
            
            case .foods(_,_,_,_,_,_,_,_,_,_):
                return .GET
            
            case .addFoods(_, _, _, _):
                return .POST
            
            case .addGiftFoods(_, _, _, _):
                return .POST
                
            case .getPrinters(_,_):
                return .GET
            
            case .updatePrinter(_, _):
                return .POST
            
            case .vats:
                return .GET

            case .reasonCancelFoods(_):
                return .GET
            
            case .cancelFood(_, _, _, _, _):
                return .POST
            
            case .ordersNeedMove(_, _, _):
                return .GET
            
            case .moveFoods(_, _, _, _, _):
                return .POST
            
            case .updateFoods(_,_,_):
                return .POST

            case .openTable(_):
                return .POST

            case .moveTable(_, _, _):
                return .POST
            
            case .areas(_, _):
                return .GET
            
            case .tables(_, _, _, _, _,_):
                return .GET

            case .addNoteToOrder(_, _, _):
                return .POST

            case .mergeTable(_, _, _):
                return .POST

            case .createArea(_,_,_):
                return .POST
                
            case .foodsManagement(_, _, _, _, _):
                return .GET
            
            case .categories(_,_,_):
                return .GET
            
            case .notesManagement(_, _):
                return .GET
            
            case .createTable(_, _, _, _, _, _):
                return .POST

            case .foodsNeedPrint(_):
                return .GET
            
            case .updateAlreadyPrinted(_, _):
                return .POST
            
            case .sendRequestPrintOrderItem(_,_,_):
                return .POST

            case .createNote(_):
                return .POST
            
            case .createCategory(_, _, _, _, _,_):
                return .POST
            
            case .ordersHistory(_, _, _, _, _, _,_,_):
                return .GET
            
            case .getTotalAmountOfOrders(_,_,_,_,_,_):
                return .GET
            
            case .units:
                return .GET
            
            case .createFood(_, _):
                return .POST
            
            case .updateFood(_, _):
                return .POST

            case .closeTable(_):
                return .POST

            case .notes(_):
                return .GET

            case .tablesManager(_, _, _,_):
                return .GET
            
            case .notesByFood(_, _):
                return .GET

            case .getFoodsBookingStatus(_):
                return .GET

            case .postCreateOrder(_,_,_):
                return .POST

            case .postCreateTableList(_,_,_):
                return .POST
          
            case .getBuffetTickets(_,_,_,_,_):
                return .GET
            
            case .getDetailOfBuffetTicket(_,_,_,_,_,_):
                return .GET
            
            case .getFoodsOfBuffetTicket(_,_):
                return .GET
            
            case .postCreateBuffetTicket(_,_,_,_,_,_,_):
                return .POST
            
            case .postUpdateBuffetTicket(_,_,_):
                return .POST
            
            case .postCancelBuffetTicket(_):
                return .POST

            case .postDiscountOrderItem(_,_,_):
                return .POST
            
            case .getActivityLog(_,_,_,_,_,_,_,_):
                return .GET
              
            // MARK: API REPORT
            case .report_revenue_by_time(_, _, _, _, _, _):
                return .GET
            
            case .report_revenue_activities_in_day_by_branch(_, _, _, _, _, _):
                return .GET
                
            case .report_revenue_fee_profit(_,_,_,_,_,_,_):
                return .GET
            
            case .report_revenue_by_category(_, _, _, _, _, _):
                return .GET
            
            case .report_revenue_by_employee(_, _, _, _, _, _, _):
                return .GET
            
            case .report_business_analytics(_, _, _, _, _, _, _, _, _, _, _, _, _):
                return .GET
            
            case .report_employee_revenue(_, _, _, _, _, _):
                return .GET
          
            case .report_food(_,_,_,_,_,_,_,_,_,_,_,_,_):
                return .GET
            
            case .report_cancel_food(_,_,_,_,_,_,_,_,_,_,_,_):
                return .GET
            
            case .report_gifted_food(_,_,_,_,_,_,_,_,_,_,_,_):
                return .GET
            
            case .report_discount(_,_,_,_,_,_):
                return .GET
            
            case .report_VAT(_,_,_,_,_,_):
                return .GET
            
            case .report_area_revenue(_,_,_,_,_,_):
                return .GET
            
            case .report_table_revenue(_,_,_,_,_,_,_):
                return .GET
            
            case .getReportRevenueGenral(_, _, _, _, _, _):
                return .GET
            
            case .getDailyRevenueReportOfFoodApp(_,_,_,_,_,_,_):
                return .GET
////==================================================================================================================================================================
   
        }
    }
}
