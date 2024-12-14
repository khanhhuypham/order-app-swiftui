//
//  OrderDetail.swift
//  SwiftUI-demo
//
//  Created by Pham Khanh Huy on 07/09/2024.
//

import SwiftUI
import PopupView

struct OrderDetailView:View{
    @Injected(\.colors) var color: ColorPalette
    @Injected(\.fonts) var font: Fonts
    @State private var isLinkActive = false
    @ObservedObject var viewModel: OrderDetailViewModel
    
    init(order:Order? = nil) {
        self.viewModel = OrderDetailViewModel(order: order)
    }
    

    var body: some View {
        
        VStack(alignment:.leading,spacing:0){
            
            Divider()
            
            View_of_total_amount
            
            Divider()
            
            OrderList(viewModel: viewModel)

            Divider()
            
            View_of_estimate_amount
            
           
            if !viewModel.order.orderItems.filter{$0.isChange}.isEmpty || !viewModel.printItems.isEmpty{
                Divider()
                View_of_send_chef_bar_and_save
            }
           
            Divider()
   
            bottomBtnGroup
                .buttonStyle(.plain)
               
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
           ToolbarItem(placement: .principal) {
               Text(String(format: "#%d-%@", viewModel.order.id,viewModel.order.table_name))
                   .fontWeight(.semibold)
                   .foregroundColor(viewModel.order.status.fgColor)
           }
        }.onAppear(perform: {
            viewModel.getOrder()
        })
        .popup(isPresented: $viewModel.showPopup.show) {
            let item = viewModel.showPopup.item
            
            switch viewModel.showPopup.PopupType{
                case .note:
                    NoteView(delegate: self,id: item?.id ?? 0,inputText: item?.note ?? "")
        
                case .discount:
                    EnterPercentView(
                        delegate: self,
                        id:item?.id ?? 0,
                        percent:item?.discount_percent ?? 0,
                        title: "GIẢM GIÁ",
                        placeholder: "Vui lòng nhập % bạn muốn giảm giá"
                    )
   
                case .edit:
                    EmptyView()
                
                case .split:
                    EmptyView()
                
                case .cancel:
                    PopupMiddle(delegate:self,item: viewModel.showPopup.item)
            }
            

        } customize: {
            $0.closeOnTapOutside(true)
            .type(.floater())
            .disappearTo(.centerScale)
            .position(.center)
            .closeOnTap(false)
            .backgroundColor(.black.opacity(0.4))
        }
        //        .popover(isPresented: $viewModel.showpopup) {
        //            Text("Your content here")
        //              .font(.headline)
        //              .padding()
        //        }
        //        .confirmationDialog(String("Are you sure?"),isPresented: $viewModel.showDialog,titleVisibility: .hidden) {
        //            Button("Yes") { }
        //            Button("No", role: .cancel) { }
        //
        //        } message: {
        //            Text("This action cannot be undone. Would you like to proceed?")
        //        }
        //        .sheet(isPresented: $viewModel.showSheet, content: {
        //            Text("Phạm khánh huy")
        //        })
        //        .fullScreenCover(isPresented: $viewModel.showingFullScreen) {
        //            Text("Phạm khánh huy")
        //        }


    }
        
    private var View_of_total_amount: some View {
        HStack(spacing: 10) {
          
            Image("icon-coins", bundle: .main)
                .resizable()
                .frame(width: 30,height: 30)
                .foregroundColor(color.gray_600)
            
            VStack(alignment:.leading){
                Text("tổng thanh toán".uppercased())
                    .font(font.r_14)
                    .foregroundColor(color.gray_600)
                
                Text(viewModel.order.total_amount.toString)
                    .foregroundColor(viewModel.order.status.fgColor)
                    .font(font.sb_16)
            }
            
        }
        .frame(height: 50)
        .padding(.vertical,5)
        
    }
    
