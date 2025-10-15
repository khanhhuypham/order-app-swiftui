//
//  TableView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 11/10/2024.
//

import SwiftUI


struct TableView: View {
    @Binding var table:Table
    var action:OrderAction?
    @Injected(\.colors) var color: ColorPalette
    @Injected(\.fonts) var font: Fonts
    
    var body: some View {
            VStack(alignment: .leading) {
                
                GeometryReader { geo in
                    ZStack {
                        Image("icon-table")
                            .resizable()
                            .aspectRatio(contentMode: .fill)

                        Text(table.name ?? "")
                            .foregroundColor(.white)
                            .font(font.sb_16)
                        
                        if action == .mergeTable && table.is_selected{

                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.green)
                                .offset(
                                    x: geo.size.width / 2 - 5,
                                    y: -geo.size.height / 2 + 5
                                ) // ✅ top-right offset
                            
                            
                        }
                        
                    }.frame(width: geo.size.width, height: geo.size.height)
                    
                }.frame(width: 80, height: 80) // You can adjust this
            }
            .foregroundColor(table.status?.fgColor)
        }
}



#Preview {
    TableView(table: .constant(Table(name: "A1")))
}
