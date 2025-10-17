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

    //MARK: authentication
    case sessions
    case config(restaurant_name:String)
    case login(username:String, password:String)
    case loginUsingCode(code:String,device_uid:String,device_name:String,app_type:Int)
    case getCodeAuthenticationList
    case postCreateAuthenticationCode(expire_at:String, code:String)
    case postChangeStatusOfAuthenticationCode(id:Int)
    
    
    //MARK: restaurant setting
    case setting(branch_id:Int)
    case brands(key_search:String = "", status:Int = -1)
    case branches(brand_id:Int, status:Int)
    case getBrandSetting(brand_id:Int)

   
    
    case postApplyOnlyCashAmount(branchId:Int)
    case getApplyOnlyCashAmount(branchId:Int)
    
    
    //MARK: ============
//    case orders(brand_id:Int,branch_id:Int, order_status:String, area_id:Int = -1,page_number:Int=1000)
    case orders(brand_id:Int,branch_id:Int,userId:Int,order_methods:String,order_status:String)
    
    case order(order_id:Int, branch_id:Int,is_print_bill:Int = DEACTIVE,food_status:String = "")
    case foods(branch_id:Int, area_id:Int = -1, category_id:Int, category_type:Int, is_allow_employee_gift:Int = -1, is_sell_by_weight:Int = -1, is_out_stock:Int = 0, key_word:String = "",limit:Int,page:Int)
    case addFoods(branch_id:Int, order_id:Int,foods:[FoodRequest], is_use_point:Int)
    case addGiftFoods(branch_id:Int, order_id:Int, foods:[FoodRequest], is_use_point:Int)
    case getPrinters(branch_id:Int, status:Int = 1)
    case updatePrinter(branch_id:Int, printer:Printer)
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
    case updateFoods(branch_id:Int, order_id:Int, orderItemUpdate:[OrderItemUpdate])
    case ordersNeedMove(branch_id:Int, order_id:Int, food_status:String = "")
    case moveFoods(branch_id:Int, order_id:Int, destination_table_id:Int,target_table_id:Int, foods:[FoodSplitRequest])
//    case getOrderDetail(order_id:Int, branch_id:Int, is_print_bill:Int,food_status:String)
    case openTable(table_id:Int)
//    case discount(order_id:Int, branch_id:Int,food_discount_percent:Int, drink_discount_percent:Int, total_amount_discount_percent:Int, note:String)
    case moveTable(branch_id:Int, from:Int,to:Int)
    case mergeTable(branch_id:Int, destination_table_id:Int,target_table_ids:[Int])
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
    case foodsManagement(branch_id:Int, is_addition:Int, status:Int = -1, category_types:Int = -1, restaurant_kitchen_place_id:Int = -1)
    case categories(brand_id:Int, status:Int = -1,category_types:String = "")
    case notesManagement(branch_id:Int, status:Int = -1)
