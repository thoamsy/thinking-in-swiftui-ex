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

  @State private var selected = false
  @State private var animating = false
  @State private var visible = false


  var content: Content
  var body: some View {
    VStack {

      Button(action: { self.selected.toggle() }) {
        RoundedRectangle(cornerRadius: 10) .fill(selected ? Color.red : .green)
          .frame(
            width: selected ? 100 : 50,
            height: selected ? 100 : 50
          )

      }
      .animation(.linear(duration: 0.5))

      VStack {
        Button("Toggle") {
          self.visible.toggle()
        }
        if visible {
          Rectangle()
            .fill(Color.blue)
            .frame(width: 100, height: 100)
            .transition(.slide)
            .animation(.default)
        }
      }

      Image(systemName: "rays")
        .rotationEffect(animating ? Angle.degrees(350) : .zero)
        .animation(
          Animation.linear(duration: 2).repeatForever(autoreverses: false)
        ).onAppear {
          self.animating = true
        }

//      content
//        .border(Color.gray)
//        .frame(width: width, height: height)
//        .border(Color.black)
//
//      Triangle()
//        .rotation(.degrees(45))
//        .fill(Color.red)
//        .border(Color.blue)
//        .frame(width: 150, height: 150)
//
//      Text("Hello")
//        .foregroundColor(.black)
//        .background(Circle().fill(Color.blue))
//
//      HStack {
//        Text("lorem lorem lorem lorem lorel lorem lorem lorem lorem lorem lorem  ")
//          .truncationMode(.middle).lineLimit(1)
//        Text("chapter1.md").alignmentGuide(.center, computeValue: { dimension in
//          dimension[.center] - 20
//        })
//      }.border(Color.black).frame(height: 80)
//
//
//      Rectangle()
//        .rotation(.degrees(45))
//        .fill(Color.red)
//        .frame(width: 50, height: 50)
//        .clipped()
//
//
//      HStack {
//        image.offset(x: 50)
//        image.resizable().offset(y: -20)
//        image.resizable().aspectRatio(contentMode: .fit)
//      }.frame(width: 100, height: 100).padding()
//
//      Text("测试2423423423k4j23lwerjwlkrwelkrk4jwerwer")
//        .frame(width: 200, height: 40, alignment: .trailing)
//        .minimumScaleFactor(0.7)
//        .truncationMode(.middle)
//
//      Text("Hello").background(Capsule().stroke().padding(-5))
//      Button("Hello", action: {}).buttonStyle(CircleStyle())
    }
  }
}

struct CircleStyle: ButtonStyle {
  var foreground = Color.white
  var background = Color.blue

  func makeBody(configuration: Configuration) -> some View {
    Circle()
      .fill(background.opacity(configuration.isPressed ? 0.8 : 1))
      .overlay(Circle().strokeBorder(foreground).padding(3))
      .overlay((configuration.label.foregroundColor(foreground)))
      .frame(width: 75, height: 75)
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
