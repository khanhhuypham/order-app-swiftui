//
//  MoveOrderItems.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 16/10/25.
//

import SwiftUI


struct MoveOrderItems:View{
    @Injected(\.colors) var color: ColorPalette
    @Injected(\.fonts) var font: Fonts
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: MoveOrderItemsViewModel = MoveOrderItemsViewModel()
    @State private var name = ""
    var order:Order = .init()

    
    var body: some View {
        
        VStack(alignment:.leading,spacing:0){
            
            Text(String(format:"tách món từ bàn %@ sang %@", viewModel.order.table_name, name).uppercased())
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(font.b_18)
                .frame(maxWidth: .infinity,maxHeight: 50)
                .background(color.orange_brand_900)
           
            List{
                ForEach($viewModel.dataArray, id: \.id){$item in
                    HStack{
                        HStack{
                            LogoImageView(imagePath: item.food_avatar,mold:.square)
                            VStack(alignment:.leading){
                                Text(item.name)
                                    .font(font.sb_14)
                                HStack{
                                    Text("Còn lại")
                                    Text(String(format:"%.0f",item.quantity - item.quantity_change)).foregroundColor(color.orange_brand_900)
                                    Text("Phần")
                                }
                                .font(font.r_12)
                                .foregroundColor(color.blue_brand_700)
                            }
                        }
                        
                        Spacer()
                        
                        QuantityView(width: 25,height:25, quantity: $item.quantity_change){(type,quantity) in
                          
                            let condition = item.is_sell_by_weight == ACTIVE ||
                            item.is_gift == ACTIVE ||
                            item.order_detail_additions.count > 0
        
                            
                            switch type{
                                case .minus:
                                    item.quantity_change -= condition ? quantity : 1
                                    break
                                    
                                case .plus:
                                    item.quantity_change += condition ? quantity : 1
                                    break
                                    
                                default:
                                    break
                                
                            }
                            
                            if item.quantity_change > 0 {
                                item.isChange = true
                                item.quantity_change = item.quantity_change >= item.quantity ? item.quantity : item.quantity_change
                            }else{
                                item.isChange = false
                                item.quantity_change = 0
                            }
                           
                        }
                        .padding(.trailing,8)
                        .font(font.r_14)
                    }
                    .padding()
                }
                .buttonStyle(.plain)
                .defaultListRowStyle()
            }
            .padding(.vertical)
            .listStyle(.plain)
            
            
            Spacer()
            Divider()
            bottomBtn
        }
        .navigationTitle("")
        .onAppear(perform: {
            viewModel.order = order
            Task{
                await viewModel.getOrdersNeedMove()
            }
     
        })
        
      
       
    }

    private var bottomBtn:some View{
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Hủy")
                    .font(font.b_16)
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .background(color.gray_200)
                    .cornerRadius(10)
            }
            
            Button(action: {
                
                var list:[FoodSplitRequest] = viewModel.dataArray.filter{$0.isChange}.map{data in
                    var item = FoodSplitRequest.init()
                    item.order_detail_id = data.id
                    item.quantity = data.quantity_change
                   
                    return item
                }

                Task{
                    await viewModel.moveFoods(selectedItems: list)
                }
            }) {
                Text("Đồng ý")
                    .font(font.b_16)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .background(Color.orange)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}