//    
    case createTable(branch_id:Int, table_id:Int, table_name:String, area_id:Int, total_slot:Int,status:Int)

    case foodsNeedPrint(order_id:Int)

    case createNote(note:Note)
    
    case createCategory(id:Int ,name:String, code:String, description:String, categoryType:Int, status:Int)
    
    case ordersHistory(
        brand_id:Int,
        branch_id:Int,
        from_date:String,
        to_date:String,
        order_status:String,
        limit:Int,
        page:Int,
        key_search:String
    )
    
    case getTotalAmountOfOrders(restaurant_brand_id:Int,branch_id:Int,order_status:String, key_search:String,from_date:String,to_date:String)

    case closeTable(order_id:Int)

    case notes(branch_id:Int)

    case tablesManager(area_id:Int, branch_id:Int, status:Int, is_deleted:Int = 0)
    
    case notesByFood(food_id:Int, branch_id:Int = -1)

    case getFoodsBookingStatus(order_id:Int)
  
    case postCreateOrder(branch_id:Int,table_id:Int,note:String)

    case postCreateTableList(branch_id:Int,area_id:Int,tables:[CreateTableQuickly])
   
    case getBuffetTickets(brand_id:Int,status:Int,key_search:String,limit:Int,page:Int)
    
    case getDetailOfBuffetTicket(branch_id:Int, category_id:Int, buffet_ticket_id:Int, key_search:String, limit:Int, page:Int)
    
    case getFoodsOfBuffetTicket(brand_id:Int,buffet_ticket_id:Int)
  
    case postCreateBuffetTicket(branch_id:Int,order_Id:Int, buffet_id:Int, adult_quantity:Int,adult_discount_percent:Int,child_quantity:Int,chilren_discount_percent:Int)
    
    case postUpdateBuffetTicket(branch_id:Int,order_Id:Int,buffet:Buffet)
    
    case postCancelBuffetTicket(id:Int)

    case postDiscountOrderItem(branch_id:Int,orderId:Int,orderItem:OrderItem)
    
    case getActivityLog(object_id:Int,type:Int,key_search:String,object_type:String,from:String,to:String,page:Int,limit:Int)
    
    
    //======== API REPORT ==========
    case report_revenue_by_time(restaurant_brand_id:Int, branch_id:Int,report_type:Int, date_string:String = "", from_date:String = "", to_date:String = "")
    case report_revenue_activities_in_day_by_branch(restaurant_brand_id:Int, branch_id:Int,report_type:Int, date_string:String = "", from_date:String = "", to_date:String = "")
    
    case report_revenue_fee_profit(restaurant_brand_id:Int, branch_id:Int,is_count_to_revenue:Int,report_type:Int, date_string:String = "", from_date:String = "", to_date:String = "")
    
    case report_revenue_by_category(restaurant_brand_id:Int, branch_id:Int,report_type:Int, date_string:String = "", from_date:String = "", to_date:String = "")
    case report_revenue_by_employee(employee_id:Int, restaurant_brand_id:Int, branch_id:Int,report_type:Int, date_string:String = "", from_date:String = "", to_date:String = "")
    
    case report_business_analytics(restaurant_brand_id:Int, branch_id:Int, category_id:Int, category_types:Int, report_type:Int, date_string:String = "", from_date:String = "", to_date:String = "", is_cancelled_food:Int, is_combo:Int, is_gift:Int, is_goods:Int, is_take_away_food:Int)

    case report_employee_revenue(restaurant_brand_id:Int, branch_id:Int,report_type:Int, date_string:String = "", from_date:String = "", to_date:String = "")
    
    case report_food(
        restaurant_brand_id:Int,
        branch_id:Int,
        report_type:Int,
        date_string:String,
        from_date:String = "",
        to_date:String = "",
        category_id: Int,
        category_types: String,
        is_combo:Int,
        is_goods:Int,
        is_cancelled_food:Int,
        is_gift:Int,
        is_take_away_food:Int
    )
    
    case report_cancel_food(
        restaurant_brand_id:Int,
        branch_id:Int,
        report_type:Int,
        date_string:String,
        from_date:String = "",
        to_date:String = "",
        category_id: Int,
        is_combo:Int,
        is_goods:Int,
        is_cancelled_food:Int,
        is_gift:Int,
        is_take_away_food:Int
    )
    
    case report_gifted_food(
        restaurant_brand_id:Int,
        branch_id:Int,
        report_type:Int,
        date_string:String,
        from_date:String = "",
        to_date:String = "",
        category_id: Int,
        is_combo:Int,
        is_goods:Int,
        is_cancelled_food:Int,
        is_gift:Int,
        is_take_away_food:Int
    )
    
    case report_discount(
        restaurant_brand_id:Int,
        branch_id:Int,
        report_type:Int,
        date_string:String,
        from_date:String = "",
        to_date:String = ""
    )
    
    
    case report_VAT(
        restaurant_brand_id:Int,
        branch_id:Int,
        report_type:Int,
        date_string:String,
        from_date:String = "",
        to_date:String = ""
    )
    
    
    case report_area_revenue(
        restaurant_brand_id:Int,
        branch_id:Int,
        report_type:Int,
        date_string:String,
        from_date:String = "",
        to_date:String = ""
    )
    
    case report_table_revenue(
        restaurant_brand_id:Int,
        branch_id:Int,
        area_id:Int,
        report_type:Int,
        date_string:String,
        from_date:String = "",
        to_date:String = ""
    )
    
    
    
    case getReportRevenueGenral(restaurant_brand_id: Int, branch_id: Int, report_type: Int, date_string: String, from_date: String, to_date: String) //@ *9
    
    case getDailyRevenueReportOfFoodApp(restaurant_id:Int,restaurant_brand_id:Int,branch_id:Int,food_channel_id:Int,date_string:String,report_type:Int,hour_to_take_report:Int)
}
  
////==================================================================================================================================================================


extension NetworkManager{
    
