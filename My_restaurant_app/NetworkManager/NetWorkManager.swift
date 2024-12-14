//
//  ConnectionManager.swift
//  aloline-phamkhanhhuy
//
//  Created by Pham Khanh Huy on 16/02/2024.
//



import UIKit
import AlertToast

let networkManager = NetworkManager.self

enum NetworkManager{
  
    case sessions
    case config(restaurant_name:String)
    case login(username:String, password:String)
    case setting(branch_id:Int)
    case brands(key_search:String = "", status:Int = -1)
    case branches(brand_id:Int, status:Int)
    case getBrandSetting(brand_id:Int)


    case getPrinters(branch_id:Int, status:Int = 1)
    
    case postApplyOnlyCashAmount(branchId:Int)
    case getApplyOnlyCashAmount(branchId:Int)
    case orders(userId:Int, order_status:String, key_word:String = "", branch_id:Int = -1,is_take_away:Int=DEACTIVE)
    
    
    case getOrderDetail(order_id:Int, branch_id:Int)
    case foods(branch_id:Int, area_id:Int = -1, category_id:Int, category_type:Int, is_allow_employee_gift:Int = -1, is_sell_by_weight:Int = -1, is_out_stock:Int = 0, key_word:String = "",limit:Int,page:Int)
    
    case addFoods(branch_id:Int, order_id:Int,foods:[FoodRequest], is_use_point:Int)
    case addGiftFoods(branch_id:Int, order_id:Int, foods:[FoodRequest], is_use_point:Int)
    case kitchenes(branch_id:Int, brand_id:Int, status:Int = 1)
    case vats
    case areas(branch_id:Int, status:Int)
    case tables(branchId:Int, area_id:Int, status:String, exclude_table_id:Int = 0, order_statuses:String = "",buffet_ticket_id:Int = 0)
//    case addFoods(branch_id:Int, order_id:Int, foods:[FoodRequest], is_use_point:Int)
//    case addGiftFoods(branch_id:Int, order_id:Int, foods:[FoodRequest], is_use_point:Int)
//    case kitchenes(branch_id:Int, brand_id:Int, status:Int = 1)
//    case vats
//    case addOtherFoods(branch_id:Int, order_id:Int, foods:OtherFoodRequest)
    case addNoteToOrder(branch_id:Int, order_detail_id:Int, note:String)
    case reasonCancelFoods(branch_id:Int)
    case cancelFood(branch_id:Int, order_id:Int, reason:String, order_detail_id:Int, quantity:Int)
//    case updateFoods(branch_id:Int, order_id:Int, foods:[FoodUpdate])
//    case ordersNeedMove(branch_id:Int, order_id:Int, food_status:String = "")
//    case moveFoods(branch_id:Int, order_id:Int, destination_table_id:Int,target_table_id:Int, foods:[FoodSplitRequest])
//    case getOrderDetail(order_id:Int, branch_id:Int, is_print_bill:Int,food_status:String)
    case openTable(table_id:Int)
//    case discount(order_id:Int, branch_id:Int,food_discount_percent:Int, drink_discount_percent:Int, total_amount_discount_percent:Int, note:String)
//    case moveTable(branch_id:Int, destination_table_id:Int,target_table_id:Int)
//    case mergeTable(branch_id:Int, destination_table_id:Int,target_table_ids:[Int])
//    case profile(branch_id:Int, employee_id:Int)
//    case extra_charges(restaurant_brand_id:Int, branch_id:Int, status:Int)
//    case addExtraCharge(branch_id:Int, order_id:Int, extra_charge_id:Int, name:String, price:Int, quantity:Int, note:String)
//    case returnBeer(branch_id:Int, order_id:Int, quantity:Int, order_detail_id:Int, note:String)
//    case reviewFood(order_id:Int, review_data:[Review])
//    case getFoodsNeedReview(branch_id:Int, order_id:Int)
//    case updateCustomerNumberSlot(branch_id:Int, order_id:Int, customer_slot_number:Int)
//    case requestPayment(branch_id:Int, order_id:Int, payment_method:Int, is_include_vat:Int)
//    case completedPayment(branch_id:Int, order_id:Int, cash_amount:Int, bank_amount:Int, transfer_amount:Int, payment_method_id:Int, tip_amount:Int)
//    
    case createArea(branch_id:Int, area:Area, is_confirm:Int? = nil)
    case foodsManagement(category_id:Int, search_key:String, limit:Int,page:Int)
    case childrenItem
    case categories(brand_id:Int, status:Int = -1,type:Int = -1)
    case notesManagement(branch_id:Int, status:Int = -1)
//    
    case createTable(branch_id:Int, table_id:Int, table_name:String, area_id:Int, total_slot:Int,status:Int)
//    
//    case prints(branch_id:Int, is_have_printer:Int,is_print_bill:Int, status:Int = -1)
//    
//    case openSession(before_cash:Int, branch_working_session_id:Int)
//    
//    case workingSessions(branch_id:Int, empaloyee_id:Int)
//    case checkWorkingSessions
//    
//    case sharePoint(order_id:Int, employee_list:[EmployeeSharePointRequest])
//    case employeeSharePoint(branch_id:Int, order_id:Int)
//    case currentPoint(employee_id:Int)
//    
//    case assignCustomerToBill(order_id:Int, qr_code:String)
//    
//    case fees(branch_id:Int, restaurant_budget_id:Int, from:String, to:String, type:Int, is_take_auto_generated:Int, order_session_id:Int, report_type:Int,addition_fee_statuses:String,is_paid_debt:Int = -1)
//    
//    case applyVAT(branch_id:Int, order_id:Int, is_apply_vat:Int)
//    
//    case createFee(branch_id:Int, type:Int, amount:Int, title:String, note:String, date:String, addition_fee_reason_type_id:Int)
    case foodsNeedPrint(order_id:Int)
//    case requestPrintChefBar(order_id:Int, branch_id:Int, print_type:Int)
//    
//    case updateReadyPrinted(order_id:Int, order_detail_ids:[Int])
//    
//    case employees(branch_id:Int, is_for_share_point:Int)
//    case kitchens(branch_id:Int, status:Int = 1)
////    case updateKitchen(branch_id:Int, kitchen:Kitchen)
////    case updatePrinter(printer:Kitchen)
    case createNote(note:Note)
    case createCategory(id:Int ,name:String, description:String?, type:Int, status:Int)
//    case ordersHistory(brand_id:Int, branch_id:Int,id:Int, report_type:Int, time : String, limit : Int, page : Int, key_search:String,is_take_away_table:Int,is_take_away:Int)
    case units
    case createFood(branch_id:Int, item:Food)
//    case generateFileNameResource(medias:[Media])
//    case updateFood(branch_id:Int, foodRequest:CreateFood)

//    case cities(limit : Int = 200)
//    case districts(city_id:Int ,limit : Int = 200)
//    case wards(district_id:Int, limit : Int = 200)
//    
//    case updateProfile(profileRequest:ProfileRequest)
//    case updateProfileInfo(infoRequest:UserInfoRequest)
//    
//    case changePassword(employee_id:Int, old_password:String, new_password:String, node_access_token:String)
//    case closeTable(table_id:Int)
//   
//    case feedbackDeveloper(email:String, name:String, phone:String, type:Int, describe:String)
//    case sentError(email:String, name:String, phone:String, type:Int, describe:String)
//    case workingSessionValue
//    case closeWorkingSession(closeWorkingSessionRequest:CloseWorkingSessionRequest)
//    case assignWorkingSession(branch_id:Int, order_session_id:Int)
//    case forgotPassword(username:String)
//    case verifyOTP(restaurant_name:String, username:String, verify_code:String)
//    case verifyPassword(username:String, verify_code:String, new_password:String)
//    case notes(branch_id:Int)
//    case gift(qr_code_gift:String = "", branch_id:Int)
//    case useGift(branch_id:Int, order_id:Int, customer_gift_id:Int, customer_id:Int)
    case tablesManager(area_id:Int, branch_id:Int, status:Int, is_deleted:Int = 0)
//    case notesByFood(food_id:Int, branch_id:Int = -1)
//    case getVATDetail(order_id:Int, branch_id:Int)
//    case cancelExtraCharge(branch_id:Int, order_id:Int, reason:String, order_extra_charge:Int, quantity:Int)
////    case vats
//    
//    //======== API REPORT ==========
//    case report_revenue_by_time(restaurant_brand_id:Int, branch_id:Int,report_type:Int, date_string:String = "", from_date:String = "", to_date:String = "")
//    case report_revenue_activities_in_day_by_branch(restaurant_brand_id:Int, branch_id:Int,report_type:Int, date_string:String = "", from_date:String = "", to_date:String = "")
//    
//    case report_revenue_fee_profit(restaurant_brand_id:Int, branch_id:Int,report_type:Int, date_string:String = "", from_date:String = "", to_date:String = "")
//    
//    case report_revenue_by_category(restaurant_brand_id:Int, branch_id:Int,report_type:Int, date_string:String = "", from_date:String = "", to_date:String = "")
//    case report_revenue_by_employee(employee_id:Int, restaurant_brand_id:Int, branch_id:Int,report_type:Int, date_string:String = "", from_date:String = "", to_date:String = "")
//    
//    case report_business_analytics(restaurant_brand_id:Int, branch_id:Int, category_id:Int, category_types:Int, report_type:Int, date_string:String = "", from_date:String = "", to_date:String = "", is_cancelled_food:Int, is_combo:Int, is_gift:Int, is_goods:Int, is_take_away_food:Int)
//
//    case report_revenue_by_all_employee(restaurant_brand_id:Int, branch_id:Int,report_type:Int, date_string:String = "", from_date:String = "", to_date:String = "")
//    
//    case report_food(
//        restaurant_brand_id:Int,
//        branch_id:Int,
//        report_type:Int,
//        date_string:String,
//        from_date:String = "",
//        to_date:String = "",
//        category_id: Int,
//        is_combo:Int,
//        is_goods:Int,
//        is_cancelled_food:Int,
//        is_gift:Int,
//        is_take_away_food:Int
//    )
//    
//    case report_cancel_food(
//        restaurant_brand_id:Int,
//        branch_id:Int,
//        report_type:Int,
//        date_string:String,
//        from_date:String = "",
//        to_date:String = "",
//        category_id: Int,
//        is_combo:Int,
//        is_goods:Int,
//        is_cancelled_food:Int,
//        is_gift:Int,
//        is_take_away_food:Int
//    )
//    
//    case report_gifted_food(
//        restaurant_brand_id:Int,
//        branch_id:Int,
//        report_type:Int,
//        date_string:String,
//        from_date:String = "",
//        to_date:String = "",
//        category_id: Int,
//        is_combo:Int,
//        is_goods:Int,
//        is_cancelled_food:Int,
//        is_gift:Int,
//        is_take_away_food:Int
//    )
//    
//    case report_discount(
//        restaurant_brand_id:Int,
//        branch_id:Int,
//        report_type:Int,
//        date_string:String,
//        from_date:String = "",
//        to_date:String = ""
//    )
//    
//    
//    case report_VAT(
//        restaurant_brand_id:Int,
//        branch_id:Int,
//        report_type:Int,
//        date_string:String,
//        from_date:String = "",
//        to_date:String = ""
//    )
//    
//    
//    case report_area_revenue(
//        restaurant_brand_id:Int,
//        branch_id:Int,
//        report_type:Int,
//        date_string:String,
//        from_date:String = "",
//        to_date:String = ""
//    )
//    
//    case report_table_revenue(
//        restaurant_brand_id:Int,
//        branch_id:Int,
//        area_id:Int,
//        report_type:Int,
//        date_string:String,
//        from_date:String = "",
//        to_date:String = ""
//    )
//    
//    
//    case updateOtherFeed(id: Int, branch_id: Int, brand_id: Int, status: Int)
//    
//    case getAdditionFee(id:Int)
//    case cancelAdditionFee(id:Int, cancel_reason:String, branch_id:Int ,addition_fee_status:Int)
//    case updateAdditionFee(id:Int, date:String, note:String, amount:Int, is_count_to_revenue: Int, object_type:Int, type:Int, payment_method_id: Int , cancel_reason:String, branch_id: Int, object_name:String,addition_fee_status:Int,addition_fee_reason_type_id: Int)
//    case updateOtherFee(id:Int, date:String, note:String, amount:Int, is_count_to_revenue: Int, payment_method_id: Int ,  branch_id: Int, object_name:String,addition_fee_status:Int,addition_fee_reason_type_id: Int)
//
//    case moveExtraFoods(branch_id:Int, order_id:Int,target_order_id: Int, foods:[ExtraFoodSplitRequest])
    case getFoodsBookingStatus(order_id:Int)
//    //API REPORT SEEMT
//    case getReportOrderRestaurantDiscountFromOrder(restaurant_brand_id: Int, branch_id: Int, report_type: Int, date_string: String, from_date: String, to_date: String  ) //@ *2
//    case getOrderReportFoodCancel(restaurant_brand_id:Int, branch_id:Int, type:Int, report_type:Int, date_string:String, from_date:String, to_date:String) //@ *3
//    case getOrderReportFoodGift(restaurant_brand_id:Int, branch_id:Int, type_sort:Int, is_group:Int, report_type:Int, date_string:String, from_date:String, to_date:String) //@ *4
//    case getOrderReportTakeAwayFood(restaurant_brand_id:Int, branch_id:Int, report_type:Int, date_string:String = "", food_id:Int, is_gift:Int, is_cancel_food:Int, key_search:String = "", from_date:String = "", to_date:String = "", page:Int, limit:Int) //@ *5
//    case getRestaurantRevenueCostProfitEstimation(restaurant_brand_id:Int, branch_id: Int,report_type:Int,date_string:String,from_date:String,to_date:String) //@ *6
//    case getOrderCustomerReport(restaurant_brand_id:Int, branch_id: Int, report_type:Int, date_string:String, from_date:String, to_date:String) //@*7
//    case getRestaurantRevenueCostProfitSum(restaurant_brand_id:Int, branch_id: Int,report_type:Int,date_string:String,from_date:String,to_date:String) //@*8
//    case getReportRevenueGenral(restaurant_brand_id: Int, branch_id: Int, report_type: Int, date_string: String, from_date: String, to_date: String) //@ *9
//    case getReportRevenueArea(restaurant_brand_id: Int, branch_id: Int, report_type: Int, date_string: String, from_date: String, to_date: String) //@ *10
//    case getReportRevenueProfitFood(restaurant_brand_id: Int, branch_id: Int, category_types: String, food_id: Int, is_goods: Int, report_type: Int, date_string:String, from_date:String, to_date: String) //@*11
//    case getReportSurcharge(restaurant_brand_id: Int, branch_id: Int, report_type: Int, date_string:String, from_date:String, to_date: String) //@*12
//    case getRestaurantOtherFoodReport(restaurant_brand_id: Int, branch_id: Int, category_types: String, food_id: Int, is_goods: Int, report_type: Int, date_string:String, from_date:String, to_date: String) //@*13
//    case getRestaurantVATReport(restaurant_brand_id:Int, branch_id: Int, report_type:Int, date_string:String, from_date:String, to_date:String)//@*14
//    // ========= API INVENTORY REPORT ==========
//    case getWarehouseSessionImportReport(restaurant_brand_id:Int, branch_id: Int, report_type:Int, date_string:String, from_date:String, to_date:String) //@*15
//    // ========= API REVENUE EMPLOYEE REPORT ==========
//    case getRenueByEmployeeReport(restaurant_brand_id:Int, branch_id: Int, report_type:Int, date_string:String, from_date:String, to_date:String) //@*16
//    case getRestaurantRevenueDetailByBrandId(restaurant_brand_id:Int,branch_id: Int,report_type:Int,from_date:String,to_date:String,date_string:String) //@ *17
//    case getRestaurantRevenueDetailByBranch(restaurant_brand_id:Int,branch_id: Int,report_type:Int,from_date:String,to_date:String,date_string:String) //@ *18
//    case getRestaurantRevenueCostProfitReality(restaurant_brand_id:Int, branch_id: Int,report_type:Int,date_string:String,from_date:String,to_date:String)//@
//    case updateBranch(branchRequest: Branch)
//    case getInfoBranches(IdBranches:Int)
//    case healthCheckChangeDataFromServer(branch_id:Int, restaurant_brand_id:Int, restaurant_id:Int)
//    case healthCheckForBuffet(restaurant_brand_id:Int, branch_id:Int, restaurant_id:Int,buffet_ticket_id:Int)
//    
//    
//    case getLastLoginDevice(device_uid:String,app_type:Int)
//    
//    
    case postCreateOrder(branch_id:Int,table_id:Int,note:String)
//    
//    
//    case getBranchRights(restaurant_brand_id:Int, employee_id:Int)
//    
//    case getTotalAmountOfOrders(restaurant_brand_id:Int,branch_id:Int,is_take_away_table:Int,order_status:String, key_search:String,employee_id:Int,is_take_away:Int,report_type:Int)
//    
//    case postApplyExtraChargeOnTotalBill(order_id:Int,branch_id:Int,total_amount_extra_charge_percent:Int)
//    
//    case postPauseService(order_id:Int, branch_id:Int,order_detail_id:Int)
//    
//    case postUpdateService(order_id:Int, branch_id:Int,order_detail_id:Int,start_time:String,end_time:String,note:String)
//     
//    case getActivityLog(object_id:Int,type:Int,key_search:String,object_type:String,from:String,to:String,page:Int,limit:Int)
//    
//    case postApplyOnlyCashAmount(branchId:Int)
//    case getApplyOnlyCashAmount(branchId:Int)
//    case getVersionApp(os_name: String, key_search: String, is_require_update: Int, limit: Int, page: Int)
//    
//    
//    case postApplyTakeAwayTable(branch_id:Int)
//
    case postCreateTableList(branch_id:Int,tables:[CreateTableQuickly])
//    
//    case getPrintItem(type_print:Int,restaurant_id:Int,branch_id:Int)
//    
//    case getBrandSetting(brand_id:Int)
//    
//    case getSendToKitchen(branch_id:Int,order_id:Int)
//    
//    case postSendToKitchen(branch_id:Int,order_id:Int,item_ids:[Int])
//
//    case getBankAccount(brand_id:Int, type:Int, status:Int)
//    
//    case getBankList
//    
//    case getBrandBankAccount(order_id:Int,brand_id:Int)
//    
//    
    case getBuffetTickets(brand_id:Int,status:Int,key_search:String,limit:Int,page:Int)
    
