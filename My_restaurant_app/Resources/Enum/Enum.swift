//
//  Enum.swift
//  TECHRES-ORDER
//
//  Created by Pham Khanh Huy on 05/04/2024.
//

import UIKit
//import RealmSwift
import SwiftUI

enum OrderAction {
    case orderHistory
    case moveTable
    case mergeTable
    case splitFood
    case cancelOrder		
    case sharePoint
}



enum OrderStatus:Int,Codable {
    case open = 0 //ĐANG PHỤC VỤ
    case payment_request = 1 // YÊU CẦU THANH TOÁN
    case complete = 2 // HOAN TAT
    case waiting_merged = 3
    case waiting_complete = 4 // CHỜ THU TIỀN
    case cancel = 5 // ĐÃ HUỶ
    
    
    var description:String {
        switch self {
            case .payment_request:
                return "Yêu cầu thanh toán"
            
            case .waiting_complete:
                return "Chờ thanh toán"
                
            case .cancel:
                return "Yêu cầu Huỷ"
            
            case .complete:
                return "Hoàn thành"
                    
            default:
                return "đang phục vụ"
        }
    }
    
    var fgColor:Color {
        switch self {
            case .payment_request:
                return Color(ColorUtils.orange_brand_900())
         
            case .waiting_complete:
                return Color(ColorUtils.red_600())
            
            case .cancel:
                return Color(ColorUtils.red_600())
            
            case .complete:
                return Color(ColorUtils.green_600())
                
            default:
                return Color(ColorUtils.blue_brand_700())
        }
    }
    
    var fgColorForTable:Color {
        switch self {
            case .cancel:
                return Color(ColorUtils.red_600())
         
            default:
                return Color(ColorUtils.blue_brand_700())
        }
    }
    
    var bgColor:Color {
        switch self {
            case .payment_request:
                return Color(ColorUtils.orange_brand_200())
         
            case .waiting_complete:
                return Color(ColorUtils.red_000())
            
            case .cancel:
                return Color(ColorUtils.red_000())
            
            case .complete:
                return Color(ColorUtils.green_000())
                
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






enum TableStatus:Int,Codable {
    
    case closed = 0
    case booking = 1
    case using = 2
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




enum CATEGORY_TYPE:Int,Codable,CaseIterable{
    case extra_charge = 0
    case food = 1
    case drink = 2
    case other = 3
    case seafood = 4
    case service = 5
    case buffet_ticket = 6
    case combo = 7
    case add_ons = 8

    
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
                
            default:
                return ""

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
    
}

//@objc(PRINTER_METHOD)
//enum PRINTER_METHOD:Int{
//    case POSPrinter = 1
//    case TSCPrinter = 2
//    case BLEPrinter = 3
//}


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

