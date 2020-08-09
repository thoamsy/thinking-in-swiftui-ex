//
//  ContentView.swift
//  ThinkingInSwiftUI
//
//  Created by yk on 2020/7/25.
//

import SwiftUI

struct DarkBlueShadowProgressViewStyle: ProgressViewStyle {
  func makeBody(configuration: Configuration) -> some View {
    ProgressView(configuration)
      .shadow(color: Color(red: 0, green: 0, blue: 0.7),
              radius: 4.0,
              x: 1.0,
              y: 2.0
      )
  }
}

struct ContentView: View {
  @State var counter = 0
  @State private var volume = 0.5
  @State private var bgColor =
    Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
  @State private var date = Date()


  var body: some View {
    //    PhotoListView()
    NavigationView {
      VStack {
        VStack {
          ProgressView(value: 0.5, total: 10) {
            Text("111")
          }
          ProgressView()
        }

        ColorPicker("Alignment Guides", selection: $bgColor)
        //      DatePicker("This is a date", selection: $date)
      }.navigationBarItems(trailing: Menu {
        Button("Duplicate", action: {})
        Button("Rename", action: {})
        Button("Delete…", action: {})
        Menu("Copy") {
          Button("Copy", action: {})
          Button("Copy Formatted", action: {})
          Button("Copy Library Path", action: {})
        }
      } label: {
        Label("PDF", systemImage: "doc.fill")
      })
    }
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
