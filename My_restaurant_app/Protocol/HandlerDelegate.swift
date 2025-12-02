//
//  HandlerDelegate.swift
//  TechresOrder
//
//  Created by macmini_techres_03 on 16/01/2023.
//

import UIKit


protocol ArrayChooseUnitViewControllerDelegate {
    func selectUnitAt(pos: Int)
}


protocol MonthSelectDelegate {
    func selected(month:Int, year:Int)
}

protocol AdditionDelegate{
    func additionQuantity(quantity:Int, row:Int, itemIndex:Int, countGift: Int, food_addition_type:Int)

}


protocol UsedGiftDelegate{
    func callBackUsedGift(order_id:Int)
}


protocol AccountInforDelegate{
    func callBackToAcceptSelectedArea(selectedArea:[String:Area])
}

protocol MaterialDelegate{
    func callBackNoteDelete(note: String)
}

protocol ArrayShowDropdownViewControllerDelegate {
    func selectAt(pos: Int)
}

protocol EnterPercentDelegate {
    func callbackToGetPercent(id:Int,percent: Int)
}


protocol dateTimePickerDelegate {
    func callbackToGetDateTime(didSelectDate:Date)
}


protocol DialogEnterOTPDelegate {
    func callbackToGetAccessToken(accessToken:String)
}

