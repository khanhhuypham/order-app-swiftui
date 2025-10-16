//
//  Enum.swift
//  TECHRES-ORDER
//
//  Created by Pham Khanh Huy on 05/04/2024.
//

import UIKit
import SwiftUI

enum OrderAction {
    case orderHistory
    case moveTable
    case mergeTable
    case splitFood
    case chooseFoodToSplit
    case cancelOrder
    case sharePoint
}



enum OrderStatus:Int,Codable {
    case open = 0 //ĐANG PHỤC VỤ
    case payment_request = 1 // YÊU CẦU THANH TOÁN
    case complete = 2 // HOAN TAT
    case waiting_merged = 3
    case waiting_complete = 4 // CHỜ THU TIỀN
    case debt_complete = 5// HOAN TAT & NO BILL
    case cancel = 8 // ĐÃ HUỶ
    
    
    var description:String {
        switch self {
            
            case .complete:
                return "Hoàn thành"
            
            case .payment_request:
                return "Yêu cầu thanh toán"
         
            case .waiting_complete:
                return "Chờ thanh toán"
                
            default:
                return "đang phục vụ"
        }
    }
    
    var fgColor:Color {
        switch self {
            
            case .complete:
                return Color(ColorUtils.green_600())
            
            case .payment_request:
                return Color(ColorUtils.orange_brand_900())
         
            case .waiting_complete:
                return Color(ColorUtils.red_600())
                
            default:
                return Color(ColorUtils.blue_brand_700())
        }
    }
    
    var bgColor:Color {
        switch self {
            case .complete:
                return Color(ColorUtils.green_000())
            
            case .payment_request:
                return Color(ColorUtils.orange_brand_200())
         
            case .waiting_complete:
                return Color(ColorUtils.red_000())
                
            default:
                return Color(ColorUtils.blue_brand_200())
        }
    }
}

enum BookingStatus:Int,Codable {    
    case none = 0// ko có booking
    case status_booking_expired = 8// Hết hạn
    case status_booking_waiting_confirm = 1// đang chờ nhà hàng xác nhận
    case status_booking_waiting_setup = 2// Chờ setup
    case status_booking_waiting_complete = 3 // đơn hàng đã bắt đầu, chờ hoàn tất hóa đơn
    case status_booking_completed = 4// hoàn tất
    case status_booking_cancel = 5 // hủy
    case status_booking_setup = 9// đã set up chờ nhận khách
    case status_booking_confirmed = 7 // Đã xác nhận
    
}




enum ORDER_METHOD:Int,Codable {
    case EAT_IN = 0 // Phục vụ tại quán
    case TAKE_AWAY = 1 // Đơn hàng mang về
    case ONLINE_DELIVERY = 2 // Đơn hàng online
    case SHOPEE_FOOD = 3 // Đơn hàng online
    case GRAB_FOOD = 4 // Đơn hàng online
    case GO_FOOD = 5 // Đơn hàng online
    case BE_FOOD = 6 // Đơn hàng online
    
    var prefix:String{
        switch self {
        case .EAT_IN:
            return ""
            
        case .TAKE_AWAY:
            return "MV"
            
        case .ONLINE_DELIVERY:
            return ""
            
        case .SHOPEE_FOOD:
//            return "SHF-"
            return ""
            
        case .GRAB_FOOD:
            return ""
            
        case .GO_FOOD:
            return ""
            
        case .BE_FOOD:
//            return "BEF-"
            return ""
        }
    }
    
    var fgColor:UIColor{
        switch self {
        case .EAT_IN:
            return ColorUtils.black()
        case .TAKE_AWAY:
            return ColorUtils.black()
        case .ONLINE_DELIVERY:
            return ColorUtils.black()
        case .SHOPEE_FOOD:
            return ColorUtils.hexStringToUIColor(hex: "#EE4E2E")
        case .GRAB_FOOD:
            return ColorUtils.hexStringToUIColor(hex: "#009E3A")
        case .GO_FOOD:
            return ColorUtils.black()
        case .BE_FOOD:
            return ColorUtils.hexStringToUIColor(hex: "#FFC418")
        }
    }
}


