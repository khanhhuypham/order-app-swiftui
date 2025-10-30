//
//  LocationsView.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 29/10/25.
//

import SwiftUI


struct ShimmerSwiftUIView: View {
    var body: some View {
        VStack {
            LocationsView()
                .redacted(reason: .placeholder)
                .modifier(Shimmer())
        }
        .background(.black.opacity(0.8))
    }
}

public struct Shimmer: ViewModifier {
    
    @State var isInitialState: Bool = true
    
    public func body(content: Content) -> some View {
        content
            .mask {
                LinearGradient(
                    gradient: .init(colors: [.black.opacity(0.4), .black, .black.opacity(0.4)]),
                    startPoint: (isInitialState ? .init(x: -0.3, y: -0.3) : .init(x: 1, y: 1)),
                    endPoint: (isInitialState ? .init(x: 0, y: 0) : .init(x: 1.3, y: 1.3))
                )
            }
            .animation(.linear(duration: 1.5).delay(0.25).repeatForever(autoreverses: false), value: isInitialState)
            .onAppear() {
                isInitialState = false
            }
    }
}

struct LocationsView: View {
    
    var body: some View {
        VStack {
            Image("image1")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .cornerRadius(20)
            HStack {
                Text("Beautiful Lake")
                    .font(.headline)
                Spacer()
                Image(systemName: "mappin")
                Text("Switzerland")
                    .font(.headline)
            }
            Image("image2")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .cornerRadius(20)
            HStack {
                Text("Mountains")
                    .font(.headline)
                Spacer()
                Image(systemName: "mappin")
                Text("Nepal")
                    .font(.headline)
            }
            Image("image3")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .cornerRadius(20)
            HStack {
                Text("Landscape")
                    .font(.headline)
                Spacer()
                Image(systemName: "mappin")
                Text("Tokyo")
                    .font(.headline)
            }
            Spacer()
        }
        .foregroundStyle(.white)
        .padding()
    }
}

#Preview {
    ShimmerSwiftUIView()
}