    case getDetailOfBuffetTicket(branch_id:Int, category_id:Int, buffet_ticket_id:Int, key_search:String, limit:Int, page:Int)
    
    case getFoodsOfBuffetTicket(brand_id:Int,buffet_ticket_id:Int)
  
    case postCreateBuffetTicket(branch_id:Int,order_Id:Int, buffet_id:Int, adult_quantity:Int,adult_discount_percent:Int,child_quantity:Int,chilren_discount_percent:Int)
    
    case postUpdateBuffetTicket(branch_id:Int,order_Id:Int,buffet:Buffet)
    
    case postCancelBuffetTicket(id:Int)
//
    case postDiscountOrderItem(branch_id:Int,orderId:Int,orderItem:OrderItem)
//    
//    
//    // MARK: API for chat
//    case postCreateGroupSuppport
//    case getMessageList(conversation_id:String,arrow:Int,limit:Int,position:String)
//    case getListMedia(type: Int, media_type: String, object_id: String, from: String, to: String, limit: Int, position: String)
//    
//    case postRemovePrintedItem(branch_id:Int,key:String)
}
//
//    
////==================================================================================================================================================================
extension NetworkManager{
    
    static func callAPI(netWorkManger:NetworkManager,completion: @escaping (Result<Data, Error>) -> Void) {

        @Injected(\.utils) var util
    
        var components = URLComponents(string: environmentMode.baseUrl)
        components?.scheme = "http"
//        components.host = environmentMode.baseUrl
        components?.path = netWorkManger.path
        

        //============================================ Define parameter for method get=================================================
        dLog(netWorkManger.method)
        if netWorkManger.method == .POST || netWorkManger.method == .PATCH{
            print(String(format: "%@://%@%@", components?.scheme ?? "http", components?.host ?? "", components?.path ?? ""))
        }else{
            var queryItems:[URLQueryItem] = []
            
            for (key, value) in netWorkManger.task {
                queryItems.append(URLQueryItem(name: key, value: value as? String ?? ""))
            }
            
            components?.queryItems = queryItems
        }
        
        
        guard let url = components?.url else {
            
            print(components)
//            
//            var errorTemp = Error(domain:"", code:httpResponse.statusCode, userInfo:nil)
            
            return
        }
        
        var request = URLRequest(url: url)
        
        //============================================ Define method  =================================================
        request.httpMethod = netWorkManger.method.description
        
        
        //============================================ Define header  =================================================
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        for (key, value) in netWorkManger.headers ?? [:] {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        

        //============================================ Log API  =================================================
        for (key, value) in request.allHTTPHeaderFields ?? [:] {
            print(String(format: "%@: %@", key,value))
        }
     
        
        
      
        //============================================ Define body for method post  =================================================
        if netWorkManger.method == .POST || netWorkManger.method == .PATCH{
           
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: netWorkManger.task, options: [.prettyPrinted])
                // Step 4: Assign JSON data to the request's httpBody
                if let jsonString = String(data: jsonData,encoding: .utf8) {
                    print("JSON String: \(jsonString)")
                    
                }
                request.httpBody = jsonData
            
            }catch let error{
                completion(.failure(error))
            }
                    // Step 5: Set the content type he
            
        }
        
        print("\n\n\n")
        
        DispatchQueue.main.async {
//            util.toastUtils.subject.send(true)
        }
        print(components)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in

           
            DispatchQueue.main.async {
                
//                util.toastUtils.subject.send(false)

                
                if let data = data {
                    completion(.success(data))
                } else {
                    // Error: API request failed
                    if let error = error {
    //                    utils.toastUtils.show = false
                        completion(.failure(error))
                       
                    }
                    return
                }
            }
        
        }
        task.resume()
    }
}   

