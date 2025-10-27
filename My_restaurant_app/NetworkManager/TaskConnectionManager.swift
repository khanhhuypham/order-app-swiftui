//
//  TaskConnectionManager.swift
//  aloline-phamkhanhhuy
//
//  Created by Pham Khanh Huy on 16/02/2024.
//

import UIKit



struct APIParam{
    var query:[String:Any]? = nil
    var body:Any? = nil
    
    init(query: [String : Any]? = nil, body: Any? = nil) {
        self.query = query
        self.body = body
    }
}

extension NetworkManager{


    var task:APIParam {
        switch self{
            //MARK: authentication
        case .sessions:
            return APIParam(query:["device_uid":UIDevice.current.identifierForVendor!.uuidString.lowercased()])
            
            
        case .config(let restaurant_name):
            return APIParam(query:[
                "project_id": Constants.apiKey,
                "device_uid": UIDevice.current.identifierForVendor!.uuidString.lowercased(),
                "restaurant_name": restaurant_name
            ])
            
            
            
        case .login(let username, let password):
            return APIParam(body:[
                "username": username,
                "password": GeneralUtils.encoded(str: password),
                "device_uid":GeneralUtils.getUDID(),
                "app_type":String(GeneralUtils.getAppType()),
                "push_token": ""
            ])
            
        case .loginUsingCode(let code,let device_uid,let device_name,let app_type):
            return APIParam(body:[
                "code": code,
                "device_uid":device_uid,
                "device_name":device_name,
                "app_type":app_type,
            ])
            
            
        case .getCodeAuthenticationList:
            return APIParam(query:[:])
            
        case .postCreateAuthenticationCode(let expire_at,let code):
            return APIParam(body:["expire_at": expire_at,"code":code])
            
        case .postChangeStatusOfAuthenticationCode(_):
            return APIParam(body:[:])
            
            
            //MARK: restaurant setting
        case .setting(let branch_id):
            
            return APIParam(query:[
                "branch_id":String(branch_id),
                "udid":UIDevice.current.identifierForVendor!.uuidString.lowercased(),
                "app_type":String(11)
            ])
            
        case .brands(let key_search, let status):
            
            return APIParam(query:[
                "key_search": key_search,
                "status":String(status)
            ])
            
            
            
        case .branches(let brand_id, let status):
            return APIParam(query:[
                "restaurant_brand_id": String(brand_id),
                "status": String(status)
            ])
            
        case .getBrandSetting(_):
            return APIParam(query:[:])
            
            
        case .postApplyOnlyCashAmount(_):
            return  APIParam(query:[:])
            
            
        case .getApplyOnlyCashAmount(_):
            return  APIParam(query:[:])
            
            //MARK: ===================
        case .orders(let brand_id,let branch_id,let user_id,let order_methods,let order_status,let limit, let page):
            return APIParam(query:[
                "restaurant_brand_id": brand_id,
                "branch_id": branch_id,
                "id":user_id,
                "order_status": order_status,
                "order_methods":order_methods,
                "page":page,
                "limit":limit
            ])
            
            
        case .order(let order_id, let branch_id, let is_print_bill, let food_status):
            
            return APIParam(query:[
                "id": String(order_id),
                "branch_id": String(branch_id),
                "is_print_bill": is_print_bill.description,
                "food_status": food_status
            ])
            
        case .foods(let branch_id, let area_id, let category_id, let category_type, let is_allow_employee_gift, let is_sell_by_weight, let is_out_stock, let keyword, let limit, let page):
            
            return APIParam(query:[
                "branch_id":branch_id,
                "area_id": area_id,
                "category_id": category_id,
                "category_type": category_type,
                "is_allow_employee_gift": is_allow_employee_gift,
                "is_sell_by_weight": is_sell_by_weight,
                "is_out_stock": is_out_stock,
                "key_search": keyword,
                "is_get_restaurant_kitchen_place": ALL,
                "status":ACTIVE,
                "limit": limit,
                "page": page
            ])
            
            
        case .addFoods(let branch_id, let order_id, let foods, let is_use_point):
            
            return APIParam(body:[
                "branch_id": branch_id.description,
                "order_id": order_id.description,
                "foods": foods.map{item in
                    
                    var parameters: [String: Any] = [
                        "id": item.id,
                        "quantity": item.quantity,
                        "note": item.note,
                        "is_use_point": item.is_use_point,
                        "customer_order_detail_id": item.customer_order_detail_id,
                        "addition_foods": item.addition_foods.toDictionary(),
                        "buy_one_get_one_foods": item.buy_one_get_one_foods.toDictionary(),
                        "discount_percent": item.discount_percent,
                        "food_option_foods": item.food_option_foods
                    ]
                    
                    if item.price > 0 {
                        parameters["price"] = item.price
                    }
                    
                    return parameters
                    
                },
                "is_use_point": is_use_point.description
            ])
            
        case .addGiftFoods(let branch_id, let order_id, let foods, let is_use_point):
            return APIParam(body:[
                "branch_id": branch_id.description,
                "order_id": order_id.description,
                "is_use_point":is_use_point.description
            ])
            
            
            
        case .getPrinters(let branch_id, let status):
            return APIParam(query:[
                "branch_id":String(branch_id),
                "status":String(status)
            ])
            
        case .updatePrinter(let branch_id, let printer):
            return APIParam(body:[
                "branch_id":branch_id,
                "name":printer.name,
                "id":printer.id,
                "type": printer.type.rawValue,
                "description":printer.description,
                "printer_name":printer.printer_name,
                "printer_ip_address":printer.ip_address,
                "printer_port":printer.port,
                "printer_paper_size":printer.paper_size,
                "print_number":printer.number_of_copies,
                "is_have_printer":printer.active ? ACTIVE : DEACTIVE,
                "is_print_each_food":printer.print_each_paper ? ACTIVE : DEACTIVE,
                "status":printer.status,
                "printer_type":printer.connection_type.rawValue
            ])
            
        case .vats:
            return  APIParam(query:[:])
            
            
            
            
        case .areas(let branch_id, let status):
            return APIParam(query:["branch_id": branch_id.description,"status": status.description])
            
            
            //
        case .tables(let branch_dd, let area_id, let status, let exclude_table_id, let order_statuses,let buffet_ticket_id):
            return APIParam(query:[
                "branch_id": branch_dd.description,
                "area_id": area_id.description,
                "status":status,
                "exclude_table_id":exclude_table_id.description,
                "order_statuses":order_statuses,
                "is_active": "",
                "buffet_ticket_id": buffet_ticket_id.description
            ])
            
            
        case .addNoteToOrder(let branch_id, let order_detail_id, let note):
            return APIParam(body:[
                "branch_id": branch_id.description,
                "id": order_detail_id.description,
                "note": note
            ])
            
        case .reasonCancelFoods(let branch_id):
            return APIParam(query: ["branch_id": branch_id.description])
            
        case .cancelFood(let branch_id, let order_id, let reason, let order_detail_id, let quantity):
            return APIParam(body:[
                "branch_id": branch_id,
                "id": order_id,
                "reason":reason,
                "order_detail_id": order_detail_id,
                "quantity":quantity
            ])
            
        case .updateFoods(let branch_id, let order_id, let itemsUpdate):
            return APIParam(body:[
                "branch_id": branch_id,
                "id": order_id,
                "order_details":itemsUpdate.toDictionary()
            ]
            )
            
        case .openTable(let table_id):
            return APIParam(body: ["table_id": table_id])
            
            
        case .ordersNeedMove(let branch_id, let order_id, let food_status):
            return APIParam(query: [
                "id": order_id,
                "branch_id": branch_id,
                "food_status": food_status
            ])
            
        case .moveFoods(let branch_id, let order_id, let destination_table_id, let target_table_id, let foods_move):
            return APIParam(body: [
                "from_order_id": order_id,
                "destination_table_id":destination_table_id,
                "to_table_id": target_table_id,
                "branch_id": branch_id,
                "list_food": foods_move.toDictionary()
            ])
            
        case .moveTable(let branch_id,  let from, let to):
            return APIParam(body: [
                "branch_id": branch_id,
                "id": from,
                "table_id": to
            ])
            
            
        case .mergeTable(let branch_id,  let destination_table_id, let target_table_ids):
            return APIParam(body: [
                "branch_id": branch_id,
                "destination_table_id": destination_table_id,
                "table_ids": target_table_ids
            ])
            
        case .createArea(let branch_id, let area, let is_confirmed):
            var parameter:[String:Any] = [
                "id": area.id,
                "branch_id":branch_id.description,
                "name": area.name,
                "status":area.status.description,
                
            ]
            if is_confirmed != nil{
                parameter.updateValue(is_confirmed, forKey: "is_confirmed")
            }
            
            return APIParam(query: parameter)
            
            
        case .foodsManagement(let branch_id, let is_addition, let status, let category_types, let restaurant_kitchen_place_id):
            
            return APIParam(query: [
                "branch_id":branch_id.description,
                "is_addition": is_addition.description,
                "status": status.description,
                "category_types": category_types.description,
                "restaurant_kitchen_place_id": restaurant_kitchen_place_id.description
            ])
            
        case .categories(let brand_id, let status, let category_types):
            return APIParam(query: [
                "restaurant_brand_id":brand_id.description,
                "status": status.description,
                "category_types":category_types
            ])
            
            
        case .notesManagement(let branch_id, let status):
            
            return APIParam(query: [
                "branch_id":branch_id.description,
                "status": status.description
            ])
            
        case .createTable(let branch_id, let table_id, let table_name, let area_id, let total_slot, let status):
            return APIParam(query: [
                "branch_id":branch_id.description,
                "table_id":table_id.description,
                "table_name":table_name,
                "area_id":area_id.description,
                "total_slot":total_slot.description,
                "status":status.description
            ])
            
            
        case .foodsNeedPrint(let order_id):
            return APIParam(query: ["order_id":String(order_id)])
            
        case .createNote(let note):
            
            return APIParam(query: [
                "id": note.id.description,
                "content": note.content,
                "delete": note.delete?.description,
                "branch_id": note.branch_id?.description
            ])
            
        case .createCategory(let id,let name, let code,let description, let category_type, let status):
            return APIParam(body: [
                "name":name,
                "code":code,
                "restaurant_brand_id": (Constants.brand.id ?? 0).description,
                "description":description,
                "category_type":category_type.description,
                "status":status.description,
                "id":id.description
            ])
            
        case  .ordersHistory(
            let brand_id,
            let branch_id,
            let from_date,
            let to_date,
            let order_status,
            let limit,
            let page,
            let key_search
        ):
            return APIParam(query: [
                "restaurant_brand_id":brand_id,
                "branch_id": branch_id,
                "from_date":from_date,
                "to_date":to_date,
                "order_status": order_status,
                "limit":limit,
                "page":page,
                "key_search":key_search
            ])
            
        case .getTotalAmountOfOrders(
            let restaurant_brand_id,
            let branch_id,
            let order_status,
            let key_search,
            let from_date,
            let to_date
        ):
            return APIParam(query: [
                "restaurant_brand_id": restaurant_brand_id,
                "branch_id": branch_id,
                "order_status":order_status,
                "key_search":key_search,
                "from_date":from_date,
                "to_date":to_date
            ])
            
        case .units:
            return APIParam(query: [:])
            
        case .createFood(let branch_id, let food):
            return APIParam(body: [
                "id":food.id,
                "restaurant_brand_id":Constants.brand.id,
                "branch_id":branch_id,
                "category_id":food.category_id,
                "avatar":food.avatar,
                "avatar_thump":food.avatar_thump,
                "description":food.description,
                "name":food.name,
                "price":food.price,
                //                    "is_bbq":food.is_bbq,
                "unit":food.unit_type,
                //                    "is_allow_print":food.is_allow_print,
                "is_allow_print_stamp":food.allow_print_stamp ? ACTIVE : DEACTIVE,
                "is_addition":food.is_addition,
                "code":food.code,
                "is_sell_by_weight":food.is_sell_by_weight,
                //                    "is_allow_review":food.is_allow_review,
                "is_take_away":food.is_take_away,
                //                    "is_addition_like_food":food.is_addition_like_food,
                //                    "food_material_type":food.food_material_type,
                "food_addition_ids":food.food_addition_ids,
                "status":food.status,
                "temporary_price": food.temporary_price,
                "temporary_percent": food.temporary_percent,
                "temporary_price_from_date": food.temporary_price_from_date,
                "temporary_price_to_date": food.temporary_price_to_date,
                //                    "promotion_percent": food.promotion_percent,
                //                    "promotion_from_date": food.promotion_from_date,
                //                    "promotion_to_date": food.promotion_to_date,
                "restaurant_vat_config_id": food.vat_id,
                "restaurant_kitchen_place_id":food.printer_id
            ])
            
        case .updateFood(let branch_id, let food):
            return  APIParam(body: [
                "id":food.id,
                "restaurant_brand_id":branch_id,
                "branch_id":branch_id,
                "category_id":food.category_id,
                "avatar":food.avatar,
                "avatar_thump":food.avatar_thump,
                "description":food.description,
                "name":food.name,
                "price":food.price,
                "is_bbq":food.is_bbq,
                "unit":food.unit_type,
//                "is_allow_print":food.is_allow_print,
//                "is_allow_print_stamp":food.is_allow_print_stamp,
                "is_addition_like_food":food.is_addition_like_food,
                "is_addition":food.is_addition,
                "code":food.code,
                "is_sell_by_weight":food.is_sell_by_weight,
                "is_take_away":food.is_take_away,
                "food_material_type":food.food_material_type,
                "food_addition_ids":food.food_addition_ids,
                "status":food.status,
                "temporary_price": food.temporary_price,
                "temporary_percent": food.temporary_percent,
                "temporary_price_from_date": food.temporary_price_from_date,
                "temporary_price_to_date": food.temporary_price_to_date,
                "promotion_percent": food.promotion_percent,
                "promotion_from_date": food.promotion_from_date,
                "promotion_to_date": food.promotion_to_date,
                "restaurant_vat_config_id": food.vat_id,
                "restaurant_kitchen_place_id":food.printer_id
            ])
                

            case .closeTable(let order_id):
                return APIParam(body:[
                    "id": order_id,
                    "branch_id":Constants.branch.id
                ])

            case .notes( let branch_id):
                return APIParam(query: [
                    "branch_id": branch_id.description
                ])

            case .tablesManager(let area_id, let branch_id, let status, let is_deleted):
                return APIParam(query: [
                    "area_id": area_id.description,
                    "branch_id": branch_id.description,
                    "status":status.description,
                    "is_deleted":is_deleted.description
                ])
           

            case .notesByFood(let order_detail_id, let branch_id):
            
                return APIParam(query: [
                    "food_id": order_detail_id.description,
                    "branch_id": branch_id.description
                ])

            case .getFoodsBookingStatus(order_id: let order_id):
                return APIParam(query:["order_id": order_id.description])
       


            case .postCreateOrder(let branch_id,let table_id,let note):
                     
                return APIParam(query:[
                    "branch_id": branch_id.description,
                    "table_id": table_id.description,
                    "note": note
                ])


            case .postCreateTableList(let branch_id, let area_id, let tables):
                return APIParam(query:[
                    "branch_id": branch_id,
                    "area_id": area_id,
                    "tables": tables.toDictionary()
                ])

            case .getBuffetTickets(let brand_id, let status, let key_search, let limit, let page):
              
                return APIParam(query:[
                    "restaurant_brand_id": brand_id.description,
                    "status": status.description,
                    "key_search":key_search,
                    "limit": limit.description,
                    "page": page.description
                ])

            case .getDetailOfBuffetTicket(let branch_id, let category_id, let buffet_ticket_id, let key_search, let limit, let page):
        
                return APIParam(query:[
                    "branch_id": branch_id.description,
                    "category_id": category_id.description,
                    "buffet_ticket_id": buffet_ticket_id.description,
                    "key_search": key_search,
                    "limit": limit.description,
                    "page": page.description
                ])

            case .getFoodsOfBuffetTicket(let brand_id, let buffet_ticket_id):
                return APIParam(query:[
                    "restaurant_brand_id": brand_id.description,
                    "buffet_ticket_id": buffet_ticket_id.description
                ])

            case .postCreateBuffetTicket(let branch_id,let order_id,let buffet_id,let  adult_quantity,let adult_discount_percent,let child_quantity, let chilren_discount_percent):
                return APIParam(query:[
                    "branch_id": branch_id.description,
                    "buffet_ticket_id": buffet_id.description,
                    "order_id": order_id.description,
                    "cash_amount": 0,
                    "bank_amount": 0,
                    "transfer_amount": 0,
                    "e_wallet_amount": 0,
                    "adult_quantity": adult_quantity.description,
                    "adult_discount_percent": adult_discount_percent.description,
                    "child_quantity": child_quantity.description,
                    "child_discount_percent": chilren_discount_percent.description
                ])

            case .postUpdateBuffetTicket(let branch_id,let order_id,let buffet):
                return APIParam(query:[
                    "branch_id": branch_id.description,
    //                    "buffet_ticket_id": buffet.buffet_ticket_id.description,
                    "order_id": order_id.description,
                    "cash_amount": 0,
                    "bank_amount": 0,
                    "transfer_amount": 0,
                    "e_wallet_amount": 0,
    //                    "adult_quantity": buffet.adult_quantity.description,
    //                    "adult_discount_percent":buffet.adult_discount_percent,
    //                    "child_quantity": buffet.child_quantity,
    //                    "child_discount_percent":buffet.child_discount_percent,
                ])

            case .postCancelBuffetTicket(_):
                return APIParam(query:[:])


            case .postDiscountOrderItem(let branchId,_,let orderItem):
                return APIParam(body:[
                    "branch_id": branchId,
                    "discount_percent": orderItem.discount_percent,
                    "order_detail_id": orderItem.id,
                ])
            
            
            case .getActivityLog(let object_id, let type, let key_search, let object_type, let from, let to, let page, let limit):
                return APIParam(query:[
                    "object_id": object_id,
                    "type": type,
                    "key_search": key_search,
                    "object_type": object_type,
                    "from": from,
                    "to": to,
                    "page": page,
                    "limit": limit
                ])
            
            
            //=========== API REPORT ========
                
            case .report_revenue_by_time(let restaurant_brand_id, let branch_id, let report_type, let date_string, let from_date, let to_date):
                
                var parameter:[String:Any] = [
                    "restaurant_brand_id": restaurant_brand_id,
                    "branch_id": branch_id,
                    "report_type": report_type,
                    "date_string": date_string,
                ]
                
                if report_type == REPORT_TYPE_OPTION_DAY{
                    parameter.updateValue(from_date, forKey: "from_date")
                    parameter.updateValue(to_date, forKey: "to_date")
                    parameter.updateValue("", forKey: "date_string")
                }
                
                return APIParam(query: parameter)
                
                
            case .report_revenue_activities_in_day_by_branch(let restaurant_brand_id, let branch_id, let report_type, let date_string, let from_date, let to_date):
                return APIParam(query: [
                        "restaurant_brand_id": restaurant_brand_id,
                        "branch_id": branch_id,
                        "report_type": report_type,
                        "date_string": date_string,
                        "from_date": from_date,
                        "to_date": to_date
                ])
                
                
            case .report_revenue_fee_profit(let restaurant_brand_id, let branch_id,let is_count_to_revenue ,let report_type, let date_string, let from_date, let to_date):
                return APIParam(query: [
                        "restaurant_brand_id": restaurant_brand_id,
                        "branch_id": branch_id,
                        "is_count_to_revenue":is_count_to_revenue,
                        "report_type": report_type,
                        "date_string": date_string,
                        "from_date": from_date,
                        "to_date": to_date
                ])
                
            case .report_revenue_by_category(let restaurant_brand_id, let branch_id, let report_type, let date_string, let from_date, let to_date):
                
                var parameter:[String:Any] = [
                    "restaurant_brand_id": restaurant_brand_id,
                    "branch_id": branch_id,
                    "report_type": report_type,
                    "date_string": date_string,
                ]
                
                if report_type == REPORT_TYPE_OPTION_DAY{
                    parameter.updateValue(from_date, forKey: "from_date")
                    parameter.updateValue(to_date, forKey: "to_date")
                    parameter.updateValue("", forKey: "date_string")
                }
                
                return APIParam(query:parameter)
                
                
                
            case .report_revenue_by_employee(let employee_id, let restaurant_brand_id, let branch_id, let report_type, let date_string, let from_date, let to_date):
                return APIParam(query:[
                    "restaurant_brand_id": restaurant_brand_id,
                    "branch_id": branch_id,
                    "report_type": report_type,
                    "date_string": date_string,
                    "from_date": from_date,
                    "to_date": to_date,
                    "employee_id": Constants.user.id
                ])
                
                
            case .report_business_analytics(let restaurant_brand_id, let branch_id, let category_id, let category_types, let report_type, let date_string, let from_date,  let to_date, let is_cancelled_food, let is_combo, let is_gift, let is_goods, let is_take_away_food):
                
                var parameter:[String:Any] = [
                    "branch_id": branch_id,
                    "restaurant_brand_id": restaurant_brand_id,
                    "category_id": category_id,
                    "category_types": category_types,
                    "is_cancelled_food": is_cancelled_food,
                    "is_combo": is_combo,
                    "is_gift": is_gift,
                    "is_goods": is_goods,
                    "is_take_away_food": is_take_away_food,
                    "date_string": date_string,
                    "report_type": report_type
                ]
                
                if report_type == REPORT_TYPE_OPTION_DAY{
                    parameter.updateValue(from_date, forKey: "from_date")
                    parameter.updateValue(to_date, forKey: "to_date")
                    parameter.updateValue("", forKey: "date_string")
                }
                
                return APIParam(query: parameter)
                
            case .report_employee_revenue(restaurant_brand_id: let restaurant_brand_id, branch_id: let branch_id, report_type: let report_type, date_string: let date_string, from_date: let from_date, to_date: let to_date):
                return APIParam(query: [
                        "restaurant_brand_id": restaurant_brand_id,
                        "branch_id": branch_id,
                        "report_type": report_type,
                        "date_string": date_string,
                        "from_date": from_date,
                        "to_date": to_date
                ])
         
            case .report_food(
                let restaurant_brand_id,
                let branch_id,
                let report_type,
                let date_string,
                let from_date,
                let to_date,
                let category_id,
                let category_types,
                let is_combo,
                let is_goods,
                let is_cancelled_food,
                let is_gift,
                let is_take_away_food
            ):
                
            
                var parameter:[String:Any] = [
                    "restaurant_brand_id": restaurant_brand_id,
                    "branch_id": branch_id,
                    "report_type": report_type,
                    "date_string": date_string,
                    "is_goods": is_goods,
                    "is_cancelled_food": is_cancelled_food,
                    "is_combo": is_combo,
                    "is_gift": is_gift,
                    "category_id": category_id,
                    "category_types":category_types,
                    "is_take_away_food": is_take_away_food
                ]
            
                if report_type == REPORT_TYPE_OPTION_DAY{
                    parameter.updateValue(from_date, forKey: "from_date")
                    parameter.updateValue(to_date, forKey: "to_date")
                    parameter.updateValue("", forKey: "date_string")
                }
                
                return APIParam(query: parameter)
                
                
            case .report_cancel_food(
                let restaurant_brand_id,
                let branch_id,
                let report_type,
                let date_string,
                let from_date,
                let to_date,
                let category_id,
                let is_combo,
                let is_goods,
                let is_cancelled_food,
                let is_gift,
                let is_take_away_food
            ):
                return APIParam(query: [
                    "restaurant_brand_id": restaurant_brand_id,
                    "branch_id": branch_id,
                    "report_type": report_type,
                    "date_string": date_string,
                    "from_date":from_date,
                    "to_date":to_date,
                    "is_goods": is_goods,
                    "is_cancelled_food": is_cancelled_food,
                    "is_combo": is_combo,
                    "is_gift": is_gift,
                    "category_id": category_id,
                    "is_take_away_food": is_take_away_food
                        
                ])
                
            
            case .report_gifted_food(
                let restaurant_brand_id,
                let branch_id,
                let report_type,
                let date_string,
                let from_date,
                let to_date,
                let category_id,
                let is_combo,
                let is_goods,
                let is_cancelled_food,
                let is_gift,
                let is_take_away_food
            ):
                return APIParam(query: [
                    "restaurant_brand_id": restaurant_brand_id,
                    "branch_id": branch_id,
                    "report_type": report_type,
                    "date_string": date_string,
                    "from_date":from_date,
                    "to_date":to_date,
                    "is_goods": is_goods,
                    "is_cancelled_food": is_cancelled_food,
                    "is_combo": is_combo,
                    "is_gift": is_gift,
                    "category_id": category_id,
                    "is_take_away_food": is_take_away_food
                ])
            
            case .report_discount(
                let restaurant_brand_id,
                let branch_id,
                let report_type,
                let date_string,
                let from_date,
                let to_date
            ):
                return APIParam(query: [
                    "restaurant_brand_id": restaurant_brand_id,
                    "branch_id": branch_id,
                    "report_type": report_type,
                    "date_string": date_string,
                    "from_date":from_date,
                    "to_date":to_date
                ])
            
            case .report_VAT(
                let restaurant_brand_id,
                let branch_id,
                let report_type,
                let date_string,
                let from_date,
                let to_date
            ):
                return APIParam(query: [
                    "restaurant_brand_id": restaurant_brand_id,
                    "branch_id": branch_id,
                    "report_type": report_type,
                    "date_string": date_string,
                    "from_date":from_date,
                    "to_date":to_date
                ])
                
            case .report_area_revenue(let restaurant_brand_id,let branch_id,let report_type,let date_string,let from_date,let to_date):
        
                var parameter:[String:Any] = [
                    "restaurant_brand_id": restaurant_brand_id,
                    "branch_id": branch_id,
                    "report_type": report_type,
                    "date_string": date_string,
                ]
            
                if report_type == REPORT_TYPE_OPTION_DAY{
                    parameter.updateValue(from_date, forKey: "from_date")
                    parameter.updateValue(to_date, forKey: "to_date")
                    parameter.updateValue("", forKey: "date_string")
                }
                
                return APIParam(query:parameter)

            
            case .report_table_revenue(let restaurant_brand_id,let branch_id,let area_id,let report_type,let date_string,let from_date,let to_date):
            
                var parameter:[String:Any] = [
                    "restaurant_brand_id": restaurant_brand_id,
                    "branch_id": branch_id,
                    "area_id":area_id,
                    "report_type": report_type,
                    "date_string": date_string,
                ]
            
                if report_type == REPORT_TYPE_OPTION_DAY{
                    parameter.updateValue(from_date, forKey: "from_date")
                    parameter.updateValue(to_date, forKey: "to_date")
                    parameter.updateValue("", forKey: "date_string")
                }
                
                return APIParam(query:parameter)

                
            case .getReportRevenueGenral(let restaurant_brand_id,  let branch_id, let report_type, let date_string, let from_date, let to_date):
                return APIParam(query: [
                    "restaurant_brand_id": restaurant_brand_id,
                    "branch_id": branch_id,
                    "report_type": report_type,
                    "date_string": date_string,
                    "from_date": from_date,
                    "to_date": to_date
                ])
            
            
            
            case .getDailyRevenueReportOfFoodApp(let restaurant_id, let restaurant_brand_id, let branch_id, let food_channel_id, let date_string, let report_type, let hour_to_take_report):
                return APIParam(query: [
    //                    "restaurant_id":restaurant_id,
                        "restaurant_brand_id":restaurant_brand_id,
                        "branch_id":branch_id,
    //                    "food_channel_id":food_channel_id,
                        "date_string":date_string,
                        "report_type":report_type,
    //                    "hour_to_take_report":hour_to_take_report
                ])
            

        }
    }
}

