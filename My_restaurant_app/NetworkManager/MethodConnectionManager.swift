//
//  MethodConnectionParameter.swift
//  aloline-phamkhanhhuy
//
//  Created by Pham Khanh Huy on 16/02/2024.
//



extension NetworkManager{
    
    var method: Method {
        switch self{
            
            case .sessions:
                return .GET
            
            case .config(_):
                return .GET
            
            case .login(_,_):
                return .POST
            
            case .setting(_):
                return .GET
            
            case .brands(_, _):
                return .GET
            case .branches(_, _):
                return .GET
            case .getBrandSetting(_):
                return .GET
            
            case .getPrinters(_,_):
                return .GET
            
            case .postApplyOnlyCashAmount(_):
                return .POST
            
            case  .getApplyOnlyCashAmount(_):
                return .GET
            
            case .orders(_, _, _, _,_):
                return .GET
            
            
            

            case .getOrderDetail(_, _):
                return .GET
            case .foods(_,_,_,_,_,_,_,_,_,_):
                return .GET
            case .addFoods(_, _, _, _):
                return .POST
            case .addGiftFoods(_, _, _, _):
                return .POST
            case .kitchenes(_, _, _):
                return .GET
            case .vats:
                return .GET
//            case .addOtherFoods(_, _, _):
//                return .POST
//            case .addNoteToOrderDetail(_, _, _):
//                return .POST
            case .reasonCancelFoods(_):
                return .GET
            case .cancelFood(_, _, _, _, _):
                return .POST
//            case .ordersNeedMove(_, _, _):
//                return .GET
//            case .updateFoods(_, _, _):
//                return .POST
//
//            case .moveFoods(_, _, _, _, _):
//                return .POST
//            case .getOrderDetail(_, _, _, _):
//                return .GET
            case .openTable(_):
                return .POST
//            case .discount(_,_,_,_,_,_):
//                return .POST
//            case .moveTable(_, _, _):
//                return .POST
//            case .mergeTable(_, _, _):
//                return .POST
//            case .profile(_, _):
//                return .GET
//            case .extra_charges(_, _, _):
//                return .GET
//            case .addExtraCharge(_, _, _,_, _, _, _):
//                return .POST
//            case .returnBeer(_, _, _, _, _):
//                return .POST
//            case .reviewFood(_, _):
//                return .POST
//
//            case .getFoodsNeedReview(_, _):
//                return .GET
//            case .updateCustomerNumberSlot(_, _, _):
//                return .POST
//            case .requestPayment(_, _, _, _):
//                return .POST
//            case .completedPayment(_, _, _, _, _, _, _):
//                return .POST
//            

//        switch self {
//            case .sessions:
//                return .get
//            case .config(_):
//                return .get
//            case .checkVersion:
//                return .get
//            case .regisDevice(_):
//                return .post
//            case .login(_, _):
//                return .post
//            case .setting(_):
//                return .get
            case .areas(_, _):
                return .GET
            
            case .tables(_, _, _, _, _,_):
                return .GET
//            case .brands(_, _):
//                return .get
//            case .branches(_, _):
//                return .get
//            case .orders(_, _, _, _,_):
//                return .get
//            case .order(_, _):
//                return .get
//            case .foods(_,_,_,_,_,_,_,_,_,_):
//                return .get
//            case .addFoods(_, _, _, _):
//                return .post
//            case .addGiftFoods(_, _, _, _):
//                return .post
//            case .kitchenes(_, _, _):
//                return .get
//            case .vats:
//                return .get
//            case .addOtherFoods(_, _, _):
//                return .post
            case .addNoteToOrder(_, _, _):
                return .POST
//            case .reasonCancelFoods(_):
//                return .get
//            case .cancelFood(_, _, _, _, _):
//                return .post
//            case .ordersNeedMove(_, _, _):
//                return .get
//            case .updateFoods(_, _, _):
//                return .post
//                
//            case .moveFoods(_, _, _, _, _):
//                return .post
//            case .getOrderDetail(_, _, _, _):
//                return .get
//            case .openTable(_):
//                return .post
//            case .discount(_,_,_,_,_,_):
//                return .post
//            case .moveTable(_, _, _):
//                return .post
//            case .mergeTable(_, _, _):
//                return .post
//            case .profile(_, _):
//                return .get
//            case .extra_charges(_, _, _):
//                return .get
//            case .addExtraCharge(_, _, _,_, _, _, _):
//                return .post
//            case .returnBeer(_, _, _, _, _):
//                return .post
//            case .reviewFood(_, _):
//                return .post
//                
//            case .getFoodsNeedReview(_, _):
//                return .get
//            case .updateCustomerNumberSlot(_, _, _):
//                return .post
//            case .requestPayment(_, _, _, _):
//                return .post
//            case .completedPayment(_, _, _, _, _, _, _):
//                return .post
//                
////            case .tablesManagement(_, _, _):
////                return .get
            case .createArea(_,let area ,_):
                return  area.id == 0 ?  .POST : .PATCH
                
            case .foodsManagement(_, _, _, _):
                return .GET
            
            case .childrenItem:
                return .GET
            
            case .categories(_,_,_):
                return .GET
            
            case .notesManagement(_, _):
                return .GET
            
            case .createTable(_, let table_id, _, _, _, _):
                return  table_id > 0 ?  .PATCH : .POST
//            case .prints(_, _, _, _):
//                return .post
//            case .openSession(_, _):
//                return .post
//                
//            case .workingSessions(_, _):
//                return .get
//            case .checkWorkingSessions:
//                return .get
//            case .sharePoint(_, _):
//                return .post
//            case .employeeSharePoint(_, _):
//                return .get
//            case .currentPoint(_):
//                return .get
//            case .assignCustomerToBill(_, _):
//                return .post
//            case .applyVAT(_, _, _):
//                return .post
//            case .fees(_, _, _, _, _, _, _, _, _, _):
//                return .get
//            case .createFee(_, _, _, _, _, _, _):
//                return .post
            case .foodsNeedPrint(_):
                return .GET
//            case .requestPrintChefBar(_, _, _):
//                return .post
//            case .updateReadyPrinted(_, _):
//                return .post
//            case .employees(_, _):
//                return .get
//            case .kitchens(_, _):
//                return .get
////            case .updateKitchen(_, _):
////                return .post
////            case .updatePrinter(_):
//                return .post
            case .createNote(_):
                return .POST
            case .createCategory(let id, _, _, _,_):
                return  id > 0 ?  .PATCH : .POST
//            case .ordersHistory(_, _, _, _, _, _,_,_,_,_):
//                return .get
//            
            case .units:
                return .GET
            
            case .createFood(_, let item):
                return  item.id > 0 ?  .PATCH : .POST
//            case .generateFileNameResource(_):
//                return .post
//            case .updateFood(_, _):
//                return .post
//            case .updateCategory(_, _, _, _, _, _):
//                return .post
//            case .cities(_):
//                return .get
//                
//            case .districts(_,_):
//                return .get
//            case .wards(_,_):
//                return .get
//                
//            case .updateProfile(_):
//                return .post
//                
//            case .updateProfileInfo(_):
//                return .post
//            case .changePassword(_, _, _, _):
//                return .post
//                
//            case .closeTable(_):
//                return .post
//                
//            case .feedbackDeveloper(_, _, _, _, _):
//                return .post
//            case .sentError(_, _, _, _, _):
//                return .post
//            case .workingSessionValue:
//                return .get
//            case .closeWorkingSession(_):
//                return .post
//            case .assignWorkingSession(_, _):
//                return .post
//            case .forgotPassword(_):
//                return .post
//                
//            case .verifyOTP(_, _, _):
//                return .post
//                
//            case .verifyPassword(_, _, _):
//                return .post
//            case .notes(_):
//                return .get
//            case .gift(_, _):
//                return .get
//            case .useGift(_, _, _, _):
//                return .post
            case .tablesManager(_, _, _,_):
                return .GET
//            case .notesByFood(_, _):
//                return .get
//            case .getVATDetail(_, _):
//                return .get
//                //=========== API REPORT ========
//            case .report_revenue_by_time(_, _, _, _, _, _):
//                return .get
//            case .report_revenue_activities_in_day_by_branch(_, _, _, _, _, _):
//                return .get
//                
//            case .report_revenue_fee_profit(_, _, _, _, _, _):
//                return .get
//            case .report_revenue_by_category(_, _, _, _, _, _):
//                return .get
//            case .report_revenue_by_employee(_, _, _, _, _, _, _):
//                return .get
//            case .report_business_analytics(_, _, _, _, _, _, _, _, _, _, _, _, _):
//                return .get
//            case .report_revenue_by_all_employee(_, _, _, _, _, _):
//                return .get
//          
//            case .cancelExtraCharge(branch_id: let branch_id, order_id: let order_id, reason: let reason, order_extra_charge: let order_extra_charge, let quantity):
//                return .post
//                
//            case .report_food(_,_,_,_,_,_,_,_,_,_,_,_):
//                return .get
//            case .report_cancel_food(_,_,_,_,_,_,_,_,_,_,_,_):
//                return .get
//            case .report_gifted_food(_,_,_,_,_,_,_,_,_,_,_,_):
//                return .get
//            case .report_discount(_,_,_,_,_,_):
//                return .get
//            case .report_VAT(_,_,_,_,_,_):
//                return .get
//            case .report_area_revenue(_,_,_,_,_,_):
//                return .get
//            case .report_table_revenue(_,_,_,_,_,_,_):
//                return .get
//                
//            case .updateOtherFeed(_, _, _, _):
//                return .get
//                
//            case .getAdditionFee(_):
//                return .get
//            case .updateAdditionFee(_,_,_,_,_,_,_,_,_,_,_,_,_):
//                return .post
//            case .cancelAdditionFee(_, _, _, _):
//                return .post
//
//            case .updateOtherFee(_,_,_,_,_,_,_,_,_,_):
//                return .post
//
//            case .moveExtraFoods(branch_id: let branch_id, order_id: let order_id, target_order_id: let target_order_id, foods: let foods):
//                return .post
            case .getFoodsBookingStatus(_):
                return .GET
//            case .updateBranch(_):
//                return .post
//                
//            //API REPORT SEEMT
//            case .getReportOrderRestaurantDiscountFromOrder(_, _, _, _, _, _):
//                return .get //@
//                
//            case .getOrderReportFoodCancel(_, _, _, _, _, _, _):
//                return .get //@
//            case .getOrderReportFoodGift(_, _, _, _, _, _, _, _):
//                return .get//@
//                
//            case .getRestaurantRevenueCostProfitEstimation(_,_,_,_,_,_):
//                return .get
//                
//            case .getOrderReportTakeAwayFood(_, _, _, _, _, _, _, _, _, _, _, _):
//                return .get
//                
//            case .getOrderCustomerReport(_,_,_,_,_,_):
//                return .get
//            case .getReportRevenueGenral(_, _, _, _, _, _):
//                return .get
//                
//            case .getReportRevenueArea(_, _, _, _, _, _):
//                return .get
//                
//            case .getReportSurcharge(_, _, _, _, _, _):
//                return .get
//                
//            case .getReportRevenueProfitFood(_, _, _, _, _, _, _, _, _):
//                return .get
//                
//            case .getRestaurantOtherFoodReport(_, _, _, _, _, _, _, _, _):
//                return .get
//                
//            case .getRestaurantVATReport(_, _, _, _, _, _):
//                return .get
//                
//            case .getWarehouseSessionImportReport(_, _, _, _, _, _):
//                return .get
//                
//            case .getRenueByEmployeeReport(_, _, _, _, _, _):
//                return .get//@
//                
//            case .getRestaurantRevenueDetailByBrandId(_,_,_,_,_,_):
//                return .get
//                
//            case .getRestaurantRevenueDetailByBranch(_,_,_,_,_,_):
//                return .get
//                
//            case .getRestaurantRevenueCostProfitSum(_,_,_,_,_,_):
//                return .get
//                
//            case .getRestaurantRevenueCostProfitReality(_,_,_,_,_,_):
//                return .get
//                
//            case .getInfoBranches(_):
//                return .get
//            case .healthCheckChangeDataFromServer(_,_,_):
//                return .get
//            
//            case .healthCheckForBuffet(_,_,_,_):
//                return .get
//                
//            case .getLastLoginDevice(_,_):
//                return .get
//                
            case .postCreateOrder(_,_,_):
                return .POST
//                
//            case .getBranchRights(_,_):
//                return .get
//                
//            case .getTotalAmountOfOrders(_,_,_,_,_,_,_,_):
//                return .get
//             
//            case .postApplyExtraChargeOnTotalBill(_,_,_):
//                return .post
//            
//            case .postPauseService(_,_,_):
//                return .post
//                
//            case .postUpdateService(_,_,_,_,_,_):
//                return .post
//            
//            case .getActivityLog(_,_,_,_,_,_,_,_):
//                return .get
//                
//            case .postApplyOnlyCashAmount(_):
//                return .post
//            case  .getApplyOnlyCashAmount(_):
//                return .get
//                
//            case .getVersionApp(_, _, _, _, _):
//                return .get
//                
//            case .postApplyTakeAwayTable(_):
//                return .post
//                
            case .postCreateTableList(_,_):
                return .POST
//
//            case .getPrintItem(_,_,_):
//                return .get
//            
//            case .getBrandSetting(_):
//                return .get
//            
//            case .getSendToKitchen(_,_):
//                return .get
//            
//            case .postSendToKitchen(_,_,_):
//                return .post
//            
//            case .getBankAccount(_, _, _):
//                return .get
//            
//            case .getBankList:
//                return .get
//            
//            case .getBrandBankAccount(_,_):
//                return .get
//            
////            case .postCreateBrandBankAccount(_,_):
////                return .post
////                
////            case .postUpdateteBrandBankAccount(_,_):
////                return .post
//            
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
////
            case .postDiscountOrderItem(_,_,_):
                return .POST
//            
//            
//            // MARK: API for chat
//            case .postCreateGroupSuppport:
//                return .post
//            case .getMessageList(_,_,_,_):
//                return .get
//            case .getListMedia(_, _, _, _, _, _, _):
//                return .get
//            
//            case .postRemovePrintedItem(_,_):
//                return .post
//            
//            
//            
////==================================================================================================================================================================
   
        }
    }
}
