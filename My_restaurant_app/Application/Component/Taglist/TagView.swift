//
//  TagListView.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 30/11/2024.
//

import SwiftUI

import SwiftUI

/// A SwiftUI view that presents a customizable tag list.
public struct TagListView<Content: View>: View {
    
    /// An array of Tag View
    private let tagViews: [TagView<Content>]
    /// Horizontal space between each tag
    private let horizontalSpace: CGFloat
    /// Vertical space between each tag
    private let verticalSpace: CGFloat
    
    @State private var listHeight: CGFloat = 0
    

    public init(_ views: [TagView<Content>],
                horizontalSpace: CGFloat,
                verticalSpace: CGFloat) {
        self.tagViews = views
        self.horizontalSpace = horizontalSpace
        self.verticalSpace = verticalSpace
    }
    
    public var body: some View {
        GeometryReader { geometry in
            generateTags(geometry, views: tagViews)
                .background(GeometryReader { geo in
                    Color(.clear)
                        .onAppear {
                            self.listHeight = geo.size.height
                        }
                })
        }
        .frame(height: listHeight)
    }
    	
    // ref: https://reona.dev/posts/20200929
    private func generateTags(_ geometry: GeometryProxy,
                              views: [TagView<Content>]) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
     
        return ZStack(alignment: .topLeading) {
            ForEach(views, id: \.self) { view in
                view
                    .padding(.trailing, horizontalSpace)
                    .alignmentGuide(.leading, computeValue: { dimension in
                        if abs(width - dimension.width) > geometry.size.width {
                            width = 0
                            height -= dimension.height + verticalSpace
                        }
                        let result = width
                        if view == views.last {
                            width = 0
                        } else {
                            width -= dimension.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { dimension in
                        let result = height
                        if view == views.last {
                            height = 0
                        }
                        return result
                    })
            }
        }
    }
}

// MARK: - Sample
// MARK: - Sample
#Preview {
    
    @Injected(\.fonts) var font
    @Injected(\.colors) var color
    
    let data: [(id:Int,label:String)] = [
        (id:1,label:"Huy Phạm"),
        (id:2,label:"Phạm Hữu Quyền"),
        (id:3,label:"Châu Huỳnh Hồng phúc"),
        (id:4,label:"Diệp Đương Phát"),
        (id:5,label:"Trương Công Định"),
    ]
    
    let viewArray: [TagView<(some View)>] = data.map { data in
        return TagView(content: {
            HStack{
                Text(data.label)
                    .font(font.sb_12)
                    .onTapGesture {
                        print(data.id)
                    }
                
                Button(action: {
                    print("delete")
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
        .previewLayout(.sizeThatFits)
    
}

public struct TagView<Content: View>: View, Hashable {
    
    private let id = UUID()
    @State private var content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        _content = State(initialValue: content())
    }
    
    public var body: some View {
        content
    }
    
    public static func == (lhs: TagView, rhs: TagView) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


#Preview{
    TagView(content: {
        HStack{
            Text("sss")
                .font(.title2)
                .onTapGesture {
                    print("[Pressed]")
                }
            
            Button(action: {
                
            }) {
                Image(systemName: "xmark")
            }
        }
    })
}
