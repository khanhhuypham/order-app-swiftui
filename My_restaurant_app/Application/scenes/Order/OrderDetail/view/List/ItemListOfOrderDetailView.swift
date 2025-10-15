//
//  ItemListOfOrderDetailView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 13/09/2024.
//

import SwiftUI


struct OrderList: View, ReasonCancelItemDelegate {
    
    
    func cancel(item: OrderItem) {}
    
    @ObservedObject var viewModel:OrderDetailViewModel
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    
    var body: some View {
       
        List{
            
            if let buffet = viewModel.order.buffet {
                // Create a non-optional Binding<Buffet>
                let buffetBinding = Binding<Buffet>(
                    get: { buffet },
                    set: { newValue in
                        $viewModel.order.buffet.wrappedValue = newValue
                    }
                )
                
                BuffetOfOrderListCell(item: buffetBinding)
                    .swipeActions(edge: .trailing,allowsFullSwipe: false) {
                        let edit = SwipeAction.edit(action: {
                            dLog("action edit")
                        })
                    
                        let cancel = SwipeAction.cancel(action: {
                            dLog("action cancel")
                        })
                        
                        SwipeActionView(actions: [cancel,edit])
                    }.defaultListRowStyle()
            
            }
            
            ForEach($viewModel.order.orderItems) { data in
         
                OrderListItem(
                    item: data,
                    onIncrease: {
                        let item = data.wrappedValue
                        item.is_gift == DEACTIVE
                        ? viewModel.setQuantity(for: item, quantity:item.quantity + (item.is_sell_by_weight == ACTIVE ? 0.01 : 1))
                        : {}()
                    },
                    onDecrease: {
                        let item = data.wrappedValue
                        item.is_gift == DEACTIVE
                        ? viewModel.setQuantity(for: item, quantity:item.quantity - (item.is_sell_by_weight == ACTIVE ? 0.01 : 1))
                        : {}()
                    }
                ).swipeActions(edge: .trailing) {
                    let item = data.wrappedValue
                    SwipeActionView(actions: setupSwipeAction(data: item))
                }.defaultListRowStyle()
                
            }
        }.listStyle(.plain)
    
    }
    
    func setupSwipeAction(data:OrderItem) -> [SwipeAction]{
        var actions:[SwipeAction] = []
        
        let note = SwipeAction.note(action: {
            viewModel.showPopup = (true,.note,data)
        })
        let discount = SwipeAction.discount(action: {
            viewModel.showPopup = (true,.discount,data)
        })
        let edit = SwipeAction.edit(action: {
            dLog("action edit")
        })
        let split = SwipeAction.split(action: {
            dLog("action split")
        })
        let cancel = SwipeAction.cancel(action: {
            viewModel.showPopup = (true,.cancel,data)
        })
        
        switch data.status {

            case .pending:
                if data.buffet_ticket_id ?? 0 > 0{
                    actions = [cancel,note]
                }else{
                    if data.is_gift == ACTIVE{
                        actions = data.order_detail_additions.count > 0
                        ? [cancel,split,edit,note]
                        : [cancel,split,note]
                    }else{
                        actions = data.order_detail_additions.count > 0
                        ? [cancel,split,edit,discount,note]
                        : [cancel,split,discount,note]
                    }
                }

            case .done,.cooking:

                switch data.category_type {
                    case .buffet_ticket:
                        actions = [cancel,edit]


                    case .drink, .other:
                        if data.quantity == 0 && data.buffet_ticket_id == 0{
                            actions = []
                        }else{
                            actions = data.is_gift == ACTIVE || data.is_extra_charge == ACTIVE
                            ? [cancel,split]
                            : [cancel,discount,split]
                        }

                    default:
                        if data.buffet_ticket_id ?? 0 > 0{
                            actions = [cancel]
                        }else{
                            actions = data.is_gift == ACTIVE || data.is_extra_charge == ACTIVE
                            ? [cancel,split]
                            : [cancel,discount,split]
                        }

                }

            case .cancel,.not_enough:
                actions = []

            case .servic_block_stopped,.servic_block_using:
                actions = [cancel, split, edit]

        }
        
        return actions
      
    }
    
    
}






