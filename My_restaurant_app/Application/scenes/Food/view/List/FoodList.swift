//
//  FoodList.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 21/09/2024.
//

import SwiftUI

struct FoodList: View {
    @ObservedObject var viewModel: FoodViewModel
    @State private var isPresented = false
    
    
    // MARK: - Computed Properties
    private var shouldShowEmptyData: Bool {
        (viewModel.APIParameter.category_type == .buffet_ticket && viewModel.buffets.isEmpty) ||
        (viewModel.APIParameter.category_type != .buffet_ticket && viewModel.foods.isEmpty)
    }

    var body: some View {
        Group {
            if shouldShowEmptyData {
                EmptyData()
            } else {
                List {
                    if viewModel.APIParameter.category_type == .buffet_ticket {
                        buffetSection
                    } else {
                        foodSection
                    }
                }
                .background(Color.white)
                .listStyle(.plain)
            }
        }
    }


    // MARK: - Food Section
    private var foodSection: some View {
      
        Section(header: Text(viewModel.categories.first(where: { $0.isSelect })?.name ?? "Tất cả món ăn")) {
            ForEach($viewModel.foods, id: \.id) { item in
                FoodListCell(item: item)
                    .onAppear {
                        viewModel.loadMoreContent()
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        let note = SwipeAction.note {
                            viewModel.showPopup = (true, .note, item.wrappedValue)
                        }
                        let discount = SwipeAction.discount {
                            viewModel.showPopup = (true, .discount, item.wrappedValue)
                        }
                        SwipeActionView(actions: [discount, note])
                    }.disabled(item.wrappedValue.out_of_stock)
            }
            .defaultListRowStyle()
        }
    }

    // MARK: - Buffet Section
    private var buffetSection: some View {
        Section(header: Text(viewModel.APIParameter.category_type?.description ?? "")) {
            ForEach($viewModel.buffets, id: \.id) { item in
                BuffetListCell(viewModel: viewModel, item: item)
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        let discount = SwipeAction.discount {
                            viewModel.showPopup = (true, .discount, nil)
                        }
                        SwipeActionView(actions: [discount])
                    }
            }
            .defaultListRowStyle()
        }
    }
}
