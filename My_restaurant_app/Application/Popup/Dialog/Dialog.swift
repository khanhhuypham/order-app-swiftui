//
//  Dialog.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 28/09/2024.
//

import SwiftUI

struct dialog<Content: View>: View {
    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color

    @Binding var isPresented: Bool
    @State private var showing = false
    var dismissOnTapOutside: Bool = true
    let viewBuilder: () -> Content

    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                // a transparent rectangle under everything
                Rectangle()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.001)   // <--- important
                    .layoutPriority(-1)
                    .onTapGesture {
                        if dismissOnTapOutside {
                            isPresented = false
                        }
                    }
                VStack{
                    Spacer()
                    viewBuilder()
                    Spacer()
                }
              
            }

        }
        
    }


    
}



struct DialogTest: View {
    
    @State private var isPresented = false

       var body: some View {

           Button {
               isPresented = true
             
           } label: {
               Text("Present Pop-up Dialog")
           }
//           .presentView(isPresented: $isPresented, content: {
//               dialog(isPresented: $isPresented){
//                   EnterTextView(isPresent: $isPresented)
//               }
//           })

        
       }

}

#Preview(body: {
    DialogTest()
})
