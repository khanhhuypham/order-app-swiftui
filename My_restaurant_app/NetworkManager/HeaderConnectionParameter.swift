//
//  HeaderConnectionParameter.swift
//  aloline-phamkhanhhuy
//
//  Created by Pham Khanh Huy on 16/02/2024.
//


extension NetworkManager{
    private func headerJava(ProjectId:ProjectID = .PROJECT_ID_ORDER, Method:Method = .GET) -> [String : String]{
    
        var projectId:ProjectID = .PROJECT_ID_ORDER_SMALL
       
        if(ProjectId == .PROJECT_ID_ORDER){
            projectId = PermissionUtils.GPBH_1 ? .PROJECT_ID_ORDER_SMALL : .PROJECT_ID_ORDER
            
        }else{
            projectId = ProjectId
        }
        
        var header:[String:String] = [
            "Method":String(format: "%d", Method.value),
            "ProjectId":String(format: "%d", projectId.value)
        ]

        if Constants.login{
            
            header["Authorization"] = String(format: "Bearer %@", ManageCacheObject.getUser()?.access_token ?? "")
         
        }else{
             if let config = ManageCacheObject.getConfig(){
                 header["Authorization"] = String(format: "Basic %@", config.api_key ?? "")
             }
        }
        
        return header
    }
    
   
    
