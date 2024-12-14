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
              
            }.background(BackgroundClearView())
        }
        
    }
    
    // function for background clear
    struct BackgroundClearView: UIViewRepresentable {
        func makeUIView(context: Context) -> UIView {
            let view = UIView()
            DispatchQueue.main.async {
                view.superview?.superview?.backgroundColor = .clear
                view.superview?.superview?.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            }
            return view
        }
        func updateUIView(_ uiView: UIView, context: Context) {}
    }

    
}



struct DialogPreivew: View {
    
    @State private var isPresented = false

       var body: some View {

           Button {
               isPresented = true
             
           } label: {
               Text("Present Pop-up Dialog")
           }
           
           .fullScreenCover(isPresented: $isPresented, content: {
               dialog(isPresented: $isPresented){
                   EnterTextView(isPresent: $isPresented)
               }
           })
        
       }

}

#Preview(body: {
    DialogPreivew()
})
