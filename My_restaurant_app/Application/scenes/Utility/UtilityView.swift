//
//  UtilityView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 03/09/2024.
//



import SwiftUI
import UIKit

struct Utility: View {
    @EnvironmentObject var tabbarRouter:TabBarViewModel
   
    @Injected(\.colors) var color: ColorPalette
    @Injected(\.fonts) var fonts: Fonts

    @State var showSheet: Bool = false
    
//    @State var ArraySection:[(section:String,item:[(icon:String,title:String,navigate:any View)])] = [
//        (
//            section:"Thiết lập",
//            item:[
//                (icon:"icon-printer",title:"Thiết lập máy in",navigate:EmptyView()),
//                (icon:"icon-gear",title:"Thiết lập",navigate:EmptyView())
//            ]
//        ),
//        
//        (
//            section:"Quản lý",
//            item:[
//                (icon:"icon-area.fill",title:"Quản lý KHU VỰC/BÀN",navigate:EmptyView()),
//                (icon:"icon-turkey-chicken",title:"Quản lý THỰC ĐƠN",navigate:EmptyView()),
//                (icon:"icon-doc-text.fill",title:"Quản lý HOÁ ĐƠN",navigate:EmptyView())
//            ]
//        ),
//        
//    ]

    
    var body: some View {
        
        VStack{
            Divider()
            VStack(spacing:10){
                HStack(spacing:8){
                    
                    LogoImageView(imagePath: Constants.user.avatar ?? "")
                       

                    VStack(alignment:.leading){
                        
                        Text(Constants.user.username ?? "ss")
                            .font(fonts.r_16)
                            .foregroundColor(color.gray_600)
                            
                        
                        Text(Constants.user.name ?? "ss")
                            .font(fonts.m_16)
                            
                           
                        HStack(spacing: 8) {
                            // Gems
                            HStack(spacing: 4) {
                                Image("icon-diamond", bundle: .main)
                                    .frame(width:18, height:18)
                                    .foregroundColor(.orange)
                                    
                                Text("0")
                                    .font(fonts.r_13)
                                    .foregroundColor(.orange)
                            }
                            .padding(.horizontal,12)
                            .frame(minWidth: 75,alignment: .leading)
                            .frame(height:28)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.orange, lineWidth: 1)
                            )
                            
                            // Coins
                            HStack(spacing: 4) {
                                Image("icon-coins", bundle: .main)
                                    .frame(width:18, height:18)
                                    .foregroundColor(.orange)
                                
                                Text("0")
                                    .font(fonts.r_13)
                                    .foregroundColor(.orange)
                            }
                            .frame(minWidth: 75,alignment: .leading)
                            .frame(height:28)
                            .padding(.horizontal,12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.orange, lineWidth: 1)
                            )
                        }
                        
                    }
                    Spacer()
        
                   // Gems and Coins view
                  
                 
                    
                    NavigationLink(destination: SettingVIew()) {
                        
                        Image(systemName: "gearshape.fill")
                            .frame(width:18, height:18)
                            .padding(8)
                            .foregroundColor(.white)
                            .background(Circle().fill(color.orange_brand_900))

                    }.buttonStyle(.plain)
                    

                }
                .padding(.horizontal,10)
                
                Divider()
                
