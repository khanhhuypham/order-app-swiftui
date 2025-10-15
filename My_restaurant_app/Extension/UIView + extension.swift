//
//  UIView + extension.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 03/09/2024.
//

import Foundation
import SwiftUI



extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorners(radius: radius, corners: corners) )
    }
    
  
    
    func isHidden(_ hidden: Bool) -> some View {
          hidden ? AnyView(EmptyView()) : AnyView(self)
    }
    
    func shadowedStyle() -> some View {
        self
            .shadow(color: .black.opacity(0.08), radius: 2, x: 0, y: 0)
            .shadow(color: .black.opacity(0.16), radius: 24, x: 0, y: 0)
    }
    
    
    // Adjust text color based on whether the specified condition is met
    func numberValidator<T: Numeric>(value: T, errorCondition: (T) -> Bool) -> some View {
       foregroundColor(errorCondition(value) ? .red : .primary)
    }
    
    
    func defaultListRowStyle() -> some View {

        self.listRowInsets(EdgeInsets(.zero)) // Remove insets
//        .listRowBackground(
//            Color(UIColor.systemGray6)
//                .overlay(alignment: .bottom) {
//                    Divider()
//                }
//        )
        .alignmentGuide(.listRowSeparatorLeading) { _ in
            return 0
        }
    }
    
    func fullBox(alignment: Alignment = .center) -> some View {
        self.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: alignment)
    }
    
    func commonTextFieldDecor(height:CGFloat) -> some View {
        self.frame(height: height)
            .foregroundColor(.black)
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 6))
            .overlay(
              // Placeholder and border overlay
              RoundedRectangle(cornerRadius: 5)
                .stroke(Color(uiColor: .black).opacity(0.6), lineWidth: 0.3) // Border
            )
    }
    
}

struct lazyNavigate<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}


struct RoundedCorners: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

public struct LazyNavigate<Destination: View,Label: View>: View {
    var destination: () -> Destination
    var label: () -> Label

    public init(@ViewBuilder destination: @escaping () -> Destination,@ViewBuilder label: @escaping () -> Label) {
        self.destination = destination
        self.label = label
    }

    public var body: some View {
        NavigationLink {
            LazyView {
                destination()
            }
        } label: {
            label()
        }
    }

    private struct LazyView<Content: View>: View {
        var content: () -> Content
     
        var body: some View {
            content()
        }
    }
}






fileprivate var currentOverCurrentContextUIHost: UIHostingController<AnyView>?

struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .black.withAlphaComponent(0.7)
        }
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {}
}

extension View {
    public func presentDialog<Content: View>(
        isPresented: Binding<Bool>,
        showWithAnimation: Bool = true,
        dismissWithAnimation: Bool = true,
        afterDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        onChange(of: isPresented.wrappedValue) { newValue in
            newValue
            ? present(content,showWithAnimation:showWithAnimation)
            : dismiss(dismissWithAnimation, afterDismiss: afterDismiss)
        }
    }

    private func present<Content: View>(
        _ content: @escaping () -> Content,
        showWithAnimation: Bool
    ) {
        let uiHost = UIHostingController(
            rootView: AnyView(content().background(BackgroundClearView()))
        )
        uiHost.modalPresentationStyle = .overCurrentContext
        uiHost.modalTransitionStyle = .crossDissolve
        uiHost.view.backgroundColor = .clear

        currentOverCurrentContextUIHost = uiHost
        UIApplication.shared.windows.first?.rootViewController?.present(uiHost, animated: showWithAnimation, completion: nil)
    }

    private func dismiss(_ animated: Bool, afterDismiss: (() -> Void)?) {
        guard let existingHost = currentOverCurrentContextUIHost else { return }
        existingHost.dismiss(animated: animated) {
            currentOverCurrentContextUIHost = nil
            afterDismiss?()
        }
    }
}
