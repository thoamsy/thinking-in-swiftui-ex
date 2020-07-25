//
//  ContentView.swift
//  ThinkingInSwiftUI
//
//  Created by yk on 2020/7/25.
//

import SwiftUI
struct ContentView: View {
  @State var counter = 0
  @State private var volume = 0.5


  var body: some View {
    PhotoListView()
  }
}

extension View {
  func debug() -> Self {
    debugPrint(Mirror(reflecting: self).subjectType)
    return self
  }
}

struct TimerView: View {
  @ObservedObject var date = CurrentTime()
  var body: some View {
    Text(date.now, style: .timer)
      .font(.system(.title, design: .monospaced))
      .onAppear {
        self.date.start()
      }.onDisappear {
        self.date.stop()
      }
  }
}

final class CurrentTime: ObservableObject {
  @Published var now = Date()
  let interval: TimeInterval = 1

  private var timer: Timer?

  func stop() {
    guard timer != nil else { return }
    timer?.invalidate()
    timer = nil
  }

  func start() {
    guard timer == nil else { return }
    now = Date()
    timer = Timer.scheduledTimer(
      withTimeInterval: interval,
      repeats: true
    ) {
      [weak self] _ in
      self?.now = Date()
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}