                HStack(spacing:8){
                    
                    LogoImageView(imagePath: Constants.branch.image_logo ?? "",mold:.square)
                       
                  
                    VStack(alignment:.leading){
                        
                        Text(Constants.branch.name ?? "")
                            .font(fonts.r_16)
                
                        Text(Constants.branch.address ?? "")
                            .font(fonts.footnote)
                    }
                    
                    Spacer()
                    
                    if PermissionUtils.GPBH_1{
                        
                        NavigationLink(destination: EmptyView()) {
    
                            Image(systemName: "chevron.right")
                                .padding(8)
                                .foregroundColor(.white)
                                .background(Circle().fill(color.orange_brand_900))
    
                        }
                        .frame(width:18, height:18)
                        .buttonStyle(.plain)
                        
                    }
                }
                .padding(.horizontal,10)
                .onTapGesture(perform: {
                    if PermissionUtils.GPBH_2 || PermissionUtils.GPBH_3{
                        showSheet.toggle()
                    }
                    
                })
                
                
            }

            Form{
                Group{
                    
                    Section(header: Text("Thiết lập"), content: {

                        NavigationLink{
                            lazyNavigate(PrinterSetting())
                        } label: {
                            HStack{
                                Image("icon-printer", bundle: .main)
                                Text("Thiết lập máy in")
                            }
                        }
                        
                        NavigationLink{
                            EmptyView()
                        } label: {
                            
                            HStack{
                                Image("icon-gear", bundle: .main)
                                Text("Thiết lập")
                            }
                        }
                
                    })
                    
                    Section(header: Text("Quản lý"), content: {
                        
                        NavigationLink{
                         
                            lazyNavigate(AreaManageView())
                        } label: {
                            
                            HStack{
                                Image("icon-area.fill", bundle: .main)
                                Text("Quản lý KHU VỰC/BÀN")
                            }
                        }
                        
                        NavigationLink{
                            lazyNavigate(MenuManagement())
                        } label: {
                            HStack{
                                Image("icon-turkey-chicken", bundle: .main)
                                Text("Quản lý THỰC ĐƠN")
                            }
                        }
                        
                        NavigationLink{
                            EmptyView()
                        } label: {
                          
                            HStack{
                                Image("icon-doc-text.fill", bundle: .main)
                                Text("Quản lý HOÁ ĐƠN")
                            }
                        }
            
                    })
                    
                    Section(header: Text("Báo cáo"), content: {
                        
                        NavigationLink{
                            EmptyView()
                        } label: {
                            
                            HStack{
                                Image("icon-line-chart.fill", bundle: .main)
                                Text("Phân tích DOANH THU")
                            }
                        }
                        
                        NavigationLink{
                            EmptyView()
                        } label: {
                            
                            HStack{
                       
                                Image("icon-pie-chart.fill", bundle: .main)
                                Text("Thống kê KINH DOANH")
                            }
                        }
                        
                        NavigationLink{
                            EmptyView()
                        } label: {
                            
                            HStack{
                                Image("icon-bar-chart.fill", bundle: .main)
                                Text("Báo cáo KINH DOANH")
                            }
                        }
                    })
                    
                    Section(header: Text("Cửa hàng"), content: {
                        
                        NavigationLink{
                            EmptyView()
                        } label: {
                            
                            HStack{
                                Image("icon-restaurant.fill", bundle: .main)
                                Text("Cửa hàng thiết bị TECHRES")
                            }
                        }
                    })
                    
                    Section(header: Text("Quản lý Food App"), content: {
                        
                        NavigationLink{
                            EmptyView()
                        } label: {
                            HStack{
                                Image("icon-link", bundle: .main)
                                Text("Kết nói với đối tác Food App")
                            }
                        }
                        
                        NavigationLink{
                            EmptyView()
                        } label: {
                            HStack{
                                Image("icon-link", bundle: .main)
                                
                                Text("Thiết lập chiết khấu Food App")
                            }
                        }
                        
                        
                        
                        NavigationLink{
                            EmptyView()
                        } label: {
                
                            HStack{
                                Image("icon-printer", bundle: .main)
                                Text("Thiết lập máy in của Food App")
                            }
                        }
                        
                        NavigationLink{
                            EmptyView()
                        } label: {
                
                            HStack{
                                Image("icon-doc-text.fill", bundle: .main)
                                Text("Lịch sử đơn hàng Food App")
                            }
                        }
                        
                        NavigationLink{
                            EmptyView()
                        } label: {
                
                            HStack{
                                Image("icon-bar-chart.fill", bundle: .main)
                                Text("Báo cáo đơn Food App")
                            }
                        }
            
                    })

                }
                .font(fonts.r_15)
                
            }
        
        }
        .navigationBarTitle("Tiện ích")
        .sheet(isPresented: $showSheet) {
            BranchOptionView()
                .presentationDetents([.medium, .large])
        }
    }
}



#Preview {
    Utility()
}
