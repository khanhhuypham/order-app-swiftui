//
//  PathConnectionManager.swift
//  aloline-phamkhanhhuy
//
//  Created by Pham Khanh Huy on 16/02/2024.
//

import UIKit

extension NetworkManager{
    private static let version_of_small_order = "v15"
    private static let version_of_order = "v15"
    private static let version_of_dashboard = "v14"
    private static let version_of_app_food = "v3"
    private static let version_of_report = "v2"
    private static let version_of_finance_report = "v2"
    private static let upload_api_version = "v2"
    private static let version_oauth_service = "v10"
    private static let version_of_log_api = "v2"
    
    var path: String {
        switch self{
            
            //MARK: authentication
            case .sessions:
                return String(format: environmentMode == .offline ? "/api/sessions" : "/api/%@/sessions", NetworkManager.version_oauth_service)
            
            case .config(_):
                return String(format: environmentMode == .offline ? "/api/configs" : "/api/%@/configs", NetworkManager.version_oauth_service)
            
            case .login(_,_):
                return String(format: environmentMode == .offline ? "/api/employees/login" : "/api/%@/employees/login", NetworkManager.version_oauth_service)
            
            case .loginUsingCode(_,_,_,_):
                return String(format: "/api/%@/employees/code/login", NetworkManager.version_oauth_service)
            
            case .getCodeAuthenticationList:
                return String(format: "/api/%@/code-authentication", NetworkManager.version_oauth_service)
            
            case .postCreateAuthenticationCode(_,_):
                return String(format: "/api/%@/code-authentication/create", NetworkManager.version_oauth_service)
            
            case .postChangeStatusOfAuthenticationCode(let id):
                return String(format: "/api/%@/code-authentication/%d/change-status", NetworkManager.version_oauth_service,id)
                
            //MARK: restaurant setting
            case .setting(_):
                return String(format: environmentMode == .offline ? "/api/employees/settings" : "/api/%@/employees/settings", NetworkManager.version_oauth_service)
            
            case .brands(_,_):
                return String(format: environmentMode == .offline ?  "/api/restaurant-brands" :  "/api/%@/restaurant-brands", NetworkManager.version_of_dashboard)
            
            case .branches(_,_):
                return String(format: environmentMode == .offline ?  "/api/branches" :  "/api/%@/branches", NetworkManager.version_of_dashboard)
            
            case .getBrandSetting(let brand_id):
                return environmentMode == .offline
                ? String(format:"/api/restaurant-brands/%d/setting",brand_id)
                : String(format:"/api/%@/restaurant-brands/%d/setting",NetworkManager.version_of_dashboard,brand_id)
            
            case .postApplyOnlyCashAmount(let branchId):
                return environmentMode == .offline
                ? String(format: "/api/branches/%d/setting/confirm-channel-order",branchId)
                : String(format: "/api/%@/branches/%d/setting/confirm-channel-order",NetworkManager.version_of_dashboard,branchId)
            
            case .getApplyOnlyCashAmount(let branchId):
                return environmentMode == .offline
                ? String(format: "/api/branches/%d/setting/is-apply-only-cash-amount",branchId)
                : String(format: "/api/%@/branches/%d/setting/is-apply-only-cash-amount",NetworkManager.version_of_dashboard,branchId)
            
            //MARK: ======
            case .orders(_, _, _, _,_):
                return String(
                    format: environmentMode == .offline ? "/api/orders/elk/list" : "/api/%@/orders/elk/list",
                    PermissionUtils.GPBH_1 ? NetworkManager.version_of_small_order : NetworkManager.version_of_order
                )
            
            case .order(let order_id, _,_,_):
                return environmentMode == .offline
                ? String(format: "/api/orders/%d",order_id)
                : String(format: "/api/%@/orders/%d", NetworkManager.version_of_order,order_id)

            case .foods(_,_,_,_,_,_,_,_,_,_):
                return String(format: environmentMode == .offline ? "/api/foods/menu" : "/api/%@/foods/menu", NetworkManager.version_of_order)

            case .addFoods(_, let order_id, _, _):
                return environmentMode == .offline
                ? String(format:"/api/orders/%d/add-food",order_id)
                : String(format:"/api/%@/orders/%d/add-food", NetworkManager.version_of_order,order_id)

            case .addGiftFoods(_, let order_id, _, _):
                return environmentMode == .offline
                ? String(format:"/api/orders/%d/gift-food",order_id)
                : String(format:"/api/%@/orders/%d/gift-food", NetworkManager.version_of_order,order_id)

            case .getPrinters(_,_):
                return String(format: environmentMode == .offline ? "/api/restaurant-kitchen-places" : "/api/%@/restaurant-kitchen-places",NetworkManager.version_of_order)
            
            case .updatePrinter(_,  let printer):
                return environmentMode == .offline
                ?  String(format: "/api/restaurant-kitchen-places/%d",printer.id)
                :  String(format: "/api/%@/restaurant-kitchen-places/%d",NetworkManager.version_of_order,printer.id)

            case .vats:
                return String(format: environmentMode == .offline ?  "/api/restaurant-vat-configs" : "/api/%@/restaurant-vat-configs",NetworkManager.version_of_order )

//            case .addOtherFoods(_, let order_id, _):
//               return String(format: APIEndPoint.Name.urlAddOtherFoodsToOrder, order_id)
//
//            case .addNoteToOrderDetail(_, let order_detail_id, _):
//               return String(format: APIEndPoint.Name.urlAddNoteToOrderDetail, order_detail_id)
//
//
            case .cancelFood(_, let order_id, _, _, _):
                return environmentMode == .offline
                ? String(format: "/api/orders/%d/cancel-order-detail",order_id)
                : String(format: "/api/%@/orders/%d/cancel-order-detail", NetworkManager.version_of_order,order_id)

            case .openTable(let table_id):
                return environmentMode == .offline
                ? String(format: "/api/tables/%d/open",table_id)
                : String(format: "/api/%@/tables/%d/open", NetworkManager.version_of_order,table_id)
            
            case .ordersNeedMove(_, let order_id, _):
                return environmentMode == .offline
                ? String(format: "/api/orders/%d/order-detail-move",order_id)
                : String(format: "/api/%@/orders/%d/order-detail-move", NetworkManager.version_of_order, order_id)
                    
            case .moveFoods(_,_, let destination_table_id,_,_):
                return environmentMode == .offline
                ? String(format: "/api/tables/%d/move-food",destination_table_id)
                : String(format: "/api/%@/tables/%d/move-food", NetworkManager.version_of_order,destination_table_id)
            
            case .moveTable(_,let from,_):
               return String(format: APIEndPoint.Name.urlMoveTable, from)

            
            case .areas(_, _):
                return String(format: environmentMode == .offline ? "/api/areas" : "/api/%@/areas", NetworkManager.version_of_order)
//
            case .tables(_, _, _, _, _,_):
                return String(format: environmentMode == .offline ? "/api/tables" : "/api/%@/tables",NetworkManager.version_of_order)

            case .addNoteToOrder(_, let order_detail_id, _):
                return environmentMode == .offline
                ?  String(format:"/api/order-details/%d/note",order_detail_id)
                :  String(format:"/api/%@/order-details/%d/note", NetworkManager.version_of_order,order_detail_id)

            case .reasonCancelFoods(_):
                return String(format:environmentMode == .offline ? "/api/orders/cancel-reasons" : "/api/%@/orders/cancel-reasons",NetworkManager.version_of_order)
//
//            case .cancelFood(_, let order_id, _, _, _):
//                return String(format: APIEndPoint.Name.urlCancelFood, order_id)
//                
            case .updateFoods(_, let order_id, _):
                return environmentMode == .offline
                ?  String(format:"/api/orders/%d/update-multi-order-detail",order_id)
                :  String(format:"/api/%@/orders/%d/update-multi-order-detail", NetworkManager.version_of_order,order_id)

            case .mergeTable(_, let destination_table_id,_):
                return environmentMode == .offline
                ? String(format: "/api/tables/%d/merge",destination_table_id)
                : String(format: "/api/%@/tables/%d/merge", NetworkManager.version_of_order,destination_table_id)

            case .createArea(_,_,_):
                return  String(format:"/api/%@/areas/manage",NetworkManager.version_of_order)

            case .foodsManagement(_, _, _, _, _):
                return String(format:"/api/%@/foods/branch",NetworkManager.version_of_order)
              
            case .categories(_,_,_):
                return String(format:"/api/%@/categories", NetworkManager.version_of_order)

            case .notesManagement(_, _):
                return String(format:"/api/%@/order-detail-notes", NetworkManager.version_of_order)

            case .createTable(_, _, _, _, _, _):
                return String(format:"/api/%@/tables/manage",NetworkManager.version_of_order)

            case .foodsNeedPrint(_):
                return String(format:environmentMode == .offline ? "/api/orders/is-print" : "/api/%@/orders/is-print",NetworkManager.version_of_order )

            case .createNote(_):
                return String(format:"/api/%@/order-detail-notes/manage",NetworkManager.version_of_order )

            case .createCategory(let id, _, _, _, _,_):
                return String(format: "/api/%@/categories/%@",NetworkManager.version_of_order,id == 0 ? "create" : (id.description + "/update"))

            case .ordersHistory(_, _,_,_, _,_,_,_):
                return String(format: "/api/%@/orders/elk/list",PermissionUtils.GPBH_1 ? NetworkManager.version_of_small_order : NetworkManager.version_of_order)

            case .getTotalAmountOfOrders(_,_,_,_,_,_):
                return String(format: "/api/%@/orders/elk/count",PermissionUtils.GPBH_1 ? NetworkManager.version_of_small_order : NetworkManager.version_of_dashboard)
                
            case .units:
                return String(format: "/api/%@/foods/unit",NetworkManager.version_of_order)
            
            case .createFood(_, _):
                return String(format: "/api/%@/foods/create",NetworkManager.version_of_order)
            
            case .closeTable(let order_id):
                return environmentMode == .offline
                ? String(format: "/api/tables/%d/close",order_id)
                : String(format: "/api/%@/tables/%d/close",NetworkManager.version_of_order,order_id)

            case .notes(_):
                return String(format:environmentMode == .offline ? "/api/order-detail-notes" : "/api/%@/order-detail-notes",NetworkManager.version_of_order)
                
//            case .gift(_, _):
//                return APIEndPoint.Name.urlGift
//                
//            case .useGift(_,let order_id, _, _):
//                return String(format: APIEndPoint.Name.urlUseGift, order_id)
//                
            case .tablesManager(_, _, _, _):
                return String(format: "/api/%@/tables/manage", NetworkManager.version_of_order)
//
            case .notesByFood(let order_detail_id, _):
                return environmentMode == .offline
                ? String(format: "/api/food-notes/by-food-id/%d",order_detail_id)
                : String(format: "/api/%@/food-notes/by-food-id/%d",NetworkManager.version_of_dashboard, order_detail_id)

            case .getFoodsBookingStatus(let order_id):
                return String(format: "api/%@/order-details/%d/booking" ,NetworkManager.version_of_order,order_id)

            case .postCreateOrder(_,_,_):
                return String(format:environmentMode == .offline ? "api/orders/create" : "api/%@/orders/create", NetworkManager.version_of_order)

            case .postCreateTableList(_,_,_):
                return APIEndPoint.Name.urlPostCreateTableList
   
            case .getBuffetTickets(_,_,_,_,_):
                return String(format: "/api/%@/buffet-ticket",NetworkManager.version_of_order)
            
            case .getDetailOfBuffetTicket(_,_,_,_,_,_):
                return String(format: "/api/%@/foods/menu-buffet",NetworkManager.version_of_order)
            
            case .getFoodsOfBuffetTicket(_,_):
                return String(format: "/api/%@/buffet-ticket/foods",NetworkManager.version_of_order)
                
            case .postCreateBuffetTicket(_,_,_,_,_,_,_):
                return String(format: "/api/%@/order-buffets/create",NetworkManager.version_of_order)
              
            case .postUpdateBuffetTicket(_,_,let buffet):
                return String(format: "/api/%@/order-buffets/%d/update",NetworkManager.version_of_order,buffet.id)
            
            case .postCancelBuffetTicket(let id):
                return String(format: "/api/%@/order-buffets/%d/cancel",NetworkManager.version_of_order,id)

            case .postDiscountOrderItem(_,let orderId,_):
                return environmentMode == .offline
                ? String(format:"/api/order-details/%d/discount",orderId)
                : String(format:"/api/%@/order-details/%d/discount",NetworkManager.version_of_order,orderId)

            case .getActivityLog(_,_,_,_,_,_,_,_):
                return String(format:environmentMode == .offline ? "/api/log-activities" : "/api/%@/logs/activity",NetworkManager.version_of_log_api)
            
            
            //MARK: API REPORT
            case .report_revenue_by_time(_, _, _, _, _, _):
                return String(format:"/api/%@/order-restaurant-revenue-report",NetworkManager.version_of_report)
                
            case .report_revenue_activities_in_day_by_branch(_, _, _, _, _, _):
                return String(format:"/api/%@/order-restaurant-current-day",NetworkManager.version_of_report)
                
            case .report_revenue_fee_profit(_,_,_,_,_,_,_):
                return String(format:"/api/%@/order-revenue-cost-profit-by-branch",NetworkManager.version_of_report)
          
            case .report_revenue_by_category(_, _, _, _, _, _):
                return String(format:"/api/%@/order-restaurant-revenue-by-category",NetworkManager.version_of_report)
                
            case .report_revenue_by_employee(_, _, _, _, _, _, _):
                return String(format:"/api/%@/order-revenue-current-by-employee",NetworkManager.version_of_report)
                
            case .report_business_analytics(_, _, _, _, _, _, _, _, _, _, _, _, _):
                return String(format:"/api/%@/order-restaurant-revenue-by-food",NetworkManager.version_of_report)
           
            case .report_employee_revenue(_, _, _, _, _, _):
                return String(format:"/api/%@/order-restaurant-revenue-by-employee",NetworkManager.version_of_report)
                
            case .report_food(_,_,_,_,_,_,_,_,_,_,_,_,_):
                return String(format:"/api/%@/order-report-food",NetworkManager.version_of_report)
                
            case .report_cancel_food(_,_,_,_,_,_,_,_,_,_,_,_):
                return String(format:"/api/%@/order-report-food-cancel",NetworkManager.version_of_report)
                
            case .report_gifted_food(_,_,_,_,_,_,_,_,_,_,_,_):
                return String(format:"/api/%@/order-report-food-gift",NetworkManager.version_of_report)
                
            case .report_discount(_,_,_,_,_,_):
                return String(format:"/api/%@/order-restaurant-discount-from-order",NetworkManager.version_of_report)
                
            case .report_VAT(_,_,_,_,_,_):
                return String(format:"/api/%@/window-order-report-data/vat",NetworkManager.version_of_report)
                    
            case .report_area_revenue(_,_,_,_,_,_):
                return String(format:"/api/%@/order-restaurant-revenue-by-area",NetworkManager.version_of_report)
                
            case .report_table_revenue(_,_,_,_,_,_,_):
                return String(format:"/api/%@/order-restaurant-revenue-by-table",NetworkManager.version_of_report)
            
    
            case .getReportRevenueGenral(_, _, _, _, _, _):
                return String(format:"/api/%@/order-restaurant-revenue-report",NetworkManager.version_of_report)
            
    
            case .getDailyRevenueReportOfFoodApp(_,_,_,_,_,_,_):
                return String(format: "/api/%@/food-channel-sumary-datas",NetworkManager.version_of_report)
////==================================================================================================================================================================

            
        }
    }
}
