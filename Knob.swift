//
//  Knob.swift
//  ThinkingInSwiftUI
//
//  Created by yk on 2020/7/25.
//

import SwiftUI

struct KnobShape: Shape {
  var pointerSize: CGFloat = 0.1 // these are relative values
  var pointerWidth: CGFloat = 0.1
  func path(in rect: CGRect) -> Path {
    let pointerHeight = rect.height * pointerSize
    let pointerWidth = rect.width * self.pointerWidth
    let circleRect = rect.insetBy(dx: pointerHeight, dy: pointerHeight)
    return Path { p in
      p.addEllipse(in: circleRect)
      p.addRect(CGRect(x: rect.midX - pointerWidth/2, y: 0, width: pointerWidth, height: pointerHeight + 2))
    }
  }
}

fileprivate struct PointerSizeKey: EnvironmentKey {
  static let defaultValue: CGFloat = 0.1
}

extension EnvironmentValues {
  var knobPointerSize: CGFloat {
    get { self[PointerSizeKey.self] }
    set { self[PointerSizeKey.self] = newValue }
  }
}

extension View {
  func knobPointerSize(_ size: CGFloat) -> some View {
    self.environment(\.knobPointerSize, size)
  }
}

struct Knob: View {
  @Binding var value: Double // should be between 0 and 1
  var pointerSize: CGFloat? = nil
  @Environment(\.knobPointerSize) var envPointerSize
  @Environment(\.colorScheme) var colorScheme

  var body: some View {
    KnobShape()
      .fill(Color.gray)
      .rotationEffect(Angle(degrees: value * 330))
      .onTapGesture {
        self.value = self.value < 0.5 ? 1 : 0
      }
    //    KnobShape(pointerSize: pointerSize ?? envPointerSize)
    //      .fill(colorScheme == .dark ? Color.white : .black)
    //      .rotationEffect(Angle(degrees: value * 330))
    //      .onTapGesture {
    //        withAnimation(.default) {
    //          self.value = self.value < 0.5 ? 1 : 0
    //        }
    //      }
  }
}

struct Knob_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Knob(value: .constant(0.5))
        .frame(width: 100, height: 100)
    }
  }
}
