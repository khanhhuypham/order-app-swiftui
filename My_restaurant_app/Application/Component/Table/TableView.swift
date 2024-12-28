//
//  TableView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 11/10/2024.
//

import SwiftUI


struct TableView: View {
    @Binding var table:Table
    @Injected(\.colors) var color: ColorPalette
    @Injected(\.fonts) var font: Fonts
    var body: some View {
        VStack(alignment: .leading){
            ZStack{
                Image("icon-table")
                Text(table.name ?? "")
                    .foregroundColor((table.order != nil) ? .white : .black)
                    .font(font.sb_14)
            }
        }
        .foregroundColor(table.order?.status?.fgColorForTable ?? color.gray_400)
    }
}

#Preview {
    TableView(table: .constant(Table(name: "A1")))
}