    private var View_of_estimate_amount: some View {
        HStack {
            Spacer()
            
            Text("Tổng ước tính")
                    .font(font.r_14)
                    .foregroundColor(.black)
            Spacer()
            
            Text(viewModel.order.amount.toString)
                    .font(font.b_14)
                    .foregroundColor(viewModel.order.status.fgColor)
                    .padding(.trailing,10)
        
        }
        .frame(height: 45)
        .frame(maxWidth: .infinity)
        
    }
    
    
    private var View_of_send_chef_bar_and_save: some View {
        
            HStack (alignment: .center){
                
                Button(action: {
                    // Action for first button
                }) {
                    
                
                    HStack{
                        Image(systemName: "printer")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundColor(.white)
                        
                        
                        Text("GỬI BẾP/BAR")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundColor(.white)
                        
                    }
                }
                .padding(EdgeInsets(top:10, leading: 15, bottom: 10, trailing: 15))
                .background(Color.orange)
                .cornerRadius(10)
                .overlay(
                    Text(String(format: "%d", viewModel.printItems.count))
                        .font(.system(size: 14,weight: .bold))
                        .padding(10)
                        .foregroundColor(.white)
                        .background(.red)
                        .clipShape(Circle())
                        .offset(x: 15, y: -15), // Position badge in the top-right corner
                    alignment: .topTrailing
                )
                .isHidden(viewModel.printItems.isEmpty)
                
                Spacer()
                
                Button(action: {
                    // Action for second button
                }) {
                    
                    HStack{
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                        
                        Text("LƯU")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundColor(.white)
                    }
                    
                    
                }
                .padding(EdgeInsets(top:10, leading: 15, bottom: 10, trailing: 15))
                .background(Color.green)
                .cornerRadius(10)
                .overlay(
                    
                    Text(String(viewModel.order.orderItems.filter{$0.isChange}.count))
                        .font(.system(size: 14,weight: .bold))
                        .padding(10)
                        .foregroundColor(.white)
                        .background(.red)
                        .clipShape(Circle())
                        .offset(x: 15, y: -15),
                    alignment: .topTrailing
                )
                .isHidden(viewModel.order.orderItems.filter{$0.isChange}.isEmpty)
            }
            .padding(EdgeInsets(top:12, leading: 15, bottom: 12, trailing: 15))
    
    }
    
    
    private var bottomBtnGroup: some View {
        let cornerRadius:CGFloat = 8
        
        return HStack(alignment: .center){
            
            NavigationLink(destination: Text("Pham khanh huy"), label: {
                VStack{
                  
                    Spacer()
                    
                    Image(systemName: "gift")
                        .resizable()
                        .frame(width: 20,height: 20)
                        .padding(.bottom,1)
                    
                    Text("thêm khác")
                        .font(font.b_12)
                        .minimumScaleFactor(0.5)
                    
                    Spacer()

                }
                .frame(maxWidth: .infinity)
                .padding(5)
                .foregroundColor(viewModel.order.status.fgColor)
                .background(viewModel.order.status.bgColor)
                .cornerRadius(cornerRadius)
            })
            
            NavigationLink(destination:lazyNavigate(FoodView(order:viewModel.order,is_gift: DEACTIVE)),isActive:$isLinkActive) {
                VStack{
                    
                    Spacer()
    
                    Image("icon-turkey-chicken", bundle: .main)
                        .resizable()
                        .frame(width: 20,height: 20)
                        .padding(.bottom,1)

                    Text("Thêm món")
                        .font(font.b_12)
                        .minimumScaleFactor(0.5)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(5)
                .foregroundColor(viewModel.order.status.fgColor)
                .background(viewModel.order.status.bgColor)
                .cornerRadius(cornerRadius)
                    
            }
            
            NavigationLink(destination: Text("Tách món"), label: {
                VStack(alignment:.center){
                    Spacer()
                    
                    Image("icon-split", bundle: .main)
                        .resizable()
                        .frame(width: 20,height: 20)
                        .padding(.bottom,1)
                    
                    
              
                    Text("Tách món")
                        .font(font.b_12)
                        .minimumScaleFactor(0.5)
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity)
                .padding(5)
                .foregroundColor(viewModel.order.status.fgColor)
                .background(viewModel.order.status.bgColor)
                .cornerRadius(cornerRadius)
            })
            
            NavigationLink(destination:lazyNavigate(FoodView(order:viewModel.order,is_gift: ACTIVE)),isActive:$isLinkActive) {
                VStack{
                    Spacer()
                    
                    Image(systemName: "gift")
                        .resizable()
                        .frame(width: 20,height: 20)
                        .padding(.bottom,1)
                    
                    Text("Quà tặng")
                        .font(font.b_12)
                        .minimumScaleFactor(0.5)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(5)
                .foregroundColor(viewModel.order.status.fgColor)
                .background(viewModel.order.status.bgColor)
                .cornerRadius(cornerRadius)
                    
            }
                           
            NavigationLink(destination: Text("Thanh toán")){
                VStack{
                    Spacer()
                    
                    Image("icon-document-with-stick", bundle: .main)
                        .resizable()
                        .frame(width: 20,height: 20)
                        .padding(.bottom,1)
                    
                    Text("Thanh toán")
                        .font(font.b_12)
                        .minimumScaleFactor(0.5)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(5)
                .foregroundColor(viewModel.order.status.fgColor)
                .background(viewModel.order.status.bgColor)
                .cornerRadius(cornerRadius)
            }
            
        }
        .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
        .frame(maxWidth: .infinity)
        .frame(height: 80)
          
    }
    
    
}



