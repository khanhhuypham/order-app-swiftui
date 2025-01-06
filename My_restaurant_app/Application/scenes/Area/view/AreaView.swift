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
    
    
    
    var title: String? = nil
    var orderAction: OrderAction? = nil
    var selectedId:Int? = nil
    var completion:(() -> Void)? = nil
  

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
                        
                        ForEach($viewModel.table) {$table in
                          
                            TableView(table:$table).onTapGesture {
                                
                                if let action = viewModel.orderAction{
                                    switch action {
                                        case .moveTable:
                                            viewModel.presentDialog = true
                                            viewModel.to = table
                                            break
                                        
                                        case .mergeTable:
                                            table.is_selected.toggle()
                                            break
                                        
                                        case .splitFood:
                                            viewModel.to = table
                                            viewModel.presentDialog = true
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
                 
                }
            }
            
            Spacer()
            
            if let action = viewModel.orderAction,action == .mergeTable{
                btnGroup
            }
        }
        .navigationTitle("Khu vực")
        .fullScreenCover(isPresented: $viewModel.presentDialog, content: {
            
            if let action = viewModel.orderAction,
               let from = viewModel.selected,
               let to = viewModel.to{
                
                ConfirmToMoveTable(
                    title:action == .moveTable ? "XÁC NHẬN CHUYỂN BÀN" : "XÁC NHẬN TÁCH MÓN",
                    from: from,
                    to: to,
                    completion:{
                        if action == .moveTable{
                            viewModel.moveTable(from: from.id, to: to.id)
                            self.presentationMode.wrappedValue.dismiss()
                            completion?()
                            
                        }else{
                            viewModel.presentSheet = true
                        }
                        
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
        .onChange(of: viewModel.presentDialog) { newValue in
            if !newValue {
                print("Sheet dismissed (using binding and dismiss)")
                 //Completion logic
            }
        }
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
    
    private var btnGroup:some View {
        
        HStack(spacing:20){
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                
                Label(title: {
                    Text("HUỶ").font(font.b_18)
                }, icon: {
                    Image("icon-cancel", bundle: .main)
                }).frame(maxWidth: .infinity,maxHeight:.infinity)
                    .foregroundColor(.red)
                    .background(color.gray_200)
                
            }
            .cornerRadius(8)
            .buttonStyle(.plain)
            
            Button {
                viewModel.mergeTable()
            } label: {
                Label(title: {
                    Text("ĐỒNG Ý").font(font.b_18)
                }, icon: {
                    Image("icon-checkmark",bundle: .main)
                })
                .frame(maxWidth: .infinity,maxHeight:.infinity)
                .foregroundColor(.white)
                .background(color.orange_brand_900)
  
            }
            .cornerRadius(8)
            .buttonStyle(.plain)
            
        }
        .frame(height: 45)
        .padding()
        
        
    }
}

#Preview {
    AreaView()
}
