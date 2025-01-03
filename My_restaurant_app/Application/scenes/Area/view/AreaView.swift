//
//  AreaView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 03/09/2024.
//

import SwiftUI


struct AreaView: View {
    @Injected(\.colors) var color: ColorPalette
    @Injected(\.fonts) var font: Fonts
    @ObservedObject var viewModel:AreaViewModel = AreaViewModel()
    @State private var routeLink:(tag:String?,data:Table) = (tag:nil,data:Table())
    var title: String? = nil
    var orderAction: OrderAction? = nil
    var selectedId:Int? = nil
    var fromId:Int? = nil

    
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        
        VStack(spacing:0){
            NavigationLink(destination:lazyNavigate(OrderDetailView(order:Order(table: routeLink.data))), tag: "OrderDetailView", selection: $routeLink.tag) { EmptyView() }
            NavigationLink(destination:lazyNavigate(FoodView(order:OrderDetail(table: routeLink.data))), tag: "FoodView", selection: $routeLink.tag) { EmptyView() }
            
            if let title = self.title{
                Text(title)
                    .foregroundColor(.white)
                    .font(font.b_18)
                    .frame(maxWidth: .infinity,maxHeight: 50)
                    .background(color.orange_brand_900)
                
            }
            Divider()
            HorizontalBtnGroup(
                btnArray:$viewModel.area,
                btnClosure:{id in
                    if let area = viewModel.area.filter{$0.isSelect}.first{
                       viewModel.getTables(areaId: area.id)
                    }
                }
            )
            
            hintView
            
            ScrollView(.vertical){
                VStack {
                    LazyVGrid(columns: columns, spacing: 16) {
                        
                        ForEach(Array(viewModel.table.enumerated()), id: \.element.id) { i,table in
                          
                            TableView(table:table).onTapGesture {
                                
                                if let action = viewModel.orderAction{
                                    switch action {
                                        case .moveTable:
                                            viewModel.presentDialog = true
                                            viewModel.to = table
                                        
                                        case .mergeTable:
                                            self.viewModel.table[i].is_selected.toggle()
                                            break
                                        
                                        case .splitFood:
                                            viewModel.presentSheet = true
                                            break
                                            
                                        default:
                                            break
                                    
                                    }
                                    
                                    
                                }else{
                                    routeLink = table.order?.id ?? 0 > 0
                                    ? (tag:"OrderDetailView",data:table)
                                    : (tag:"FoodView",data:table)
                                }

                            }
                          
                        }
                    }
                    Spacer()
                }
            }
        }
        .navigationTitle("Khu vực")
        .fullScreenCover(isPresented: $viewModel.presentDialog, content: {
    
            if viewModel.orderAction == .moveTable,
               let from = viewModel.from,
               let to = viewModel.to{
                ConfirmToMoveTable(
                    isPresent: $viewModel.presentDialog,
                    from: from,
                    to: to,
                    completion:{
                        viewModel.moveTable(from: from.id, to: to.id)
                    }
                )
            }
            
        })
        .sheet(isPresented:$viewModel.presentSheet , content: {
            SplitFood()
        })
        .onAppear(perform: {
            viewModel.bind(view: self)
            viewModel.orderAction = orderAction
            viewModel.getAreas()
        })
    }
    
    
    private var hintView:some View {
        HStack{
            
            HStack{
                Circle()
                    .fill(.gray)
                    .frame(width: 16, height: 16)
                Text("Bàn trống")
                    .font(.system(size: 12))
                    .foregroundColor(.primary)
            }

                        
            HStack{
                Circle()
                    .fill(.blue)
                    .frame(width: 16, height: 16)
                Text("Bàn phục vụ")
                    .font(.system(size: 12))
                    .foregroundColor(.primary)
            }

            
            HStack{
                Circle()
                    .fill(.green)
                    .frame(width: 16, height: 16)
                Text("Bàn đặt")
                    .font(.system(size: 12))
                    .foregroundColor(.primary)
            }

            HStack{
                
                Circle()
                    .fill(.red)
                    .frame(width: 16, height: 16)
                Text("Bàn gọp")
                    .font(.system(size: 12))
                    .foregroundColor(.primary)
            }

        
        }
        .frame(maxWidth:.infinity,maxHeight: 50)
        .background(Color(UIColor.systemGray6)) // Light gray background
    }
    
}

#Preview {
    AreaView()
}
