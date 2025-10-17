//
//  ChartUtils.swift
//  Techres - TMS
//
//  Created by Thanh Phong on 05/08/2021.
//  Copyright © 2021 ALOAPP. All rights reserved.
//  Updated by Phạm Khánh 16/09/2023

import UIKit
import Charts

class ChartUtils: NSObject {
    
        
    ////variable  dataPointnth is used to get label for the report type of week
    static func getXLabel(dateTime:String, reportType:Int, dataPointnth:Int) -> String {
        var x_label = ""
        let datetimeSeparator = dateTime.components(separatedBy: [" "])

            switch(reportType){
                case REPORT_TYPE_TODAY:
                    let substringTime = datetimeSeparator[1].components(separatedBy: [":"])
                    x_label = String(format: "%@:00", substringTime.first!)
         
                case REPORT_TYPE_YESTERDAY:
                    let substringTime = datetimeSeparator[1].components(separatedBy: [":"])
                    x_label = String(format: "%@:00", substringTime.first!)
                
                case REPORT_TYPE_THIS_WEEK:
                    switch dataPointnth {
                        case 0:
                            x_label = "Thứ 2"
                            break
                        case 1:
                            x_label = "Thứ 3"
                            break
                        case 2:
                            x_label = "Thứ 4"
                            break
                        case 3:
                            x_label = "Thứ 5"
                            break
                        case 4:
                            x_label = "Thứ 6"
                            break
                        case 5:
                            x_label = "Thứ 7"
                            break
                        default:
                            x_label = "Chủ nhật"
                    }
                    break
                
                case REPORT_TYPE_LAST_MONTH:
                    let datetimeSeparator = dateTime.components(separatedBy: [" "])
                    let substringDate = datetimeSeparator[0].components(separatedBy: ["-"])
                    
                    x_label = String(format: "%@/%@", substringDate[2], substringDate[1])
                    break
                
                case REPORT_TYPE_THIS_MONTH:
                    let datetimeSeparator = dateTime.components(separatedBy: [" "])
                    let substringDate = datetimeSeparator[0].components(separatedBy: ["-"])

                    x_label = String(format: "%@/%@", substringDate[2], substringDate[1])
                    break
                
                case REPORT_TYPE_THREE_MONTHS:
                    let datetimeSeparator = dateTime.components(separatedBy: [" "])
                    let substringDate = datetimeSeparator[0].components(separatedBy: ["-"])
                    dLog(dateTime)
                    x_label = String(format: "%@/%@", substringDate[2],substringDate[1])
                    break
                
                case REPORT_TYPE_THIS_YEAR:
                    let datetimeSeparator = dateTime.components(separatedBy: [" "])
                    let substringDate = datetimeSeparator[0].components(separatedBy: ["-"])

                    x_label = String(format: "%@", substringDate[1])
                    break
                
                case REPORT_TYPE_LAST_YEAR:
                    let datetimeSeparator = dateTime.components(separatedBy: [" "])
                    let substringDate = datetimeSeparator[0].components(separatedBy: ["-"])

                    x_label = String(format: "%@", substringDate[1])
                    break
                
                case REPORT_TYPE_THREE_YEAR:
                    let datetimeSeparator = dateTime.components(separatedBy: [" "])
                    let substringDate = datetimeSeparator[0].components(separatedBy: ["-"])

                    x_label = String(format: "%@/%@", substringDate[1], substringDate[0])
                    break
                
                case REPORT_TYPE_ALL_YEAR:
                    let datetimeSeparator = dateTime.components(separatedBy: [" "])
                    let substringDate = datetimeSeparator[0].components(separatedBy: ["-"])

                    x_label.append(String(format: "%@",substringDate[0]))
                    break
                
                case REPORT_TYPE_OPTION_DAY:
                    let datetimeSeparator = dateTime.components(separatedBy: [" "])
                    let substringDate = datetimeSeparator[0].components(separatedBy: ["-"])

                    x_label = String(format: "%@/%@/%@", substringDate[1], substringDate[0],substringDate[2])
                
                    break
                
                default:
                    break
            }
        
        return x_label
    }
    
    
    static func setLabelCountForChart(reportType:Int, totalDataPoint:Int) -> Int {
        
        switch reportType {
            case REPORT_TYPE_TODAY:
                return (totalDataPoint)/3
            
            case REPORT_TYPE_YESTERDAY:
                return (totalDataPoint)/3
            
            case REPORT_TYPE_THIS_WEEK:
                return totalDataPoint
            
            case REPORT_TYPE_THIS_MONTH:
                return (totalDataPoint)/4
            
            case REPORT_TYPE_LAST_MONTH:
                return (totalDataPoint)/4
            
            case REPORT_TYPE_THREE_MONTHS:
                return (totalDataPoint)/11
            
            case REPORT_TYPE_THIS_YEAR:
                return (totalDataPoint)
            
            case REPORT_TYPE_LAST_YEAR:
                return (totalDataPoint)
            
            case REPORT_TYPE_THREE_YEAR:
                return (totalDataPoint)/5
            
            case REPORT_TYPE_ALL_YEAR:
                return (totalDataPoint)
            
            default:
                return totalDataPoint
        }

    }
    
    static func stringForValue(_ value: Double) -> String {
        
        if(value >= 0 && value < 1000 ){
           return String(format: "%@", GeneralUtils.stringVietnameseMoneyFormatWithNumberDouble(amount: value))
        }else if(value >= 1000 && value < 1000000 ){
           return String(format: "%@ k", GeneralUtils.stringVietnameseMoneyFormatWithNumberDouble(amount: value/1000))
        }else if(value >= 1000000 && value < 1000000000 ){
           return String(format: "%@ Tr", GeneralUtils.stringVietnameseMoneyFormatWithNumberDouble(amount: value/1000000))
        }else if(value >= 1000000000){
           return String(format: "%@ Tỷ", GeneralUtils.stringVietnameseMoneyFormatWithNumberDouble(amount: value/1000000000))
        } else if(value < 0 && value > -1000) {
           return String(format: "%@", GeneralUtils.stringVietnameseMoneyFormatWithNumberDouble(amount: value))
        }else if(value <= -1000 && value > -1000000 ){
           return String(format: "%@", GeneralUtils.stringVietnameseMoneyFormatWithNumberDouble(amount: value))
        }else if(value <= -1000000){
           return String(format: "%@ Tr", GeneralUtils.stringVietnameseMoneyFormatWithNumberDouble(amount: value/1000000))
        }else if(value <= -1000000000){
           return String(format: "%@ Tỷ", GeneralUtils.stringVietnameseMoneyFormatWithNumberDouble(amount: value/1000000000))
        }
        return String(format: "%@", GeneralUtils.stringVietnameseMoneyFormatWithNumberDouble(amount: value))
        
    }
    
}


