//
//  SwipeActionView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 17/09/2024.
//

import SwiftUI

enum SwipeAction {
    
    case note(action:(() -> Void)?)
    case discount(action:(() -> Void)?)
    case edit(action:(() -> Void)?)
    case split(action:(() -> Void)?)
    case cancel(action:(() -> Void)?)
    
    @ViewBuilder var swipeAction:some View{
        switch self {
            
            case .note(let action):
            
                Button {
//                    print("Action note")
                    (action ?? {})()
                }label: {
                    label.foregroundColor(.white)
                }
                .tint(Color(ColorUtils.gray_600()))
            
            case .discount(let action):
                Button {
                    (action ?? {})()
                }label: {
                    label.foregroundColor(.white)
                }
                .tint((Color(ColorUtils.orange_brand_900())))
                
            case .edit(let action):
                Button {
                    (action ?? {})()
                }label: {
                    label.foregroundColor(.white)
                }
                .tint(Color(ColorUtils.blue_brand_700()))
                
            case .split(let action):
                Button {
                    (action ?? {})()
                }label: {
                    label.foregroundColor(.white)
                }
                .tint((Color(ColorUtils.green_600())))
                
            case .cancel(let action):
                Button {

                    (action ?? {})()
                } label: {
                  label.foregroundColor(.white)
                }
                .tint((Color(ColorUtils.red_600())))
            
        }
    }
    
    private var label: Image {
        let imgSize = CGSize(width: 60, height: 40)
        let imgPoint = CGPoint(x: 30, y: 5)
        let textPoint = CGPoint(x: 30, y: 28)
        let textFont:Font = .system(size: 11,weight: .medium)
        
        switch self {
            case .note:
                return Image(size: imgSize) { ctx in
                    ctx.draw(
                        Image("icon-doc-text", bundle: .main),
                        at: imgPoint,
                        anchor: .top
                    )
                    ctx.draw(
                        Text("Ghi chú").font(textFont),
                        at: textPoint,
                        anchor: .top
                    )
                }
            case .discount:
                return Image(size: imgSize) { ctx in
                    ctx.draw(
                        Image("icon-discount", bundle: .main),
                        at: imgPoint,
                        anchor: .top
                    )
                    ctx.draw(
                        Text("Giảm giá").font(textFont),
                        at: textPoint,
                        anchor: .top
                    )
                }
            case .edit:
                return  Image(size:imgSize){ ctx in
                    ctx.draw(
                        Image("icon-doc-text", bundle: .main),
                        at: imgPoint,
                        anchor: .top
                    )
                    ctx.draw(
                        Text("Chỉnh sửa").font(textFont),
                        at: textPoint,
                        anchor: .top
                    )
                }
            case .split:
                return Image(size:imgSize) { ctx in
                    ctx.draw(
                        Image("icon-split", bundle: .main),
                        at: imgPoint,
                        anchor: .top
                    )
                    ctx.draw(
                        Text("Tách món").font(textFont),
                        at: textPoint,
                        anchor: .top
                    )
                }
            
            case .cancel:
                return Image(size:imgSize) { ctx in
                    
                    ctx.draw(
                        Image(systemName: "trash"),
                        at: imgPoint,
                        anchor: .top
                    )
                    ctx.draw(
                        Text("Huỷ món").font(textFont),
                        at: textPoint,
                        anchor: .top
                    )
                }
            }

    }
    
    
    

    
   
}


struct SwipeActionView: View {
    
    @State var actions:[SwipeAction]
    
    var body: some View {

        ForEach(Array(actions.enumerated()), id: \.offset) { i, action in

            action.swipeAction
            
        }
    }
    
    

    
}


