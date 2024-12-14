//
//  TabBar.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 03/09/2024.
//

//
//  FxTabBar.swift
//  aloline-phamkhanhhuy
//
//  Created by Pham Khanh Huy on 20/01/2024.
//

import SwiftUI
import AlertToast
import Combine
struct TabBar: View {
    @StateObject var viewModel = TabBarViewModel()
    @State private var isSheetPresented = false
    @State var toast = InjectedValues[\.utils.toastUtils]
   
    @ViewBuilder
    var contentView:some View{
        
        switch viewModel.currentPage {
            case .order:
                OrderListView(viewModel: OrderListViewModel()).environmentObject(viewModel)
               
                
            case .area:
                AreaView().environmentObject(viewModel)
                
                
            case .Utility:
                Utility().environmentObject(viewModel)
             
        }
    }
    
    
    var body: some View {
        GeometryReader{geometry in
            NavigationView {
                VStack{
                    Spacer()
                        contentView
                       
                    Spacer()
                    
                    HStack{
                        //tabbar item
                        //test 1 item
                        TabItem(
                            tabbarRouter: viewModel,
                            width: geometry.size.width/3,
                            height: geometry.size.height/25,
                            image: Image("icon-doc-text", bundle: .main),
                            tabName: "Đơn hàng",
                            assignedPage: .order
                        )
                        
                        TabItem(
                            tabbarRouter: viewModel,
                            width: geometry.size.width/3,
                            height: geometry.size.height/25,
                            image:Image("icon-area", bundle: .main),
                            tabName: "Khu vực",
                            assignedPage: .area
                        )
                        
                     
                        TabItem(
                            tabbarRouter: viewModel,
                            width: geometry.size.width/3,
                            height: geometry.size.height/25,
                            image:Image("icon-utilities", bundle: .main),
                            tabName: "Tiện ích",
                            assignedPage: .Utility
                        )
                        
                    }
                    .frame(width: geometry.size.width,height: 70)
                    .background(Color(ColorUtils.orange_brand_900()).shadow(radius:2))
                }
                .edgesIgnoringSafeArea(.bottom)
            
            }
            .onAppear(perform: {
                toast.subject.sink { value in
                    self.isSheetPresented = value
                }
                .store(in: &toast.cancellables)
            })
            .toast(isPresenting: $isSheetPresented){
                toast.loadingToast
            }
            .environmentObject(viewModel)
        }
    }

    
    private func TabBarItem(icon:String,tabName:String,size:CGSize) -> some View{
        VStack{
            Image(icon, bundle: .main)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size.width,height: size.height)
                .padding(10)
    
            Text(tabName)
                .font(.footnote)
            Spacer()
        }
     
        .padding(.horizontal,-4)
    }
    
    
    
    
}

#Preview {
    TabBar()
}

