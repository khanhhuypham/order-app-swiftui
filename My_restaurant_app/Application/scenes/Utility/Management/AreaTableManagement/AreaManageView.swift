//
//  AreaManageView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 11/10/2024.
//

import SwiftUI

struct AreaManageView: View {
    @Injected(\.colors) var color: ColorPalette
    @Injected(\.fonts) var font: Fonts
    
    @ObservedObject var viewModel = AreaManagementViewModel()
   
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
   

      var body: some View {
         
          VStack(spacing:0){
              // Tabs
              Divider()
              TabHeader
              Divider()

              if viewModel.APIParameter.tab == 1{
                  ScrollView {
                      LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())], spacing: 20) {
                          ForEach($viewModel.areaList, id: \.id) { item in
                              AreaCardView(item:item).frame(height:150).onTapGesture(perform: {
                                  viewModel.showPopup(area: item.wrappedValue)
                              })
                          }
                      }.padding(30)
                  }
              }else{
       
                  HorizontalBtnGroup(btnArray:$viewModel.btnArray){id in
                      var areaList = viewModel.areaList
                      for (i,area) in areaList.enumerated(){
                          areaList[i].isSelect = area.id == id
                      }
                      viewModel.areaList = areaList
                      
                      viewModel.getTables(areaId: id)
                  }.padding(.horizontal,12)
                  
                  Divider()
                  
                  ScrollView(.vertical){
                      VStack {
                          LazyVGrid(columns: columns, spacing: 16) {
                              
                              ForEach($viewModel.table) { table in
                                
                                  TableView(table:table).onTapGesture(perform: {
                                      viewModel.showPopup(table: table.wrappedValue)
                                  })

                              }
                          }
                          Spacer()
                      }
                  
                  }.padding(.vertical,10)
                  
              }
 
              Divider()
              if viewModel.APIParameter.tab == 1{
                  ButtonGroupOfArea
              }else{
                  ButtonGroupOfTable
              }
          }
          .navigationBarTitleDisplayMode(.inline)
          .toolbar {
             ToolbarItem(placement: .principal) {
                 Text("QUẢN LÝ KHU VỰC/BÀN")
                     .font(font.b_16)
                     .foregroundColor(color.orange_brand_900)
             }
          }
          .presentDialog(isPresented:  $viewModel.APIParameter.isPresent,content: {
              if let popup = viewModel.APIParameter.popup{
                  dialog(isPresented: $viewModel.APIParameter.isPresent){
                      AnyView(popup)
                  }
              }
              
          })
          
          .onAppear(perform: {
              viewModel.getAreaList()
          })
              
          
      }
    
    private var TabHeader:some View{
        HStack{
            Button(action: {
                viewModel.APIParameter.tab = 1
                viewModel.getAreaList()
            }) {
                VStack(alignment:.center,spacing:0){
                    
                    Spacer()
                    
                    Text("QUẢN LÝ KHU VỰC")
                        .font(font.sb_16)
                        .foregroundColor(viewModel.APIParameter.tab == 1 ? color.green_600 : color.green_200)
                    Spacer()
                    
                    Rectangle()
                        .frame(height:viewModel.APIParameter.tab == 1 ? 5 : 0) // Height of the underline
                        .foregroundColor(color.green_600) // Color of the underline
                        .opacity(0.7) // Adjust opacity if needed
                }

            }
        
          
            Button(action: {
                viewModel.APIParameter.tab = 2
                viewModel.getAreaList()
            }) {
                VStack(alignment:.center,spacing:0){
                    Spacer()
                    Text("QUẢN LÝ BÀN")
                        .font(font.sb_16)
                        .foregroundColor(viewModel.APIParameter.tab == 2 ? color.green_600 : color.green_200)
                    
                    Spacer()
                    
                    Rectangle()
                        .frame(height: viewModel.APIParameter.tab == 2 ? 5 : 0) // Height of the underline
                        .foregroundColor(color.green_600) // Color of the underline
                        .opacity(0.7) // Adjust opacity if needed
                }
            }
        }.frame(maxHeight: 50)
    }
    
    private var ButtonGroupOfTable:some View{
        HStack{
            Button(action: {
//                var table = Table()
//                table.area_id = viewModel.APIParameter.selectedArea
                viewModel.showPopup(table: Table())
            }) {
                Text("+ THÊM MỚI")
                    .font(font.sb_16)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height:35)
                    .background(color.orange_brand_900)
                    .cornerRadius(8)
            }
            
            Button(action: {
                viewModel.showPopup()
            }) {
                
                Text("+ THÊM NHANH")
                    .font(font.sb_16)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height:35)
                    .background(color.orange_brand_900)
                    .cornerRadius(8)
            }
        }.padding()
    }
    
    private var ButtonGroupOfArea:some View{
        Button(action: {
            viewModel.showPopup(area: Area())
        }) {
            Text("+ THÊM KHU VỤC")
                .font(font.sb_16)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height:35)
                .background(color.orange_brand_900)
                .cornerRadius(8)
        }.padding()
    }


}

#Preview {
    AreaManageView()
}
