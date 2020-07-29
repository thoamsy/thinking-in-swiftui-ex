//
//  Extension+View.swift
//  ThinkingInSwiftUI
//
//  Created by yk on 2020/7/29.
//

import SwiftUI


struct Shake: AnimatableModifier {
  var times: CGFloat = 0
  let amplitude: CGFloat = 10
  var animatableData: CGFloat {
    get { times }
    set {
      times = newValue
    }
  }

  func body(content: Content) -> some View {
    return content.offset(x: sin(times * .pi * 2) * amplitude)
  }
}



struct Bounce: AnimatableModifier {
  var times: CGFloat = 0
  let amplitude: CGFloat = 10
  var animatableData: CGFloat {
    get { times }
    set {
      times = newValue
    }
  }

  func body(content: Content) -> some View {
    return content.offset(y: -abs(sin(times * .pi)) * amplitude)
  }
}


extension View {
  func shake(times: Int) -> some View {
    return modifier(Shake(times: CGFloat(times)))
  }
  func bounce(times: Int) -> some View {
    return modifier(Bounce(times: CGFloat(times)))
  }
}

struct ShakeView: View {
  @State private var taps: Int = 0

  var body: some View {
  Button("Shake me") {
    withAnimation {
      self.taps += 1
    }
  }.shake(times: taps * 3)
  }
}

struct BounceView: View {
  @State private var taps: Int = 0

  var body: some View {
    Button("Hello Bounce") {
      withAnimation {
        self.taps += 1
      }
    }.bounce(times: taps * 3)
  }
}