    static func makeQueryItems(from parameters: [String: Any]) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        
        for (key, value) in parameters {
            let stringValue: String
            
            switch value {
                case let v as String:
                    stringValue = v
                case let v as CustomStringConvertible:
                    stringValue = v.description
                default:
                    continue // Skip values that can't be converted to String
            }
            
            queryItems.append(URLQueryItem(name: key, value: stringValue))
        }
        
        return queryItems
    }
    
    static func makeRequest(from netWorkManger: NetworkManager, url: URL) throws -> URLRequest {
        var request = URLRequest(url: url)

        // Set HTTP method
        request.httpMethod = netWorkManger.method.description
        // Set headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        for (key, value) in netWorkManger.headers ?? [:] {
            request.setValue(value, forHTTPHeaderField: key)
        }

        // Set body for POST, PUT, PATCH
        if [.POST, .PUT, .PATCH].contains(netWorkManger.method) {
            
            let jsonData = try JSONSerialization.data(withJSONObject: netWorkManger.task.body, options: [.prettyPrinted])
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                dLog("JSON String: \(jsonString)")
            }
            
            request.httpBody = jsonData
        }

        return request
    }
    
    static func callAPI<T: Decodable>(
        logRequest: Bool = true,
        netWorkManger: NetworkManager,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        @Injected(\.utils) var util
        

        util.toastUtils.subject.send(true)
        
        var components = URLComponents(string: environmentMode.baseUrl)
        components?.scheme = "https"
        components?.path = netWorkManger.path

        // Add query items for GET-like methods
        if ![.POST, .PUT, .PATCH].contains(netWorkManger.method),
            let query = netWorkManger.task.query {
            components?.queryItems = makeQueryItems(from: query)
        }

        guard let url = components?.url else {
            dLog("Invalid URL: \(components?.description ?? "nil")")
            return
        }

        do {
            let request = try makeRequest(from: netWorkManger, url: url)

            if logRequest {
                dLog("Method: \(netWorkManger.method.description)")
                request.allHTTPHeaderFields?.forEach { dLog("\($0.key): \($0.value)") }
                dLog("URL: \(url.absoluteString)")
            }

            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                util.toastUtils.subject.send(false)

                DispatchQueue.main.async {
                 
                    
                    if let error = error {
                        completion(.failure(error))
                        return
                    }

                    guard let data = data else {
                        completion(.failure(NSError(domain: "No data", code: -1)))
                        return
                    }

                    do {
                        let decoded = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decoded))
                    } catch {
                        dLog("❌ Decoding error: \(error)")
                        completion(.failure(error))
                    }
                }
            }

            task.resume()
            
        } catch {
            
            completion(.failure(error))
            
        }
        
    }


}


extension NetworkManager{
    
    static func callAPIAsync<T: Decodable>(logRequest: Bool = true,netWorkManger: NetworkManager) async throws -> T {
        @Injected(\.utils) var util
        util.toastUtils.subject.send(true)
        
        var components = URLComponents(string: environmentMode.baseUrl)
        components?.scheme = "https"
        components?.path = netWorkManger.path

        // Add query items
        if ![.POST, .PUT, .PATCH].contains(netWorkManger.method),
           let query = netWorkManger.task.query {
            components?.queryItems = makeQueryItems(from: query)
        }

        guard let url = components?.url else {
            util.toastUtils.subject.send(false)
            dLog("❌ Invalid URL: \(components?.description ?? "nil")")
            throw NetworkError.invalidURL
        }

        let request = try makeRequest(from: netWorkManger, url: url)

        if logRequest {
            dLog("📡 Method: \(netWorkManger.method.description)")
            request.allHTTPHeaderFields?.forEach { dLog("\($0.key): \($0.value)") }
            dLog("🌐 URL: \(url.absoluteString)")
        }

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            util.toastUtils.subject.send(false)
            
            

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                return decoded
            } catch {
                dLog("❌ Decoding error: \(error)")
                throw NetworkError.decodingError(error)
            }
            
        
        } catch {
            util.toastUtils.subject.send(false)
            dLog("❌ Transport/network error: \(error)")
            throw NetworkError.transportError(error)
        }
    }
    
    /// A non-throwing async variant that wraps the throwing version
      static func callAPIResultAsync<T: Decodable>(logRequest: Bool = true,netWorkManger: NetworkManager) async -> Result<T, Error> {
          do {
              let response: T = try await callAPIAsync(logRequest: logRequest,netWorkManger: netWorkManger)
              return .success(response)
          } catch {
              return .failure(error)
          }
      }

}

enum NetworkError: Error {
    case invalidURL
    case serverError(String)
    case decodingError(Error)
    case transportError(Error)
}
