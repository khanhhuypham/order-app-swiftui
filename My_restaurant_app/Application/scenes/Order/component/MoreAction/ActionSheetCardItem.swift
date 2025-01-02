

import SwiftUI

public struct ActionSheetCardItem: View {

    let image: Image?

    let text: Text

    let callback: (() -> ())?
    
    public init(
        image: Image? = nil,
        text: Text,
        callback: (() -> ())? = nil
    ) {
        self.image = image
        self.text = text
        self.callback = callback
    }
    
    var icon: some View {
        Group {
            if let img = image {
                img
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 19, height: 19)
                .padding(.vertical, 19)
                .padding(.leading, 18)
                .padding(.trailing,13)
            }
        }
    }
    
    var buttonView: some View {
        HStack (spacing: 10 ){
            icon
            text
            Spacer()
        }
    }
    
    public var body: some View {
        Group {
            if let callback = callback {
                Button(action: {
                    callback()
                }) {
                    buttonView
//                        .foregroundColor(foregrounColor)
                }
            }
            else {
                buttonView
//                    .foregroundColor(foregroundInactiveColor)
            }
        }
    }
}

#Preview{
    VStack (spacing: 20) {
        Spacer()
        
        VStack (spacing: 0){
            
            ActionSheetCardItem(
                image:Image("icon-clock", bundle: .main),
                text:Text("Lịch sử đơn háng").font(.headline)
            ){
                //
            }
            
            ActionSheetCardItem(
                image:Image("icon-move", bundle: .main),
                text:Text("Chuyển bàn").font(.headline)) {
                //
            }
            
            Divider()
            
            ActionSheetCardItem(
                image:Image("icon-merge", bundle: .main),
                text:Text("Gộp bàn").font(.headline)) {
                //
            }
            
            Divider()
            
            ActionSheetCardItem(
                image:Image("icon-split", bundle: .main),
                text:Text("Tách món").font(.headline)){
                
            }
            
            Divider()
            
            ActionSheetCardItem(
                image:Image("icon-share", bundle: .main),
                text:Text("Chia điểm").font(.headline)){
                
            }
            
            Divider()
       
            ActionSheetCardItem(
                image:Image(systemName: "xmark"),
                text:Text("Huỷ món").font(.headline)){
                
            }
        }
        .background(Color.white)
        
        
        ActionSheetCardItem(text:Text("Huỷ món").font(.headline)){
            
        }
        
    }
    .background(Color.gray)
}

