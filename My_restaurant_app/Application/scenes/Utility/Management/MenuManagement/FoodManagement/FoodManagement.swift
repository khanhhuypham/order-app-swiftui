//
//  FoodManagement.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 23/10/2024.
//

import SwiftUI

struct FoodManagement: View {
    @Injected(\.colors) var color: ColorPalette
    @Injected(\.fonts) var font: Fonts
    @ObservedObject var viewModel = FoodManagementViewModel()
    @State private var isActive = false
    @State var searchText = ""
    
    
   
    @State private var routeLink:(tag:String?,item:Food) = (tag:nil,item:Food())
    
    var body: some View {
        
        
        VStack(spacing:0){
            NavigationLink(destination: CreateFoodView(item: routeLink.item), tag: "CreateFoodView", selection: $routeLink.tag) { EmptyView() }
            NavigationLink(destination: Text("View B"), tag: "B", selection: $routeLink.tag) { EmptyView() }
            
            textField
            
            TabHeader(tabArray: $viewModel.tabArray){id in
                viewModel.tab = id
                
                if id == 1{
                    viewModel.reloadContent()
                }else{
                    viewModel.getChildrenItems()
                }
                
            }.frame(height: 50)
            
            Rectangle()
                .foregroundColor(color.gray_200)
                .frame(height: 10)
            
            // Tabs
            List {
                
                Section {
                    if viewModel.tab == 1{
                        ForEach(Array($viewModel.foods.enumerated()),id:\.1.id) {index, item in
                            renderCell(data: item.wrappedValue).onAppear(perform: {
                                    viewModel.loadMoreContent()
                            })
                        }
                        .defaultListRowStyle()
                    }else{
                        
                        ForEach($viewModel.childrenItem) { item in
                            renderChildrenItemCell(data: item.wrappedValue)
                        }
                        .defaultListRowStyle()
                    }
                }
            }
            .listStyle(.plain)
            .onAppear(perform: {
                viewModel.reloadContent()
            })
            Divider()
            
            
            Button(action: {
                routeLink = (tag:"CreateFoodView",item:Food())
            }) {
                Text(viewModel.tab == 1 ? "+ THÊM MÓN" : "+ THÊM MÓN BÁN KÈM/TOPPING")
                    .font(font.sb_16)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height:35)
                    .background(color.orange_brand_900)
                    .cornerRadius(8)
            }.padding()
           
        }

        
       
    }
    
    private var textField:some View{
        
        
        // Search bar with icon
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(color.orange_brand_900)
                .padding(.leading,10)

            TextField("Tìm kiếm", text: $searchText)
                .padding(.trailing,20)
                
                
        }
        .frame(maxWidth:.infinity,maxHeight: 30,alignment: .center)
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(color.orange_brand_900, lineWidth: 2))
        .background(color.white.cornerRadius(15))
        .padding(15)
        .background(color.gray_200)
    }
    
   

    
    private func renderCell(data:Food) -> some View{
        HStack(alignment:.center,spacing: 5){
            
            LogoImageView(imagePath: data.avatar,mold:.square)

            VStack(alignment:.leading,spacing: 2){
                Text(data.name)
                    .font(font.r_14)
                

                
                Group{
                    Text(data.price.toString){$0.foregroundColor = ColorUtils.orange_brand_900()} +
                    Text(String(format:"/%@",data.unit_type )){ $0.foregroundColor = ColorUtils.gray_600()}
                }.font(font.sb_13)
                                
            }
            Spacer()
        
            Text(data.status == ACTIVE ? "ĐANG BÁN" : "NGỪNG BÁN")
                .foregroundColor(data.status == ACTIVE ? color.green_600 : color.gray_600)
                .font(font.sb_14)
            
        }
        .padding(8)
        .background(.white)
        .onTapGesture {
            routeLink = (tag:"CreateFoodView",item:data)
        }
    }
    
    
    private func renderChildrenItemCell(data:ChildrenItem) -> some View{
        HStack(alignment:.center,spacing: 5){
            
            LogoImageView(imagePath: data.avatar,mold:.square)

            VStack(alignment:.leading,spacing: 2){
                Text(data.name)
                    .font(font.r_14)
                
                Group{
                    Text(data.price.toString){$0.foregroundColor = ColorUtils.orange_brand_900()} +
                    Text(String(format:"/%@",data.unit_type )){ $0.foregroundColor = ColorUtils.gray_600()}
                }.font(font.sb_13)
                                
            }
            
            Spacer()
            
    
            Text(data.status == ACTIVE ? "ĐANG BÁN" : "NGỪNG BÁN")
                .foregroundColor(data.status == ACTIVE ? color.green_600 : color.gray_600)
                .font(font.sb_14)
            
        }
        .padding(8)
        .background(.white)
   
    }
    
    
}

#Preview {
    FoodManagement()
}
