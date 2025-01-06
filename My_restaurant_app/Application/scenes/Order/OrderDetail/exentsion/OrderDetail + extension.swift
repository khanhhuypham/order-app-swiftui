//
//  OrderDetail + extension.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 20/09/2024.
//

import UIKit





extension OrderDetailView: EnterPercentDelegate {
    
    func callbackToGetPercent(id:Int,percent: Int){
        if let item = viewModel.order.orderItems.first(where: {$0.id == id}){
            viewModel.discountOrderItem(item: item)
        }
        
    }
    
}


extension OrderDetailView: NotFoodDelegate {
    func callBackNoteFood(id: Int, note: String) {
        if let item = viewModel.order.orderItems.first(where: {$0.id == id}){
            viewModel.addNote(orderDetailId: item.id, note: note)
        }
    }
    

}
