//
//  HeaderConnectionParameter.swift
//  aloline-phamkhanhhuy
//
//  Created by Pham Khanh Huy on 16/02/2024.
//


extension NetworkManager{
    
//    @Injected(\.utils) static var utils
    
    private func headerJava(ProjectId:ProjectID = .PROJECT_ID_ORDER, Method:Method = .GET) -> [String : String]{
        
        @Injected(\.utils.keyChainUtils) var keyChain
        
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
        
        if Constants.login, let token = keyChain.getAccessToken(){
            
            header["Authorization"] = String(format: "Bearer %@", token)
         
        }else{
             if let config = ManageCacheObject.getConfig(){
                 header["Authorization"] = String(format: "Basic %@", config.api_key ?? "")
             }
        }
        
        return header
    }
    
    private func headerNode(ProjectId:ProjectID = .PROJECT_ID_ORDER, Method:Method = .GET) -> [String : String]{
        @Injected(\.utils.keyChainUtils) var keyChain
        
        if let token = keyChain.getAccessToken(), ManageCacheObject.isLogin(){
            return ["Authorization": String(format: "Bearer %@",token), "ProjectId":String(format: "%d", ProjectId.value), "Method":String(format: "%d", Method.value)]
        }else{
            return ["Authorization": String(format: "%@", ManageCacheObject.getConfig()?.api_key ?? ""), "ProjectId":String(format: "%d", ProjectId.value), "Method":String(format: "%d", Method.value)]
            
        }
    }

   
    
