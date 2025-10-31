//
//  PaymentView.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 30/8/25.
//

import Foundation
import SwiftUI

struct PaymentView:View{
    @Injected(\.colors) var color: ColorPalette
    @Injected(\.fonts) var font: Fonts
    @State private var isLinkActive = false
    @StateObject var viewModel: PaymentViewModel

    @State private var linkTag:String? = nil

    
    
    init(order:OrderDetail? = nil) {
        _viewModel = StateObject(wrappedValue: PaymentViewModel(order: order))
    }
    
    
    
    var body: some View {
        
        VStack{
            
            NavigationLink(destination: OrderLogView(orderId: viewModel.order.id), tag: "OrderLog", selection: $linkTag) { EmptyView() }
            
            
            ScrollView{
                VStack(alignment:.leading,spacing:0){
                    
                    Divider()
                    
                    View_of_top
//
//                    // Overlay dialog
//                    if showDialog {
//                        // Dimmed background (like overCurrentContext)
//                        Color.black.opacity(0.4)
//                            .ignoresSafeArea()
//                            .transition(.opacity) // fade in/out
//
//                        VStack(spacing: 20) {
//                            Text("Overlay Dialog")
//                                .font(.headline)
//                            Button("Dismiss") {
//                                withAnimation(.easeInOut(duration: 0.3)) {
//                                    showDialog = false
//                                }
//                            }
//                        }
//                        .padding()
//                        .frame(maxWidth: 300)
//                        .background(Color.white)
//                        .cornerRadius(16)
//                        .shadow(radius: 10)
//                        // crossDissolve effect
//                        .transition(.opacity)
//                    }
//                

                    
                    Divider()
                    
                    ForEach($viewModel.order.orderItems,id: \.id){item in
                        PaymentViewCell(item:item)
                        Divider()
                    }
                  
                    Divider()
                    
                    View_of_estimate_amount
                    
                    Divider()
           
                }
            }
            
            BottomActionBar
        }
        .fullScreenCover(isPresented:$viewModel.showPopup.show,content: {
            EnterPercentView(isPresent:$viewModel.showPopup.show,percent: nil,title: "PHỤ THU"){percent in
                dLog(percent)
            }.transition(.opacity)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
           ToolbarItem(placement: .principal) {
               Text(String(format: "#%d-%@", viewModel.order.id_in_branch,viewModel.order.table_name))
                   .fontWeight(.semibold)
                   .foregroundColor(viewModel.order.status.fgColor)
           }
        }
        .navigationTitle("")
        .refreshable {
            Task{
                await viewModel.getOrder()
            }
        }
        .onAppear(perform: {
            Task{
                await viewModel.getOrder()
            }
            viewModel.setupSocketIO()
        })
        .onDisappear{
            viewModel.socketIOLeaveRoom()
        }
            
    }
    
    private var BottomActionBar: some View {
        
        var btnTitle = ""
        
        if PermissionUtils.GPBH_1 {
            btnTitle = "Tính tiền"
            if PermissionUtils.GPBH_1_o_3{
                
//                billPrinter.is_have_printer == ACTIVE
//                ? btnTitle(type: 2)
//                : btnTitle(type: 1)
            }
        }else if PermissionUtils.GPBH_2 {
            
            btnTitle = PermissionUtils.OwnerOrCashier ? "IN HOÁ ĐƠN VÀ TÍNH TIỀN" : "YÊU CẦU THANH TOÁN"

        }else if PermissionUtils.GPBH_3{
            btnTitle = "YÊU CẦU THANH TOÁN"
        }
        
        return VStack{
            
            if(viewModel.order.status == .complete || viewModel.order.status == .debt_complete){
                
                HStack(spacing: 12) {
                    // Left button
                    Button(action: {
                        linkTag = "OrderLog"
                    }) {
                        HStack {
                            Image(systemName: "clock")
                            Text("LỊCH SỬ").font(font.sb_16)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(color.blue_brand_700)
                        .cornerRadius(8)
                    }
                    
                    // Right button
                    Button(action: {
                        print("In hoá đơn tapped")
                    }) {
                        HStack {
                            Image(systemName: "printer")
                            Text("IN HOÁ ĐƠN").font(font.sb_16)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(color.blue_brand_700)
                        .cornerRadius(8)
                    }
                }
            }
            
            if viewModel.order.order_method == .EAT_IN && viewModel.order.status == .open{
                
                Button(action: {
                    print("Lịch sử tapped")
                    
                }) {
                    HStack {
                        Image(systemName: "printer")
                        Text(btnTitle.uppercased()).font(font.sb_16)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(color.blue_brand_700)
                    .cornerRadius(8)
                }
            }
            
            
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
        .padding(.bottom, 16) // spacing from bottom edge
        .background(Color.white.ignoresSafeArea(edges: .bottom))

    }


    
    private var View_of_top: some View {
        VStack(alignment: .leading,spacing: 0) {
            
            HStack(spacing: 10) {
              
                Image("icon-coins", bundle: .main)
                    .resizable()
                    .frame(width: 30,height: 30)
                    .foregroundColor(color.gray_600)
                
                VStack(alignment:.leading){
                    Text("tổng thanh toán".uppercased())
                        .font(font.sb_16)
                        .foregroundColor(color.gray_600)
                    
                    Text(viewModel.order.total_final_amount.toString)
                        .foregroundColor(viewModel.order.status.fgColor)
                        .font(font.b_18)
                }
                
            }.padding(.vertical,5)
            
            Divider()
            
            HStack(spacing: 10){
                Image("icon-doc-text", bundle: .main)
                    .resizable()
                    .frame(width: 18,height: 18)
                    .foregroundColor(color.gray_600)
                
                Text(String(format: "Mã HĐ: #%d", viewModel.order.id_in_branch))
                    .foregroundColor(.black)
                    .font(font.r_14)
                    
            }.frame(height: 35)
            
            Divider()
            
            HStack(spacing: 10){
                Image(systemName: "person.badge.clock.fill")
                    .resizable()
                    .frame(width: 18,height: 18)
                    .foregroundColor(color.gray_600)
        
                Text(String(format: "Số khách hàng: %d", viewModel.order.customer_slot_number))
                    .foregroundColor(.black)
                    .font(font.r_14)
                
            }.frame(height: 35)
            
            Divider()
            
            HStack(spacing: 10){
                Image(systemName: "calendar")
                    .resizable()
                    .frame(width: 18,height: 18)
                    .foregroundColor(color.gray_600)

                Text(String(
                        format: "Ngày thành toán: %@",
                        viewModel.order.status == .complete || viewModel.order.status == .debt_complete
                        ? viewModel.order.payment_date
                        : viewModel.order.created_at
                ))
                    .font(font.r_14)
                    .foregroundColor(.black)
            }.frame(height: 35)
            
            Divider()
            
            HStack(spacing: 10){
                Image("icon-person", bundle: .main)
                    .resizable()
                    .frame(width: 18,height: 18)
                    .foregroundColor(color.gray_600)
                
                Text(String(format: "Nhân viên: %@", viewModel.order.employee_name))
                    .font(font.r_14)
                    .foregroundColor(.black)
            }.frame(height: 35)
            
            if !viewModel.order.customer_phone.isEmpty{
                
                Divider()
                
                HStack(spacing: 10){
                    Image(systemName: "phone.fill")
                        .resizable()
                        .frame(width: 18,height: 18)
                        .foregroundColor(color.gray_600)
                    
                    Text(String(format: "SĐT Khách hàng: %@", viewModel.order.customer_phone))
                        .font(font.r_14)
                        .foregroundColor(.black)
                }.frame(height: 35)
            }
            
            
            if !viewModel.order.customer_name.isEmpty{
                Divider()
                
                HStack(spacing: 10){
                    Image("icon-person", bundle: .main)
                        .resizable()
                        .frame(width: 18,height: 18)
                        .foregroundColor(color.gray_600)
                    
                    Text(String(format: "Tên khách hàng: %@", viewModel.order.customer_name))
                        .font(font.r_14)
                        .foregroundColor(.black)
                }.frame(height: 35)
                
            }
            
            if !viewModel.order.shipping_address.isEmpty || !viewModel.order.customer_address.isEmpty{
                
                Divider()
                
                HStack(spacing: 10){
                    Image("icon-location", bundle: .main)
                        .resizable()
                        .frame(width: 18,height: 18)
                        .foregroundColor(color.gray_600)
                    
                    Text(String(format: "Địa chỉ: %@", viewModel.order.order_method == .TAKE_AWAY ? viewModel.order.shipping_address : viewModel.order.customer_address))
                        .font(font.r_14)
                        .foregroundColor(.black)
                }.frame(height: 35)
            }


        }
   
        
    }
        
    
    
    private var View_of_estimate_amount: some View {
        let totalDiscountAmount = viewModel.order.total_amount_discount_amount + viewModel.order.food_discount_amount + viewModel.order.drink_discount_amount
        
        return VStack(alignment: .leading,spacing: 0) {
            HStack {
                
                Spacer()
                
                Text("Tổng ước tính")
                        .font(font.b_14)
                        .foregroundColor(.black)
                
                Spacer()
                
                Text(viewModel.order.amount.toString)
                        .font(font.b_14)
                        .foregroundColor(viewModel.order.status.fgColor)
                        .padding(.trailing,10)
            
            }
            .frame(height: 45)
            .frame(maxWidth: .infinity)
            
            Divider()
    
            VStack(alignment: .leading, spacing: 0){
                Divider()
                
                HStack {
                    HStack{
                        Button(action:{
                            
                        }){
                            
                            switch viewModel.order.status {
                                case .complete, .debt_complete:
                                    
                                     
                                    Image(viewModel.order.service_charge_amount > 0 ? "icon-gray-check-square" : "icon-gray-uncheck-square", bundle: .main)
                                          .resizable()
                                          .frame(width: 18, height: 18)
                                default:
                                    
                                    Image(viewModel.order.service_charge_amount > 0 ? "icon-yellow-check-square" : "icon-yellow-uncheck-square", bundle: .main)
                                          .resizable()
                                          .frame(width: 18, height: 18)
                                    
                            }
                        
                        }
                        
                        Image("icon-discount.fill", bundle: .main)
                            .resizable()
                            .frame(width: 18,height: 18)
                         
                        
                        Text("Phí phục vụ")
                        
                    }
                    
                    Spacer()
                    
                    Text(viewModel.order.service_charge_amount.toString)
                    
                }
                .foregroundColor(viewModel.order.status.fgColor)
                .frame(height: 40)
              
                Divider()
                
                HStack {
                    HStack{
                        Button(action:{
                
                            if ![.complete, .debt_complete, .cancel].contains(viewModel.order.status) {
                                viewModel.showPopup.show.toggle()
                            }
                            
                        }){
                            
                            
                            switch viewModel.order.status {
                                case .complete, .debt_complete:
                                    
                                    Image(viewModel.order.extra_charge_amount > 0 ? "icon-gray-check-square" : "icon-gray-uncheck-square", bundle: .main)
                                          .resizable()
                                          .frame(width: 18, height: 18)
                                default:
                                    
                                    Image(viewModel.order.extra_charge_amount > 0 ? "icon-yellow-check-square" : "icon-yellow-uncheck-square", bundle: .main)
                                          .resizable()
                                          .frame(width: 18, height: 18)
                                
                            }
                            
                            
                        }
                        
                        
                        Image("icon-discount.fill", bundle: .main)
                            .resizable()
                            .frame(width: 18,height: 18)
          
                        Text("Phụ thu")
                    
                        
                    }
                    
                    Spacer()
                    
                    Text(viewModel.order.extra_charge_amount.toString)
                    
                }
                .foregroundColor(viewModel.order.status.fgColor)
                .frame(height: 40)
                
                Divider()
           
                VStack(spacing:8){
                    
                    HStack{
                        
                        Button(action:{
                            
                        }){
                          
                            
                            switch viewModel.order.status {
                                case .complete, .debt_complete:
                                    
                                    Image(totalDiscountAmount > 0 ? "icon-gray-check-square" : "icon-gray-uncheck-square", bundle: .main)
                                          .resizable()
                                          .frame(width: 18, height: 18)
                                default:
                                    
                                    Image("icon-yellow-uncheck-square", bundle: .main)
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                
                            }
                        }
                        
                        Image("icon-discount.fill", bundle: .main)
                            .resizable()
                            .frame(width: 18,height: 18)
                            .foregroundColor(viewModel.order.status.fgColor)
                        
                        HStack{
                            Text("Giảm giá").foregroundColor(viewModel.order.status.fgColor)
                            if viewModel.order.total_amount_discount_amount > 0{
                                Text("(tổng bill)").foregroundColor(color.gray_600)
                            }else if viewModel.order.food_discount_amount > 0 || viewModel.order.drink_discount_amount > 0{
                                Text("(theo loại món)").foregroundColor(color.gray_600)
                                
                            }
                        }
                        
                        Spacer()
                        
                        Text(
                            String(
                                format: "%@ (%@%%)",
                                totalDiscountAmount.toString,
                                viewModel.order.total_amount_discount_percent.toString
                        )).foregroundColor(viewModel.order.status.fgColor)
                        
                    }
                    
                    if viewModel.order.food_discount_amount > 0 || viewModel.order.drink_discount_amount > 0{
                        VStack(spacing:8){
                            HStack{
                                Text("+ Món ăn")
                                Spacer()
                                Text(String(format:"%@ (%d%%)", viewModel.order.food_discount_amount.toString, viewModel.order.food_discount_percent))
                            }
                            
                            HStack{
                                Text("+ Nước uống")
                                Spacer()
                                Text(String(format:"%@ (%d%%)", viewModel.order.drink_discount_amount.toString, viewModel.order.drink_discount_percent))
                            }
                        }
                        .padding(.leading,25)
                        .font(font.m_14)
                        .foregroundColor(.black)
                    }
                }.padding(.vertical,12)
                
                
                Divider()
                
                HStack {
                    HStack{
                        Button(action:{
                            
                        }){
                            
                            switch viewModel.order.status {
                                case .complete, .debt_complete:
                                    
                                    Image(viewModel.order.vat_amount  > 0 ? "icon-gray-check-square" : "icon-gray-uncheck-square", bundle: .main)
                                          .resizable()
                                          .frame(width: 18, height: 18)
                                
                                default:
                                    
                                    Image(viewModel.order.vat_amount > 0 ? "icon-yellow-check-square" : "icon-yellow-uncheck-square", bundle: .main)
                                          .resizable()
                                          .frame(width: 18, height: 18)
                                
                            }
                            
                            
                            
                        }
                        
                        Image("icon-line-chart.fill", bundle: .main)
                            .resizable()
                            .frame(width: 23,height: 23)
                         
                        Text("Thuế GTGT")
                    }
                    
                    Spacer()
                    
                    Text(viewModel.order.vat_amount.toString)
                    
                }
                .foregroundColor(viewModel.order.status.fgColor)
                .frame(height: 40)
              
                
            }
            .font(font.m_14)
            .foregroundColor(color.blue_brand_700)
            
          
            
            
        }
        
    }
    

    

    
}



