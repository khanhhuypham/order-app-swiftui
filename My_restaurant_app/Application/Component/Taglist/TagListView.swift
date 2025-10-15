//
//  TagListView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 10/07/2025.
//

import SwiftUI

struct TagListView: View {
    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color
    @State var list:[CancelReason] = CancelReason.getDummyData()

    var body: some View {
        
        TagListLayout(list, spacing: 4){ text in
            Text(text.content)
               .font(font.m_12)
               .padding(.horizontal, 14)
               .padding(.vertical, 7)
               .background(color.orange_brand_900)
               .foregroundColor(.white)
               .cornerRadius(5)
               .onTapGesture(perform: {
                   dLog(text)
               })
        }
               
    }
    
}



struct TagListLayout<Data, RowContent>: View where Data: RandomAccessCollection, RowContent: View, Data.Element: Identifiable, Data.Element: Hashable {
    @State private var height: CGFloat = .zero

    private var data: Data
    private var spacing: CGFloat
    private var rowContent: (Data.Element) -> RowContent

    public init(_ data: Data, spacing: CGFloat = 4, @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent) {
        self.data = data
        self.spacing = spacing
        self.rowContent = rowContent
    }

    var body: some View {
        
        GeometryReader { geometry in
            content(in: geometry).background(viewHeight(for: $height))
        }
        .frame(height: height)
 
    }

    private func content(in geometry: GeometryProxy) -> some View {

        var bounds = CGSize.zero

        return ZStack {
            ForEach(data) { item in
                rowContent(item)
                .padding(.all, spacing)
                .alignmentGuide(VerticalAlignment.center){ dimension in
                    
                    let result = bounds.height
      
                    if let firstItem = data.first, item == firstItem {
                        
                        bounds.height = 0
                        
                    }
                    
                    return result
                }
                .alignmentGuide(HorizontalAlignment.center) { dimension in
                    
                    if abs(bounds.width - dimension.width) > geometry.size.width {
                        bounds.width = 0
                        bounds.height -= dimension.height
                    }

                    let result = bounds.width

                    if let firstItem = data.first, item == firstItem {
                        bounds.width = 0
                    } else {
                        bounds.width -= dimension.width
                    }
                    
                    return result
                }
            }
        }
    }

    private func viewHeight(for binding: Binding<CGFloat>) -> some View {
        GeometryReader { geometry -> Color in
            
            let rect = geometry.frame(in: .local)
          
            DispatchQueue.main.async {
                binding.wrappedValue = geometry.size.height
            }
            return .clear
        }
    }
}




#Preview {
    ZStack {
        Rectangle()
        TagListView()
    }
   
}

