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
        
        
        if (viewModel.APIParameter.category_type == .buffet_ticket && viewModel.buffets.isEmpty) ||  
            (viewModel.APIParameter.category_type != .buffet_ticket && viewModel.foods.isEmpty)
        {
            EmptyData()
        }else{
            List {
                viewModel.APIParameter.category_type == .buffet_ticket
                ? AnyView(buffetSection)
                : AnyView(foodSection)
            }
            .background(.white)
            .listStyle(.plain)
        }
        
    }
    
    
    private var foodSection:some View{
        let category = viewModel.categories.first(where: {$0.isSelect})?.name ?? viewModel.APIParameter.category_type.description
        
        return Section(header: Text(category)) {
            
            ForEach(Array($viewModel.foods.enumerated()),id:\.1.id) {index, item in
                
                FoodListCell(item: item)
                    .swipeActions(edge: .trailing,allowsFullSwipe: false) {
                    
                        let note = SwipeAction.note(action: {
                            viewModel.showPopup = (true,.note,item.wrappedValue)
                        })
                        
                        let discount = SwipeAction.discount(action: {
                         
                            viewModel.showPopup = (true,.discount,item.wrappedValue)
                        })
                        
    
                        SwipeActionView(actions: [discount,note])
                    }
                    .onAppear(perform: {
             
                        viewModel.loadMoreContent(currentItem: item.wrappedValue)
                       
                    })
               
                
            } .defaultListRowStyle()

        }
    }
    
    private var buffetSection:some View{
        
        Section(header: Text(viewModel.APIParameter.category_type.description)) {
            ForEach($viewModel.buffets) { item in
             
                BuffetListCell(viewModel:viewModel,item: item)
                    .swipeActions(edge: .trailing,allowsFullSwipe: false) {
                    
                
                        let discount = SwipeAction.discount(action: {
                            viewModel.showPopup = (true,.discount,nil)
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
