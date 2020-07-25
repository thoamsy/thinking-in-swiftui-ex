//
//  PhotoDetailView.swift
//  ThinkingInSwiftUI
//
//  Created by yk on 2020/7/26.
//

import SwiftUI

struct PhotoDetailView: View {
  @ObservedObject var image: Remote<UIImage>

  init(_ url: URL) {
    image = Remote(url: url) {
      UIImage(data: $0)
    }
  }
  var body: some View {
    Group {
      if image.value == nil {
        Rectangle()
          .size(width: 500, height: 500)
          .onAppear {
            self.image.load()
        }
      } else {
        Image(uiImage: image.value!)
          .resizable()
          .aspectRatio(image.value!.size, contentMode: .fit)
      }
    }
  }
}
struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
      PhotoDetailView(URL(string: "https://picsum.photos/id/1009/5000/7502")!)
    }
}