enum TableStatus:Int,Codable {
    
    case using = 2
    case closed = 0
    case booking = 1
    case mergered = 3
    

    
    
    var fgColor:Color {
        switch self {
            case .using:
                return Color(ColorUtils.blue_brand_700())
            
            case .closed:
                return Color(uiColor: .systemGray3)
                
            case .booking:
                return Color(ColorUtils.green_600())

            case .mergered:
                return Color(ColorUtils.red_600())
        }
    }
    
 
}








enum Bill_TYPE:Int{
    case bill1 = 0
    case bill2 = 1
    case bill3 = 2
    case bill4 = 3
   
}


enum CATEGORY_TYPE:Int,Codable,CaseIterable,Hashable{
    
    case processed = 1
    case nonProcessed = 2
    case nonProcessedOther = 3
    case seafood = 4
   
    
    var value: Int {
        switch self {
            case .processed:
                return 1
            
            case .nonProcessed:
                return 2
            
            case .nonProcessedOther:
                return 3
            
            case .seafood:
                return 4
        }
    }
    
    
    var name: String {
        switch self {
            case .processed:
                return "Có chế biến/Pha chế"
            
            case .nonProcessed:
                return "Không chế biến"
            
            case .nonProcessedOther:
                return "Khác (Không chế biến)"
            
            case .seafood:
                return "Hải sản"
        }
    }
}

enum FOOD_CATEGORY:Int,Codable{
    case food = 1
    case drink = 2
    case other = 3
    case extra_charge = 0
    case seafood = 4
    case service = 5
    case buffet_ticket = 6
    case all = -1
    
    var description: String {
        switch self {
            case .food:
                return "Món ăn"
            case .drink:
                return "Nước uống"
            
            case .extra_charge:
                return "Phụ thu"
            
            case .other:
                return "Khác"
            case .seafood:
                return "SeaFood"
            case .service:
                return "Dịch vụ"
            case .buffet_ticket:
                return "Buffet"
            case .all:
                return "Tất cả"
        }
    }
    
    
}


enum FOOD_STATUS:Int,Codable{
    
    
    case pending = 0; //Mon moi goi
    case cooking = 1; // Dang nau
    case done = 2; // Hoan tat mon
    case not_enough = 3; // het mon
    case cancel = 4; // Huy mon
    case servic_block_using = 7 // dịch vụ đang sử dụng
    case servic_block_stopped = 8 //  dịch vụ đã ngưng
    
    
    var description: String {
        switch self {
            case .pending:
                return "CHỜ CHẾ BIẾN"
            case .cooking:
                return "ĐANG CHẾ BIẾN"
            case .done:
                return "HOÀN TẤT"
            case .not_enough:
                return "HẾT MÓN"
            case .cancel:
                return "ĐÃ HỦY"
            case .servic_block_using:
                return "ĐANG SỬ DỤNG"
            case .servic_block_stopped:
                return "ĐANG TẠM DỪNG"
        }
    }
    
    
    
    
    var fgColor: Color {
        switch self {
            case .pending:
                return Color(ColorUtils.orange_brand_900())
            
            case .cooking:
                return Color(ColorUtils.blue_brand_700())
                
            case .done:
                return Color(ColorUtils.green_600())
            
            case .not_enough:
                return Color(ColorUtils.red_500())
            
            case .cancel:
                return Color(ColorUtils.red_500())
            
            case .servic_block_using:
                return Color(ColorUtils.green_600())
            
            case .servic_block_stopped:
                return Color(ColorUtils.red_500())
        }
    }
    
