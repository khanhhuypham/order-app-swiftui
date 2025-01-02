//
//  FoodView.swift
//  SwiftUI-demo
//
//  Created by Pham Khanh Huy on 08/09/2024.
//



import SwiftUI
import PopupView

struct FoodView: View {
    var order:OrderDetail? = nil
    var is_gift = -1 // 0 = gọi món bình thường | 1 = Tặng món vào hoá đơn| -1 Cả hai
    @Injected(\.fonts) private var fonts
    @ObservedObject var viewModel = FoodViewModel()
    @EnvironmentObject var appRouter: TabBarViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var btnArray:[(id:Int,title:String,isSelected:Bool)] = []
    
   
    var body: some View {
    
        VStack(spacing:0){
            
            HeaderView(searchText:$viewModel.APIParameter.key_word,btnArray: $btnArray){id in
                handleChooseCategory(id: id)
            }
            
            if (viewModel.APIParameter.category_type == .food ||
                viewModel.APIParameter.category_type == .drink ||
                viewModel.APIParameter.category_type == nil) &&
                !viewModel.APIParameter.out_of_stock &&
                !viewModel.categories.isEmpty
            {
                Divider()
                categoryCollection	
                Divider()
            }
            
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
                    .font(fonts.b_16)
                    .foregroundColor(Color(ColorUtils.orange_brand_900()))
            }
        }
        .onAppear(perform: {
        
            if let order = self.order{
                viewModel.order = order
                viewModel.APIParameter.is_allow_employee_gift = 0
            }
            
            self.firstSetup(order: viewModel.order)
            viewModel.getCategories()
        })
        .onReceive(viewModel.$navigateTag) { tag in

            if tag == 0 {
                self.presentationMode.wrappedValue.dismiss()
            }else if tag == 1{
                self.presentationMode.wrappedValue.dismiss()
                appRouter.currentPage = .order
            }
        }
        .presentDialog(isPresented: $viewModel.showPopup.show,content: {
            let item = viewModel.showPopup.item
          
            switch viewModel.showPopup.popupType{
                case .note:
                    NoteView(isPresent:$viewModel.showPopup.show, id: item?.id ?? 0,inputText: item?.note ?? "",completion:{ id, text in
                        if let index = viewModel.foods.firstIndex(where: {$0.id == id}){
                            viewModel.foods[index].note = text
                        }
                    })
                
                case .discount:
                    
                    EnterPercentView(
                        isPresent: $viewModel.showPopup.show,
                        id:item?.id ?? 0,
                        percent:item?.discount_percent ?? nil,
                        title: "GIẢM GIÁ",
                        placeholder: "Vui lòng nhập % bạn muốn giảm giá",
                        completion:{ id, percent in
                            if let index = viewModel.foods.firstIndex(where: {$0.id == id}){
                                viewModel.foods[index].discount_percent = percent
                            }
                        }
                    )
   
                default:
                    EmptyView()
            }
            
        })
  
        
        
    }
    
    
    private var categoryCollection:some View{
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                ForEach(viewModel.categories, id: \.id){cate in
                    Button(action: {

                        for (i,category) in viewModel.categories.enumerated() {
                            viewModel.categories[i].isSelect = cate.id == category.id 
                            ? true
                            : false
                        }

                        viewModel.APIParameter.category_id = cate.id == -1 
                        ? nil
                        : cate.id
                        
                        viewModel.reloadContent()
                        
                    }) {
                        Text(cate.name)
                            .font(fonts.sb_13)
                            .foregroundColor(cate.isSelect ? .white : .orange)
                            .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
//
                    }
                    .overlay(RoundedRectangle(cornerRadius: 20, style: .circular).stroke(Color.orange, lineWidth: 2))
                    .background(cate.isSelect ? .orange : .white)
                    .cornerRadius(25)
                }
            }
        }
        .padding(.vertical,10)
       
    }

    
    
    private var bottomBtn:some View{
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Hủy")
                    .font(fonts.b_16)
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
                        
//                        viewModel.createTakeOutOder()
    
                    }else{
                        viewModel.createDineInOrder()
                    }
                }
                

            }) {
                Text("Đồng ý")
                    .font(fonts.b_16)
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