    var headers: [String : String]? {
        
        switch self{
            case .sessions:
                return headerJava(ProjectId: .PROJECT_OAUTH, Method: .GET)
                
            case .config(_):
                return headerJava(ProjectId: .PROJECT_OAUTH, Method: .GET)
                
            case .login(_, _):
                return headerJava(ProjectId: .PROJECT_OAUTH, Method: .POST)
            
            case .setting(_):
                return headerJava(ProjectId: .PROJECT_OAUTH, Method: .GET)
            
            case .brands(_, _):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
            
            case .branches(_, _):
                return headerJava(ProjectId: .PROJECT_ID_DASHBOARD, Method: .GET)
            
            case .getBrandSetting(_):
                return headerJava(ProjectId: .PROJECT_ID_DASHBOARD, Method: .GET)
            
            case .getPrinters(_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
            
            case .postApplyOnlyCashAmount(_):
                return headerJava(ProjectId: .PROJECT_ID_DASHBOARD, Method: .POST)
            
            case  .getApplyOnlyCashAmount(_):
                return headerJava(ProjectId: .PROJECT_ID_DASHBOARD, Method: .GET)
            
            case .orders(_, _, _, _,_,_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
            
            case .getOrderDetail(_, _):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
            
            case .foods(_,_,_,_,_,_,_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
            
            case .addFoods(_, _, _):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .PUT)

            case .addGiftFoods(_, _, _, _):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)

            case .kitchenes(_, _, _):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
            
            case .vats:
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)

//import UIKit
//
//extension ConnectionManager {
//    func headerJava(ProjectId:ProjectID = .PROJECT_ID_ORDER, Method:Method = .GET) -> [String : String]{
//        
//        var user = ManageCacheObject.getCurrentUser()
//        user.access_token = "29c29de2-77bf-4fca-b9cf-0e81f6d625ed"
//        ManageCacheObject.saveCurrentUser(user)
//        
//        
//        var projectId:ProjectID = .PROJECT_ID_ORDER_SMALL
//
//        if(ProjectId == .PROJECT_ID_ORDER){
//            projectId = PermissionUtils.GPBH_1 ? .PROJECT_ID_ORDER_SMALL : .PROJECT_ID_ORDER
//        }else{
//            projectId = ProjectId
//        }
//        
//        
//        return ["Authorization": String(format: "Bearer %@", Constants.user.access_token), "ProjectId":String(format: "%d", projectId.value), "Method":String(format: "%d", Method.value)]
//        
////        if  ManageCacheObject.isLogin(){
////            return ["Authorization": String(format: "Bearer %@", Constants.user.access_token), "ProjectId":String(format: "%d", projectId.value), "Method":String(format: "%d", Method.value)]
////        }else{
////            if ManageCacheObject.getConfig().api_key != nil{
////                return ["Authorization": String(format: "Basic %@", ManageCacheObject.getConfig().api_key), "ProjectId":String(format: "%d", projectId.value), "Method":String(format: "%d", Method.value)]
////            }else{
////                return ["ProjectId":String(format: "%d", projectId.value), "Method":String(format: "%d", Method.value)]
////            }
////
////        }
//    }
//    
//    func headerNode(ProjectId:ProjectID = .PROJECT_ID_ORDER, Method:Method = .GET) -> [String : String]{
//        
//        var user = ManageCacheObject.getCurrentUser()
//        user.access_token = "dbacac22-31ca-4530-80f1-6a5df966ebe4"
//        ManageCacheObject.saveCurrentUser(user)
//        
//        
//        
//        if  ManageCacheObject.isLogin(){
//            return ["Authorization": String(format: "Bearer %@", Constants.user.access_token), "ProjectId":String(format: "%d", ProjectId.value), "Method":String(format: "%d", Method.value)]
//        }else{
//            return ["Authorization": String(format: "%@", ManageCacheObject.getConfig().api_key), "ProjectId":String(format: "%d", ProjectId.value), "Method":String(format: "%d", Method.value)]
//            
//        }
//    }
//    
//    
//    var headers: [String : String]? {
//    
//        switch self {
// 
//            case .sessions:
//                return headerJava(ProjectId: .PROJECT_OAUTH, Method: .GET)
//            case .config(_):
//                return headerJava(ProjectId: .PROJECT_OAUTH, Method: .GET)
//            case .checkVersion:
//                return headerJava(ProjectId: .PROJECT_OAUTH, Method: .GET)
//            case .regisDevice(_):
//                return headerJava(ProjectId: .PROJECT_OAUTH, Method: .POST)
//            case .login(_, _):
//                return headerJava(ProjectId: .PROJECT_OAUTH, Method: .POST)
//            case .setting(_):
//                return headerJava(ProjectId: .PROJECT_OAUTH, Method: .GET)
            case .areas(_, _):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
            case .tables(_, _, _, _):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
            case .tablesForManagement(_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER,Method: .GET)
//            case .brands(_, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            case .branches(_, _):
//                return headerJava(ProjectId: .PROJECT_ID_DASHBOARD, Method: .GET)
//            case .orders(_, _, _, _,_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            case .order(_, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            case .foods(_,_,_,_,_,_,_,_,_,_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            case .addFoods(_, _, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//                
//            case .addGiftFoods(_, _, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//                
//            case .kitchenes(_, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            case .vats:
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//                
//            case .addOtherFoods(_, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
            
            case .addNoteToOrder(_, _, _):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//                
            case .reasonCancelItems(_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
            case .cancelFood(_, _, _, _, _):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .updateFoods(_, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .ordersNeedMove(_, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            case .moveFoods(_, _, _, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .getOrderDetail(_, _, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
            case .openTable(_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .discount(_,_,_,_,_,_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .moveTable(_, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .mergeTable(_, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .profile(_, _):
//                return headerJava()
//            case .extra_charges(_, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            case .addExtraCharge(_, _, _,_, _, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//                
//            case .returnBeer(_, _, _, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .reviewFood(_, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .getFoodsNeedReview(_, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            case .updateCustomerNumberSlot(_, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .requestPayment(_, _, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .completedPayment(_, _, _, _, _, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
////            case .tablesManagement(_, _, _):
////                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
            case .createArea(_,_,_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
                
            case .foodsManagement(_, _, _, _):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
            
            case .childrenItem:
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
                
            case .categories(_,_,_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
            case .note(_, _):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            
            case .createTable(_, _, _, _, _, _):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            
//            case .prints(_, _, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            case .openSession(_, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .workingSessions(_, _):
//                return headerJava(ProjectId: .PROJECT_ID_DASHBOARD, Method: .GET)
//            
//            case .checkWorkingSessions:
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            
//            case .sharePoint(_, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .employeeSharePoint(_, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            case .currentPoint(_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            case .assignCustomerToBill(_, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .applyVAT(_, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .fees(_, _, _, _, _, _, _, _, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            case .createFee(_, _, _, _, _, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
            case .foodsNeedPrint(_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            case .requestPrintChefBar(_,_, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//                
//            case .updateReadyPrinted(_,_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .employees(_,_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            case .kitchens(_,_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
////            case .updateKitchen(_,_):
////                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
            case .updatePrinter(_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
            
            case .createNote(_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
            case .createCategory( _, _, _, _,_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .ordersHistory(_, _, _, _, _, _,_,_,_,_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
            case .units:
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
            
            case .createFood(_, _):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .generateFileNameResource(_):
//                return headerNode(ProjectId: .PROJECT_UPLOAD_SERVICE, Method: .POST)
//                
//            case .updateFood(_, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .cities(_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            case .updateCategory(_, _, _, _, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .districts(_,_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            case .wards(_,_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//                
//            case .updateProfile(_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//                
//            case .updateProfileInfo(_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//                
//            case .changePassword(_, _, _, _):
//            return headerJava(ProjectId:PermissionUtils.GPBH_1 ? .PROJECT_ID_ORDER_SMALL :.PROJECT_ID_ORDER, Method: .POST)
//                
//            case .closeTable(_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//                
//            case .feedbackDeveloper(_, _, _, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//                
//            case .sentError(_, _, _, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .workingSessionValue:
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//                
//            case .closeWorkingSession(_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .assignWorkingSession(_, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .forgotPassword(_):
//                return headerJava(ProjectId: .PROJECT_OAUTH, Method: .POST)
//                
//            case .verifyOTP(_, _, _):
//                return headerJava(ProjectId: .PROJECT_OAUTH, Method: .POST)
//            case .verifyPassword(_, _, _):
//                return headerJava(ProjectId: .PROJECT_OAUTH, Method: .POST)
//            case .notes(_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            case .gift(_, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            case .useGift(_, _, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)

//                
//            case .notesByFood(_, _):
//                return headerJava(ProjectId: .PROJECT_ID_DASHBOARD, Method: .GET)
//            
//            case .getVATDetail(_, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//                //=========== API REPORT ========
//            case .report_revenue_by_time(_, _, _, _, _, _):
//                return headerNode(ProjectId: .PROJECT_ID_FINANCE_REPORT, Method: .GET)
//            case .report_revenue_activities_in_day_by_branch(_, _, _, _, _, _):
//                return headerNode(ProjectId: .PROJECT_ID_FINANCE_REPORT, Method: .GET)
//            case .report_revenue_fee_profit(_, _, _, _, _, _):
//                return headerNode(ProjectId: .PROJECT_ID_FINANCE_REPORT, Method: .GET)
//            case .report_revenue_by_category(_, _, _, _, _, _):
//                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT, Method: .GET)
//            case .report_revenue_by_employee(_, _, _, _, _, _, _):
//                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT, Method: .GET)
//            case .report_business_analytics(_, _, _, _, _, _, _, _, _, _, _, _, _):
//                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT, Method: .GET)
//                
//            case .report_revenue_by_all_employee(_, _, _, _, _, _):
//                return headerNode(ProjectId: .PROJECT_ID_FINANCE_REPORT, Method: .GET)
//            case .cancelExtraCharge(branch_id: let branch_id, order_id: let order_id, reason: let reason, order_extra_charge: let order_extra_charge, let quantity):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .report_food(_,_,_,_,_,_,_,_,_,_,_,_):
//                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT, Method: .GET)
//            case .report_cancel_food(_,_,_,_,_,_,_,_,_,_,_,_):
//                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT, Method: .GET)
//            case .report_gifted_food(_,_,_,_,_,_,_,_,_,_,_,_):
//                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT, Method: .GET)
//            case .report_discount(_,_,_,_,_,_):
//                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT, Method: .GET)
//            case .report_VAT(_,_,_,_,_,_):
//                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT, Method: .GET)
//            case .report_area_revenue(_,_,_,_,_,_):
//                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT, Method: .GET)
//            case .report_table_revenue(_,_,_,_,_,_,_):
//                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT, Method: .GET)
//                
//                
//            case .updateOtherFeed(_,_,_,_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            case .getAdditionFee(_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            case .updateAdditionFee(_,_,_,_,_,_,_,_,_,_,_,_,_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .cancelAdditionFee(_,_,_,_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            case .updateOtherFee(_,_,_,_,_,_,_,_,_,_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//     
//            case .moveExtraFoods(branch_id: let branch_id, order_id: let order_id, target_order_id: let target_order_id, foods: let foods):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
            case .getFoodsBookingStatus(_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
            
//            case .updateBranch(_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//                
//              // API REPORT SEEMT
//            case .getReportOrderRestaurantDiscountFromOrder(_, _, _, _, _, _):
//                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT, Method: .GET)//@
//                
//            case .getOrderReportFoodCancel(_, _, _, _, _, _, _):
//                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT)//@
//                
//            case .getOrderReportFoodGift(_, _, _, _, _, _, _, _):
//                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT)
//                
//            case .getRestaurantRevenueCostProfitEstimation(_,_,_,_,_,_):
//                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT)
//                
//            case .getOrderCustomerReport(_,_,_,_,_,_):
//                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT)
//                
//            case .getReportRevenueGenral(_, _, _, _, _, _):
//                return headerNode(ProjectId: .PROJECT_ID_FINANCE_REPORT, Method: .GET)
//                
//            case .getReportRevenueArea(_, _, _, _, _, _):
//                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT, Method: .GET)
//                
//            case .getReportSurcharge(_, _, _, _, _, _):
//                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT)
//                
//            case .getReportRevenueProfitFood(_, _, _, _, _, _, _, _, _):
//                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT, Method: .GET)
//                
//            case .getRestaurantOtherFoodReport(_, _, _, _, _, _, _, _, _):
//                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT)
//                
//            case .getRestaurantVATReport(_, _, _, _, _, _):
//                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT)
//                
//            case .getWarehouseSessionImportReport(_, _, _, _, _, _):
//                return headerNode(ProjectId: .PROJECT_ID_FINANCE_REPORT)
//                
//            case .getRenueByEmployeeReport(_, _, _, _, _, _):
//                return headerNode(ProjectId: .PROJECT_ID_FINANCE_REPORT)
//                
//            case .getRestaurantRevenueDetailByBrandId(_,_,_,_,_,_):
//                return headerNode(ProjectId: .PROJECT_ID_FINANCE_REPORT)
//                
//            case .getRestaurantRevenueDetailByBranch(_,_,_,_,_,_):
//                return headerNode(ProjectId: .PROJECT_ID_FINANCE_REPORT)
//                
//            case .getRestaurantRevenueCostProfitSum(_,_,_,_,_,_):
//                return headerNode(ProjectId: .PROJECT_ID_FINANCE_REPORT)
//                
//            case .getOrderReportTakeAwayFood(_, _, _, _, _, _, _, _, _, _, _, _):
//                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT)//@
//                
//            case .getRestaurantRevenueCostProfitReality(_,_,_,_,_,_):
//                return headerNode(ProjectId: .PROJECT_ID_FINANCE_REPORT)
//                
//            case .getInfoBranches(_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//                
//            case .healthCheckChangeDataFromServer(_,_,_):
//                return headerJava(ProjectId: .PROJECT_HEALTH_CHECK_SERVICE, Method: .GET)
//            
//            case .healthCheckForBuffet(_,_,_,_):
//                return headerJava(ProjectId: .PROJECT_HEALTH_CHECK_SERVICE, Method: .GET)
//                
//            case .getLastLoginDevice(_,_):
//                return headerJava(ProjectId: .PROJECT_OAUTH, Method: .GET)
//                
            case .postCreateOrder(_,_,_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//                
//                
//            case .getBranchRights(_,_):
//                return headerJava(ProjectId: .PROJECT_ID_DASHBOARD, Method: .GET)
//                
//                
//            case .getTotalAmountOfOrders(_,_,_,_,_,_,_,_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            
//            case .postApplyExtraChargeOnTotalBill(_,_,_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//                
//                
//            case .postPauseService(_,_,_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//                
//            case .postUpdateService(_,_,_,_,_,_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            
//            case .getActivityLog(_,_,_,_,_,_,_,_):
//                return headerJava(ProjectId: .PROJECT_ID_LOG, Method: .GET)
//            
//            case .postApplyOnlyCashAmount(_):
//                return headerJava(ProjectId: .PROJECT_ID_DASHBOARD, Method: .POST)
//            case  .getApplyOnlyCashAmount(_):
//                return headerJava(ProjectId: .PROJECT_ID_DASHBOARD, Method: .GET)
//                
//            case .getVersionApp(_, _, _, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_VERSION_APP)
//           
//            case .postApplyTakeAwayTable(_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//                
            case .postCreateTableList(_,_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//                
//            case .getPrintItem(_,_,_):
//                return headerJava(ProjectId: .PROJECT_ID_FOR_PRINT_ITEM, Method: .GET)
//                
//            case .getBrandSetting(_):
//                return headerJava(ProjectId: .PROJECT_ID_DASHBOARD, Method: .GET)
//            
//            
//            case .getSendToKitchen(_,_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            
//            case .postSendToKitchen(_,_,_):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            
//            
//            case .getBankAccount(_, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER_SMALL, Method: .GET)
//            
//            
//            case .getBankList:
//                return headerJava(ProjectId: .PROJECT_ID_ORDER_SMALL, Method: .GET)
//            
//            case .getBrandBankAccount(_,_):
//                return headerJava(ProjectId: PermissionUtils.GPBH_1 ? .PROJECT_ID_ORDER_SMALL : .PROJECT_ID_ORDER, Method: .GET)
//            
////            case .postCreateBrandBankAccount(_,_):
////                return headerJava(ProjectId: .PROJECT_ID_ORDER_SMALL, Method: .POST)
////                
////            case .postUpdateteBrandBankAccount(_,_):    
////                return headerJava(ProjectId: .PROJECT_ID_ORDER_SMALL, Method: .POST)
//                    
//            
//            
            case .getBuffetTickets(_,_,_,_,_):
                return headerJava(ProjectId: .PROJECT_ID_DASHBOARD, Method: .GET)
            
            case .getDetailOfBuffetTicket(_,_,_,_,_,_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
            
            case .getFoodsOfBuffetTicket(_,_):
                return headerJava(ProjectId: .PROJECT_ID_DASHBOARD, Method: .GET)
            
            case .postCreateBuffetTicket(_,_,_,_,_,_,_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
            
            case .postUpdateBuffetTicket(_,_,_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
            
            case .postCancelBuffetTicket(_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            
            case .postDiscountOrderItem(_,_,_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//            
//            // MARK: API for chat
//            case .postCreateGroupSuppport:
//                return headerJava(ProjectId: .PROJECT_ID_FOR_CONVERSATION_SERVICE, Method: .POST)
//            
//            case .getMessageList(_,_,_,_):
//                return headerJava(ProjectId: .PROJECT_ID_FOR_MEESSAGE_SERVICE, Method: .GET)
//            
//            case .getListMedia(_, _, _, _, _, _, _):
//                return headerJava(ProjectId: .PROJECT_UPLOAD_SERVICE, Method: .GET)
//            
//            
//            case .postRemovePrintedItem(_,_):
//                return headerJava(ProjectId: .PROJECT_ID_FOR_PRINT_ITEM, Method: .POST)
//            
//            
//            
////==================================================================================================================================================================
 
        }
    }
}
