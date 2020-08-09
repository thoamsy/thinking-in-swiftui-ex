//
//  Geometry.swift
//  ThinkingInSwiftUI
//
//  Created by yk on 2020/8/9.
//

import SwiftUI

struct WidthKey: PreferenceKey {
  static let defaultValue: CGFloat? = nil
  static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
    value = value ?? nextValue()
  }
}

struct Geometry: View {
  @State private var width: CGFloat?  = nil

  var body: some View {
//    GeometryReader {
//      Rectangle()
//        .fill(Color.red)
//        .frame(width: $0.size.width / 3)
//
//    }
    VStack {
      Text("HELLO")
        .background(GeometryReader {
          proxy in
          EmptyView().preference(key: WidthKey.self, value: proxy.size.width)
        }).onPreferenceChange(WidthKey.self) {
          self.width = $0
        }.frame(width: width, height: width)
        .background(Circle().fill(Color.blue))

      Text("Start")
        .foregroundColor(.white)
        .padding(10)
        .background(
          GeometryReader { proxy in
            Circle()
              .fill(Color.blue)
              .frame(width: proxy.size.width, height: proxy.size.height)
          }
      )
    }
  }
}

struct Geometry_Previews: PreviewProvider {
  static var previews: some View {
    Geometry()
  }
}
