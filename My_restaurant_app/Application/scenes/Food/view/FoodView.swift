//
//  FoodView.swift
//  SwiftUI-demo
//
//  Created by Pham Khanh Huy on 08/09/2024.
//



import SwiftUI

struct FoodView: View {
    var order:OrderDetail? = nil
    @State var is_gift = -1
    
    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color
    @StateObject var viewModel = FoodViewModel()
    @EnvironmentObject var appRouter: TabBarViewModel
    
    @Environment(\.presentationMode) var presentationMode
    @State var btnArray:[(id:Int,title:String,isSelected:Bool)] = []
    

    var body: some View {
    
        VStack(spacing:0){
            
          
            Spacer()
            
            Rectangle()
                .fill(Color(.systemGray6))
                .frame(maxHeight: 8)
            
            HeaderView(searchText:$viewModel.APIParameter.key_word,btnArray: $btnArray){id in
                handleChooseCategory(id: id)
            }
            
        
            if viewModel.APIParameter.category_type != .buffet_ticket && viewModel.APIParameter.is_out_stock == ALL && !viewModel.categories.isEmpty{
                Divider()
                categoryCollection
               
            }
            
            Divider()
            
            
            FoodList(viewModel: viewModel)
            
            if (viewModel.APIParameter.category_type == .buffet_ticket && !viewModel.buffets.filter{$0.isSelect}.isEmpty) ||
                (viewModel.APIParameter.category_type != .buffet_ticket && !viewModel.foods.filter{$0.isSelect}.isEmpty)
            {
                
                bottomBtn
            }
           
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(String(format: "GỌI MÓN - %@", viewModel.order.table_name))
                    .font(font.b_16)
                    .foregroundColor(color.orange_brand_900)
            }
        }
        .onAppear(perform: {
            
            if let order = self.order{
                viewModel.order = order
//                viewModel.APIParameter.is_allow_employee_gift = is_gift
            }
//            dLog(is_gift)
            self.firstSetup(order: viewModel.order)
            viewModel.reloadContent()
        })
        .onReceive(viewModel.$navigateTag) { tag in

            if tag == 0 {
                self.presentationMode.wrappedValue.dismiss()
            }else if tag == 1{
                self.presentationMode.wrappedValue.dismiss()
                appRouter.currentPage = .order
            }
            
                        
        }
        .sheet(isPresented: $viewModel.presentSheet.present,content: {
            
            if let item = viewModel.presentSheet.item{
                ChooseOptionView(item:item){result in
              
                    if let pos = viewModel.foods.firstIndex(where: {$0.id == result.id}){
                        viewModel.foods[pos] = result
                    }
                    
                }
            }
          
        })
        .fullScreenCover(isPresented: $viewModel.presentFullScreen.show,content: {

            let item = viewModel.presentFullScreen.item
          
            switch viewModel.presentFullScreen.popupType{
                
                case .note:
                    NoteView(isPresent:$viewModel.presentFullScreen.show, id: item?.id ?? 0,inputText: item?.note ?? ""){_, note in
                 
                        if let position = viewModel.foods.firstIndex(where: {$0.id == item?.id ?? 0}){
            
                            viewModel.foods[position].note = note
                        }
                    }

                case .discount:
                    EnterPercentView(isPresent:$viewModel.presentFullScreen.show)
   
                default:
                    EmptyView()
            }
            
        })
        
    }
    
    
    private var categoryCollection:some View{
        ScrollView(.horizontal,showsIndicators: false){
            HStack(spacing:10){
                ForEach(viewModel.categories, id: \.id){cate in
                    Button(action: {
                        for (i,category) in viewModel.categories.enumerated() {
                            viewModel.categories[i].isSelect = cate.id == category.id ? true : false
                        }
    
                        viewModel.APIParameter.category_id = cate.id
                        viewModel.reloadContent()
                        
                    }) {
                        Text(cate.name)
                            .font(font.sb_13)
                            .foregroundColor(cate.isSelect ? .white : .orange)
                            .padding(EdgeInsets(top: 7, leading: 20, bottom: 7, trailing: 20))

                    }
                    .overlay(RoundedRectangle(cornerRadius: 20, style: .circular).stroke(Color.orange, lineWidth: 2))
                    .background(cate.isSelect ? .orange : .white)
                    .cornerRadius(25)
                }
            }
        }
        .padding(.horizontal,10)
        .padding(.vertical,15)

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
                    .background(Color(ColorUtils.gray_200()))
                    .cornerRadius(10)
            }
            
            Button(action: {
                
                if viewModel.order.id > 0{
                    viewModel.processToAddFood()
                }else{
                    
                    if viewModel.order.table_id == 0{
                        viewModel.createTakeOutOder()
                    }else{
                        viewModel.createDineInOrder()
                    }
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


#Preview {
    FoodView()
}
