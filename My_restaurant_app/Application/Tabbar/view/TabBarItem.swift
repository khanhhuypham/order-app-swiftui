//
//  TabBarItem.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 03/09/2024.
//



import SwiftUI

struct TabItem: View {
    @ObservedObject var tabbarRouter: TabBarViewModel
    @Injected(\.fonts) private var fonts
    @Injected(\.colors) var color: ColorPalette
    let width,height:CGFloat
    let image:Image
    let tabName:String
    
    let assignedPage:Page
    
    var body: some View {
        VStack(alignment:.center,spacing:5){
            Spacer()
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width,height:height)

            Text(tabName).font(fonts.m_12)
            
            Spacer()
        }
        .padding(.horizontal,-4)
        .foregroundColor(tabbarRouter.currentPage == assignedPage ? .white : color.gray_400)
        .onTapGesture{
            tabbarRouter.currentPage = assignedPage
        }
    }
}

