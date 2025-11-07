//
//  FoodList.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 21/09/2024.
//

import SwiftUI

struct FoodList: View {

    @ObservedObject var viewModel:FoodViewModel
    @State private var isPresented = false

    var body: some View {
        
        
        
        if (viewModel.APIParameter.categoryType == .buffet_ticket && viewModel.buffets.isEmpty) ||
            (viewModel.APIParameter.categoryType != .buffet_ticket && viewModel.foods.isEmpty)
        {
            EmptyData()
            
        }
        else{
            List {
                viewModel.APIParameter.categoryType == .buffet_ticket
                ? AnyView(buffetSection)
                : AnyView(foodSection)
            }
            .background(.white)
            .listStyle(.plain)
        }
        
    }
    
    private var foodSection: some View {
        Section {
            ForEach($viewModel.foods) { item in
                FoodListCell(viewModel: viewModel, item: item)
                    .redacted(reason: .placeholder)
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        let disable = (item.wrappedValue.category_type != .service && item.wrappedValue.restaurant_kitchen_place_id == 0) || (item.wrappedValue.is_out_stock == ACTIVE)
                        

                        let note = SwipeAction.note(action: {
                            viewModel.presentFullScreen = (true, .note, item.wrappedValue)
                        })
                        
                        let discount = SwipeAction.discount(action: {
                            viewModel.presentFullScreen = (true, .discount, item.wrappedValue)
                        })
                        
                        SwipeActionView(actions:disable ? [] : [discount, note])
                    }
                    .onAppear {
                        if viewModel.foods.last?.id == item.id {
                            viewModel.loadMoreContent(currentItem: item.wrappedValue)
                        }
                    }
                    .disabled(
                        (item.wrappedValue.category_type != .service && item.wrappedValue.restaurant_kitchen_place_id == 0) ||
                        (item.wrappedValue.is_out_stock == ACTIVE)
                    )// Disable entire cell if item is disabled
    
            }.defaultListRowStyle()
        }
    }
    

    
    private var buffetSection:some View{
        
        Section(header: Text(viewModel.APIParameter.categoryType.description)) {
            ForEach($viewModel.buffets) { item in
             
                BuffetListCell(viewModel:viewModel,item: item)
                    .swipeActions(edge: .trailing,allowsFullSwipe: false) {
                    
                
                        let discount = SwipeAction.discount(action: {
                            viewModel.presentFullScreen = (true,.discount,nil)
                        })
                        
    
                        SwipeActionView(actions: [discount])
                    }
                
            }
            .defaultListRowStyle()
        }
    }
}



//#Preview {
//    FoodList()
//    
//}
