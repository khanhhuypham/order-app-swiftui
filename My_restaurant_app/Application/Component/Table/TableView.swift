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
                    .foregroundColor(.white)
                    .font(font.sb_16)
            }
          
        }
        .foregroundColor(table.status?.fgColor)
    }
}

#Preview {
    TableView(table: .constant(Table(name: "A1")))
}