    var headers: [String : String]? {
        
        switch self{
            //MARK: authentication
            case .sessions:
                return headerJava(ProjectId: .PROJECT_OAUTH, Method: .GET)
                
            case .config(_):
                return headerJava(ProjectId: .PROJECT_OAUTH, Method: .GET)
                
            case .login(_, _):
                return headerJava(ProjectId: .PROJECT_OAUTH, Method: .POST)
            
            case .loginUsingCode(_, _,_,_):
                return headerJava(ProjectId: .PROJECT_OAUTH, Method: .POST)
            
            case .getCodeAuthenticationList:
                return headerJava(ProjectId: .PROJECT_OAUTH, Method: .GET)
            
            case .postCreateAuthenticationCode(_,_):
                return headerJava(ProjectId: .PROJECT_OAUTH, Method: .POST)
            
            case .postChangeStatusOfAuthenticationCode(_):
                return headerJava(ProjectId: .PROJECT_OAUTH, Method: .POST)
            
            //MARK: restaurant setting
            case .setting(_):
                return headerJava(ProjectId: .PROJECT_OAUTH, Method: .GET)
            
            case .brands(_, _):
                return headerJava(ProjectId: .PROJECT_ID_DASHBOARD, Method: .GET)
            
            case .branches(_, _):
                return headerJava(ProjectId: .PROJECT_ID_DASHBOARD, Method: .GET)
            
            case .getBrandSetting(_):
                return headerJava(ProjectId: .PROJECT_ID_DASHBOARD, Method: .GET)
            
          
            
            case .postApplyOnlyCashAmount(_):
                return headerJava(ProjectId: .PROJECT_ID_DASHBOARD, Method: .POST)
            
            case  .getApplyOnlyCashAmount(_):
                return headerJava(ProjectId: .PROJECT_ID_DASHBOARD, Method: .GET)
            
            //MARK: ==========
        
            case .orders(_,_,_,_,_):
                return headerJava(ProjectId: PermissionUtils.GPBH_1 ? .PROJECT_ID_ORDER_SMALL : .PROJECT_ID_ORDER,Method: .GET)
            
            case .order(_,_,_,_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
            
            case .foods(_,_,_,_,_,_,_,_,_,_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
            
            case .addFoods(_, _, _, _):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)

            case .addGiftFoods(_, _, _, _):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)

            case .getPrinters(_,_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
            
            case .updatePrinter(_,_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
            
            case .vats:
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)

            case .areas(_, _):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
            
            case .tables(_, _, _, _, _,_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)

            case .addNoteToOrder(_, _, _):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
//                
            case .reasonCancelFoods(_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
            case .cancelFood(_, _, _, _, _):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
            
            case .updateFoods(_, _, _):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)

            case .openTable(_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
            
            case .moveTable(_, _, _):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
            
            case .mergeTable(_, _, _):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)

            case .createArea(_,_,_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
                
            case .foodsManagement(_, _, _, _, _):
                return headerJava(ProjectId: PermissionUtils.GPBH_1 ? .PROJECT_ID_ORDER_SMALL : .PROJECT_ID_ORDER, Method: .GET)
//
            case .categories(_,_,_):
                return headerJava(ProjectId: PermissionUtils.GPBH_1 ? .PROJECT_ID_ORDER_SMALL : .PROJECT_ID_ORDER, Method: .GET)
            
            case .notesManagement(_, _):
                return headerJava(ProjectId: PermissionUtils.GPBH_1 ? .PROJECT_ID_ORDER_SMALL : .PROJECT_ID_ORDER, Method: .GET)
//
            case .createTable(_, _, _, _, _, _):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)

            case .foodsNeedPrint(_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)

            case .createNote(_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
            
            case .createCategory(_, _, _, _, _,_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
            
            case .ordersHistory(_, _, _, _, _, _,_,_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
            
            case .getTotalAmountOfOrders(_,_,_,_,_,_):
                return headerJava(ProjectId: PermissionUtils.GPBH_1 ? .PROJECT_ID_ORDER_SMALL : .PROJECT_ID_ORDER,Method: .GET)
//            case .units:
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            case .createFood(_, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
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
            case .closeTable(_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
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
            case .notes(_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            case .gift(_, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//            case .useGift(_, _, _, _):
//                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)
            case .tablesManager(_, _, _, _):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
//                
            case .notesByFood(_, _):
                return headerJava(ProjectId: .PROJECT_ID_DASHBOARD, Method: .GET)

            case .getFoodsBookingStatus(_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .GET)
            

//                
            case .postCreateOrder(_,_,_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)

            case .postCreateTableList(_,_,_):
                return headerJava(ProjectId: .PROJECT_ID_ORDER, Method: .POST)

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
                
            case .getActivityLog(_,_,_,_,_,_,_,_):
                return headerJava(ProjectId: .PROJECT_ID_LOG, Method: .GET)
                
            //MARK: =========== API REPORT ========
            case .report_revenue_by_time(_, _, _, _, _, _):
                return headerNode(ProjectId: .PROJECT_ID_FINANCE_REPORT, Method: .GET)
            
            case .report_revenue_activities_in_day_by_branch(_, _, _, _, _, _):
                return headerNode(ProjectId: .PROJECT_ID_FINANCE_REPORT, Method: .GET)
            
            case .report_revenue_fee_profit(_,_,_,_,_,_,_):
                return headerNode(ProjectId: .PROJECT_ID_FINANCE_REPORT, Method: .GET)
            
            case .report_revenue_by_category(_, _, _, _, _, _):
                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT, Method: .GET)
            
            case .report_revenue_by_employee(_, _, _, _, _, _, _):
                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT, Method: .GET)
            
            case .report_business_analytics(_, _, _, _, _, _, _, _, _, _, _, _, _):
                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT, Method: .GET)
                
            case .report_employee_revenue(_, _, _, _, _, _):
                return headerNode(ProjectId: .PROJECT_ID_FINANCE_REPORT, Method: .GET)
            
            case .report_food(_,_,_,_,_,_,_,_,_,_,_,_,_):
                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT, Method: .GET)
            
            case .report_cancel_food(_,_,_,_,_,_,_,_,_,_,_,_):
                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT, Method: .GET)
            
            case .report_gifted_food(_,_,_,_,_,_,_,_,_,_,_,_):
                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT, Method: .GET)
            
            case .report_discount(_,_,_,_,_,_):
                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT, Method: .GET)
            
            case .report_VAT(_,_,_,_,_,_):
                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT, Method: .GET)
            
            case .report_area_revenue(_,_,_,_,_,_):
                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT, Method: .GET)
            
            case .report_table_revenue(_,_,_,_,_,_,_):
                return headerNode(ProjectId: .PROJECT_ID_BUSINESS_REPORT, Method: .GET)
            
            case .getReportRevenueGenral(_, _, _, _, _, _):
                return headerNode(ProjectId: .PROJECT_ID_FINANCE_REPORT, Method: .GET)
            
            case .getDailyRevenueReportOfFoodApp(_,_,_,_,_,_,_):
                return headerJava(ProjectId: .PROJECT_ID_BUSINESS_REPORT, Method: .GET)
////==================================================================================================================================================================
 
        }
    }
}
