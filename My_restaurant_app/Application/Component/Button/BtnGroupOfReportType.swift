//
//  HorizontalBtnGroup 2.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 8/10/25.
//

import SwiftUI

struct BtnGroupOfReportType: View {
    @Injected(\.fonts) var font: Fonts
    @Injected(\.colors) var color: ColorPalette
    var useTextField:Bool = false
    @State var keySearch = ""
    
    @State var btnArray: [(id: Int, title: String, isSelect: Bool)] = [
        (id: REPORT_TYPE_TODAY, title: "Hôm nay", isSelect: false),
        (id: REPORT_TYPE_YESTERDAY, title: "Hôm qua", isSelect: false),
        (id: REPORT_TYPE_THIS_WEEK, title: "Tuần này", isSelect: false),
        (id: REPORT_TYPE_THIS_MONTH, title: "Tháng này", isSelect: false),
        (id: REPORT_TYPE_LAST_MONTH, title: "Tháng trước", isSelect: false),
        (id: REPORT_TYPE_THREE_MONTHS, title: "3 tháng gần nhất", isSelect: false),
        (id: REPORT_TYPE_THIS_YEAR, title: "Năm nay", isSelect: false),
        (id: REPORT_TYPE_LAST_YEAR, title: "Năm trước", isSelect: false),
        (id: REPORT_TYPE_THREE_YEAR, title: "3 năm gần nhất", isSelect: false),
        (id: REPORT_TYPE_ALL_YEAR, title: "Tất cả các năm", isSelect: false)
    ]

    var textFieldClosure:((String) -> Void)? = nil
    var clickClosure:((Int) -> Void)? = nil

    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                if useTextField {
                    HStack {
                        Image(systemName: "magnifyingglass").padding(.leading,10)
                        
                        TextField("Tìm kiếm", text: $keySearch)
                            .onChange(of: keySearch) { newValue in
                                textFieldClosure?(newValue)
                            }
                            .font(font.r_14)
                            .padding(.trailing,20)
                        
                            
                    }
                    .foregroundColor(color.orange_brand_900)
                    .frame(width:180,height: 32)
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(color.orange_brand_900, lineWidth: 2))
                    .cornerRadius(25)
                }
                
                ForEach(Array(btnArray.enumerated()), id: \.offset){i,element in
                    Button(action: {
                        // Action for Món ăn
                        for (j,_) in btnArray.enumerated(){
                            btnArray[j].isSelect = i == j ? true : false
                        }
                        if let clickClosure = self.clickClosure{
                            clickClosure(element.id)
                        }
                        
                    }) {
                        Text(element.title)
                            .font(font.sb_13)
                            .foregroundColor(element.isSelect ? .white : color.orange_brand_900)
                            .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
//
                    }
                    .overlay(RoundedRectangle(cornerRadius: 20, style: .circular).stroke(color.orange_brand_900, lineWidth: 2))
                    .background(element.isSelect ? color.orange_brand_900 : .white)
                    .cornerRadius(25)
                }
            }
        }
        .padding(.vertical,5)
    }
}

#Preview {
    BtnGroupOfReportType{id in
        print(id.description)
    }
}
