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
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel:AreaViewModel = AreaViewModel()
    @State private var routeLink:(tag:String?,data:Table) = (tag:nil,data:Table())
    

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var title: String? = nil
    //=============
    var order: Order? = nil
    var orderAction: OrderAction? = nil
    var completion:(() -> Void)? = nil
    var splitFoodCompletion:((_ from:Table,_ to:Table) -> Void)? = nil
    //=============

    var body: some View {
        
        VStack{
            
            NavigationLink(destination:OrderDetailView(order:Order(table: routeLink.data)), tag: "OrderDetailView", selection: $routeLink.tag) { EmptyView() }
            NavigationLink(destination:FoodView(order:OrderDetail(table: routeLink.data)), tag: "FoodView", selection: $routeLink.tag) { EmptyView() }
            
            if let title = self.title{
                Text(title)
                    .foregroundColor(.white)
                    .font(font.b_18)
                    .frame(maxWidth: .infinity,maxHeight: 50)
                    .background(color.orange_brand_900)
                
            }
            
            Divider()
            
            AreaHeader(areaArray: $viewModel.area,closure: {
                if let area = viewModel.area.filter{$0.isSelect}.first{
                    viewModel.getTables(areaId: area.id)
                }
            })
            
            Divider()
            
            if orderAction == nil{
                hintView
            }
            
            if (viewModel.table.count > 0){
                TableList
            }else{
                EmptyData{
                    viewModel.getAreas()
                }
            }
            
            if viewModel.orderAction == .mergeTable{
                Divider()
                bottomBtn
            }
            
        }
        .navigationTitle("Khu vực")
        .fullScreenCover(isPresented: $viewModel.presentDialog) {
            
            if let action = viewModel.orderAction,
               let order = viewModel.order,
               let to = viewModel.selectedTable
            {
                let from = Table(id: order.table_id, name: order.table_name,status: .using)
                ConfirmToMoveTable(
                    title: action == .moveTable ? "XÁC NHẬN CHUYỂN BÀN" : "XÁC NHẬN TÁCH MÓN",
                    from: from,
                    to: to,
                    completion: {
                        if action == .moveTable{
                            Task{
                                await viewModel.moveTable(from: order.table_id, to: to.id ?? 0)
                            }
                        }else if action == .splitFood{
                            self.splitFoodCompletion?(from,to)
                        }
                       
                    }
                )
            } else {
                EmptyView()
            }
        }
        .onChange(of: viewModel.shouldNavigateBack) { shouldGoBack in
            if shouldGoBack {
                self.presentationMode.wrappedValue.dismiss()
                self.completion?()
            }
        }
        .onAppear(perform: {
            viewModel.order = order
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
    
    private var TableList:some View {
        ScrollView(.vertical){
            VStack {
                LazyVGrid(columns: columns, spacing: 16) {
                    
                    ForEach($viewModel.table) { $table in
                        
                        TableView(table:$table,action: orderAction).onTapGesture {
                            
                            if let action = viewModel.orderAction{
                                
                                switch action {
                                    case .moveTable:
                                        viewModel.presentDialog = true
                                        viewModel.selectedTable = table
                                        break
                                    
                                    case .mergeTable:
                                        table.is_selected.toggle()
                                        break
                                    
                                    case .splitFood:
                                        viewModel.selectedTable = table
                                        viewModel.presentDialog = true

                                        break
                                        
                                    default:
                                        break
                                
                                }
                                
                                
                            }else{
                                routeLink = table.order_id ?? 0 > 0
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
    

    private var bottomBtn:some View{
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                
                Label("HUỶ", systemImage: "xmark")
                    .font(font.b_16)
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .background(color.gray_200)
                    .cornerRadius(8)
                
            }
            
            Button(action: {
               
                if let order = viewModel.order{
                    viewModel.mergeTable(destination_table_id: order.table_id, target_table_ids: viewModel.table.filter{$0.is_selected}.map{$0.id ?? 0})
                }
                
    
            }) {
                
                Label("ĐỒNG Ý", systemImage: "checkmark")
                    .font(font.b_16)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .background(Color.orange)
                    .cornerRadius(8)

            }
        }
        .padding()
    }


}

#Preview {
    AreaView()
}
