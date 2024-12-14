//
//  SimpleView.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 02/12/2024.
//

import SwiftUI

struct SimpleView: View {
    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color
    @State private var selectedIds: [Int] = []
    let optionArray: [(id: Int,name: String)]
    init(ids: [Int], optionArray: [(id: Int,name: String)]) {
        _selectedIds = State(initialValue: ids)
        self.optionArray = optionArray
    }

    var body: some View {
        VStack {
            TagList
        }
    }

    private var TagList: some View{
       
        let viewArray: [TagView<(some View)>] = selectedIds.map{id in
  
            guard let option = optionArray.first(where: {$0.id == id}) else{
                return (id:0,name:"",isSelected:false)
            }
            return (id:option.id,name:option.name,isSelected:true)
            
        }.map { data in
            TagView(content: {
                HStack{
                    Text(data.name).font(font.sb_12)
                      
                    Button(action: {
//                        handleSelection(data)
                    }) {
                        Image(systemName: "xmark")
                    }
                }
                .foregroundColor(.white)
                .padding(.all, 8)
                .background(color.green_matcha)
                .cornerRadius(7)
            })
        }
        
        return TagListView(viewArray, horizontalSpace: 8, verticalSpace: 8)
            .frame(alignment: .top)
            
    }
    
}

#Preview {
    SimpleView(
        ids:[1,2],
        optionArray:  [
            (id:1,name:"Huy Phạm"),
            (id:2,name:"Phạm Hữu Quyền"),
            (id:3,name:"Châu Huỳnh Hồng phúc"),
            (id:4,name:"Diệp Đương Phát"),
            (id:5,name:"Trương Công Định"),
        ]
    )
}