    var bgColor: Color {
        switch self {
            case .pending:
                return Color(ColorUtils.white())
            
            case .cooking:
                return Color(ColorUtils.white())
                
            case .done:
                return Color(ColorUtils.white())
            
            case .not_enough:
                return Color(ColorUtils.red_000())
            
            case .cancel:
                return Color(ColorUtils.red_000())
            
            case .servic_block_using:
                return Color(ColorUtils.white())
            
            case .servic_block_stopped:
                return Color(ColorUtils.white())
        }
    }
    
    
}

enum BOOKING_STATUS:Int{
    
    
    case booking_completed = 4// hoàn tất
    case booking_cancel = 5 // hủy
    case booking_expired = 8// Hết hạn
    case booking_waiting_confirm = 1// đang chờ nhà hàng xác nhận
    case booking_waiting_setup = 2// Chờ setup
    case booking_setup = 9// đã set up chờ nhận khách
    case bokking_waiting_complete = 3 // đơn hàng đã bắt đầu, chờ hoàn tất hóa đơn
    case booking_confirmed = 7 // Đã xác nhận
    
}

enum PAYMENT_METHOD:Int{
    
    case cash = 1
    case transfer = 6 //Chuyển khoản
    case atm_card = 2 //sử dụng thẻ

    
}




enum PRINTER_TYPE:Int,Codable{
    case bar = 0
    case chef = 1
    case cashier = 2
    case fish_tank = 3
    case stamp = 4
    case scangle = 5
    case cashier_of_food_app = 6
    case stamp_of_food_app = 7
}


enum CONNECTION_TYPE:Int,Codable{
    case wifi = 0
    case Imin = 1
    case sunmi = 2
    case usb = 3
    case blueTooth = 4
    
    var description: String {
        switch self {
            case .Imin:
                return "Imin"
            case .sunmi:
                return "sunmi"
            case .usb:
                return "usb"
            default:
                return ""
        }
    }
    
}


@objc(PRINTER_METHOD)
enum PRINTER_METHOD:Int{
    case POSPrinter = 1
    case TSCPrinter = 2
    case BLEPrinter = 3
}


enum APP_PARTNER:String{
    case shoppee = "SHF"
    case grabfood = "GRF"
    case gofood = "GOF"
    case befood = "BEF"
}


enum QRCODE_TYPE:Int,Codable{
    case viet_qr = 0
    case eco_pay = 1
    case pay_os = 2
}


enum FOOD_ADDITION_TYPE:Codable{
    case addition
    case combo
    case option
}



enum REPORT_TYPE:Int,CaseIterable{
    case today = 1 //lấy theo ngày
    case yesterday = 9  // lấy theo ngày hôm qua
    case this_week = 2 // lấy theo tuần
    case this_month = 3 // lấy theo tháng
    case three_month = 4 // lấy theo 3 tháng gần nhất
    case this_year = 5 // lấy theo năm
    case last_year = 11//Lấy theo năm trước
    case three_year = 6// lấy theo 3 năm gần nhất
    case last_month = 10 // lấy theo tháng trước
    case all_year = 8 // lấy tất cả thời gian
    
