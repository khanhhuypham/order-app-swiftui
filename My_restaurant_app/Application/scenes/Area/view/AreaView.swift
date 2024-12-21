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
    @State var title: String? = nil
    @State private var selection: String? = nil
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        
        VStack(spacing:0){
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
            
            hintView
            
            ScrollView(.vertical){
                VStack {
                    LazyVGrid(columns: columns, spacing: 16) {
                        
                        ForEach($viewModel.table) { table in
                            let data = table.wrappedValue
                            
                            if data.order_id ?? 0 > 0{
                                NavigationLink(destination:OrderDetailView(order: Order(table: data))) {
                                    TableView(table:table)
                                }
                            }else{
                                NavigationLink(destination: FoodView(order:OrderDetail(table: data))) {
                                    TableView(table:table)
                                }
                            }
                            

                        }
                    }
                    Spacer()
                }
            
            }
        }
        .navigationTitle("Khu vực")
        .onAppear(perform: {
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
