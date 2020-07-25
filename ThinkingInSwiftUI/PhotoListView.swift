//
//  PhotoListView.swift
//  ThinkingInSwiftUI
//
//  Created by yk on 2020/7/25.
//

import SwiftUI

struct PhotoListView: View {
  @ObservedObject var items = Remote(
    url: URL(string: "https://picsum.photos/v2/list")!,
    transform: {
      try? JSONDecoder().decode([Photo].self, from: $0)
    })

  var `default`: [String] {
    ["Mark", "Elon Musk", "Steve Jobs", "Tim Cook", "Thomas"]
  }

  var body: some View {
    NavigationView {
      VStack {
        if items.value == nil {
          List(self.default, id: \.self) { author in
            PhotoCell(author: author, redaction: .placeholder)
          }.onAppear {
            self.items.load()
          }
        } else {
          List(items.value ?? []) { photo in
            NavigationLink(
              destination: PhotoDetailView(photo.download_url)
            ) {
              PhotoCell(author: photo.author)
            }
          }
        }
      }.navigationTitle("Photos")
    }
  }
}


struct PhotoCell: View {
  let author: String
  var redaction: RedactionReasons?

  var body: some View {
    VStack(alignment: .leading) {
      Text(author)
        .foregroundColor(Color(UIColor.label))
        .redacted(reason: redaction ?? .init())
    }
  }
}

struct PhotoListView_Previews: PreviewProvider {
  static var previews: some View {
    PhotoListView()
  }
}