    var from_date: String {
        let calendar = Calendar.current
        let formatter = dateFormatter.dd_mm_yyyy.value
        let today = Date()
     
        
        switch self {
            case .today:
                // Start of today
                return formatter.string(from: calendar.startOfDay(for: today))
                
            case .yesterday:
                // Start of yesterday
                if let yesterday = calendar.date(byAdding: .day, value: -1, to: today) {
                    return formatter.string(from: calendar.startOfDay(for: yesterday))
                }
                return ""

            case .this_week:
                // Start of this week (Monday)
                if let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) {
                    return formatter.string(from: startOfWeek)
                }
                return ""

            case .this_month:
                // Start of this month (1st day)
                let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: today))
                return formatter.string(from: startOfMonth!)

            case .three_month:
                // Start of three months ago
                if let threeMonthsAgo = calendar.date(byAdding: .month, value: -3, to: today) {
                    let startOfThreeMonthsAgo = calendar.date(from: calendar.dateComponents([.year, .month], from: threeMonthsAgo))
                    return formatter.string(from: startOfThreeMonthsAgo!)
                }
                return ""

            case .this_year:
                // Start of this year (1st January)
                let startOfYear = calendar.date(from: calendar.dateComponents([.year], from: today))
                return formatter.string(from: startOfYear!)

            case .last_year:
                // Start of last year (1st January)
                if let lastYear = calendar.date(byAdding: .year, value: -1, to: today) {
                    let startOfLastYear = calendar.date(from: calendar.dateComponents([.year], from: lastYear))
                    return formatter.string(from: startOfLastYear!)
                }
                return ""

            case .three_year:
                // Start of three years ago
                if let threeYearsAgo = calendar.date(byAdding: .year, value: -3, to: today) {
                    let startOfThreeYearsAgo = calendar.date(from: calendar.dateComponents([.year], from: threeYearsAgo))
                    return formatter.string(from: startOfThreeYearsAgo!)
                }
                return ""

            case .last_month:
                // Start of last month (1st day of previous month)
                if let lastMonth = calendar.date(byAdding: .month, value: -1, to: today) {
                    let startOfLastMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: lastMonth))
                    return formatter.string(from: startOfLastMonth!)
                }
                return ""

            case .all_year:
                // Start of all time (you can define a fixed starting date or use a very early date)
                return "01/10/2000" // Example: Start from January 1st, 2000, or adjust as needed.
        }
    }
    
    var to_date: String {
        let calendar = Calendar.current
        let formatter = dateFormatter.dd_mm_yyyy.value
        let today = Date()
        
        switch self {
            case .today:
                // End of today
                return formatter.string(from: today)
                
            case .yesterday:
                // End of yesterday
                return formatter.string(from: today)
            
            case .this_week:
                if let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) {
                    if let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) {
                        return formatter.string(from: endOfWeek)
                    }
                }
                return formatter.string(from: today)
            
            case .this_month:
                // End of this month (last day)
                if let range = calendar.range(of: .day, in: .month, for: today) {
                    let lastDayOfMonth = range.count
                    let components = calendar.dateComponents([.year, .month], from: today)
                    if let endOfMonth = calendar.date(from: components)?.addingTimeInterval(TimeInterval((lastDayOfMonth - 1) * 86400)) {
                        return formatter.string(from: endOfMonth)
                    }
                }
                return ""
            
            case .three_month:
                // End of the current day (today)
                return formatter.string(from: today)
            
            case .this_year:
                // End of this year (31st December)
                let components = DateComponents(year: calendar.component(.year, from: today) + 1, month: 1, day: 0)
                if let endOfYear = calendar.date(from: components) {
                    return formatter.string(from: endOfYear)
                }
                return ""
            
            case .last_year:
                // End of last year (31st December)
                let components = DateComponents(year: calendar.component(.year, from: today), month: 1, day: 0)
                if let endOfLastYear = calendar.date(from: components) {
                    return formatter.string(from: endOfLastYear)
                }
                return ""
            
            case .three_year:
                // End of the current day (today)
                return formatter.string(from: today)
                
            case .last_month:
                // End of last month (last day of previous month)
                if let lastMonth = calendar.date(byAdding: .month, value: -1, to: today) {
                    let range = calendar.range(of: .day, in: .month, for: lastMonth)!
                    let lastDayOfMonth = range.count
                    let components = calendar.dateComponents([.year, .month], from: lastMonth)
                    if let endOfLastMonth = calendar.date(from: components)?.addingTimeInterval(TimeInterval((lastDayOfMonth - 1) * 86400)) {
                        return formatter.string(from: endOfLastMonth)
                    }
                }
                return ""
            
            case .all_year:
                // End of today as the default
                return formatter.string(from: today)
        }
    }
}
