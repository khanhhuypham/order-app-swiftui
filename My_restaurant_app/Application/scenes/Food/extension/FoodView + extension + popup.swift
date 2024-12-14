//
//  FoodView + extension + popup.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 28/09/2024.
//

import UIKit

extension FoodView:NotFoodDelegate,EnterPercentDelegate{
    func callbackToGetPercent(id: Int, percent: Int) {
        if let pos = viewModel.foods.firstIndex(where: {$0.id == id}){
            viewModel.foods[pos].discount_percent = percent
        }

    }
    
    func callBackNoteFood(id:Int, note:String){
        
        if let pos = viewModel.foods.firstIndex(where: {$0.id == id}){
            viewModel.foods[pos].note = note
        }
        
    }
    
    

}
