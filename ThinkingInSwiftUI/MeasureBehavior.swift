//
//  MeasureBehavior.swift
//  ThinkingInSwiftUI
//
//  Created by yk on 2020/7/26.
//

import SwiftUI

struct MeasureBehavior<Content: View>: View {
  @State private var width: CGFloat = 100
  @State private var height: CGFloat = 100

  let image = Image(systemName: "ellipsis")

  var content: Content
  var body: some View {
    VStack {
      content
        .border(Color.gray)
        .frame(width: width, height: height)
        .border(Color.black)

      Triangle()
        .rotation(.degrees(45))
        .fill(Color.red)
        .border(Color.blue)
        .frame(width: 150, height: 150)

      Text("Hello")
        .foregroundColor(.black)
        .background(Circle().fill(Color.blue))

      Rectangle()
        .rotation(.degrees(45))
        .fill(Color.red)
        .frame(width: 50, height: 50)
        .clipped()


      ZStack {
        Circle()
          .fill(Color.blue)
          .overlay(Text("Start").foregroundColor(.white))
          .frame(width: 75, height: 75)
        Circle()
          .strokeBorder(Color.white)
          .padding(5)
          .frame(width: 75, height: 75)
      }

      HStack {
        image.offset(x: 50)
        image.resizable().offset(y: -20)
        image.resizable().aspectRatio(contentMode: .fit)
      }.frame(width: 100, height: 100).padding()

      Text("测试2423423423k4j23lwerjwlkrwelkrk4jwerwer")
        .frame(width: 200, height: 40, alignment: .trailing)
        .minimumScaleFactor(0.7)
        .truncationMode(.middle)

      Text("Hello").background(Capsule().stroke().padding(-5))

      Slider(value: $width, in: 0...500)
      Slider(value: $height, in: 0...200)
    }
  }
}

struct MeasureBehavior_Previews: PreviewProvider {
  static var previews: some View {
    MeasureBehavior(content: Rectangle().background(Color.red))
  }
}


struct Triangle: Shape {
  func path(in rect: CGRect) -> Path {
    return Path { p in
      p.move(to: CGPoint(x: rect.midX, y: rect.midY))
      p.addLines([
        CGPoint(x: rect.maxX, y: rect.maxY),
        CGPoint(x: rect.minX, y: rect.maxY),
        CGPoint(x: rect.midX, y: rect.minY)
      ])
    }
  }
}
