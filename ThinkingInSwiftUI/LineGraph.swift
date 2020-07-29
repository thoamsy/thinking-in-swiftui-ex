//
//  LineGraph.swift
//  ThinkingInSwiftUI
//
//  Created by yk on 2020/7/29.
//

import SwiftUI

struct LineGraph: Shape {
  let sampleData: [CGFloat]
  func path(in rect: CGRect) -> Path {
    Path { p in
      guard sampleData.count > 1 else { return }
      let start = sampleData.first!
      p.move(to: CGPoint(x: 0, y: (1 - start) * rect.height))

      for (offset, point) in zip(sampleData.indices, sampleData) {
        let x = rect.width * CGFloat(offset) / CGFloat(sampleData.count - 1)
        let y = (1 - point) * rect.height
        p.addLine(to: CGPoint(x: x, y: y))
      }
    }
  }
}



struct LineGraphView: View {
  @State var visible = false

  var body: some View {
    VStack {
      LineGraph(sampleData: [0.4, 0.8, 0, 0.23, 0.73, 1, 0.4, 0])
        .trim(from: 0, to: visible ? 1 : 0)
        .stroke(Color.red, lineWidth: 2)
        .aspectRatio(16/9, contentMode: .fit)
        .border(Color.gray, width: 1)
        .padding()

      Button("Animate") {
        withAnimation(
          Animation.easeInOut(duration: 2)
        ) {
          self.visible.toggle()
        }
      }
      
    }
  }
}

struct LineGraph_Previews: PreviewProvider {
    static var previews: some View {
      LineGraphView()
    }
}
