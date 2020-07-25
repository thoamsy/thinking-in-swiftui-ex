//
//  PhotoDetailView.swift
//  ThinkingInSwiftUI
//
//  Created by yk on 2020/7/26.
//

import SwiftUI

struct PhotoDetailView: View {
  @ObservedObject var image: Remote<UIImage>
  let aspectRadio: CGFloat

  init(_ url: URL, aspectRadio: CGFloat) {
    image = Remote(url: url) {
      UIImage(data: $0)
    }
    self.aspectRadio = aspectRadio
  }

  var imageOrPlaceholder: Image {
    image.value.map(Image.init) ?? Image(systemName: "photo")
  }

  var body: some View {
    imageOrPlaceholder
      .resizable()
      .foregroundColor(.secondary)
      .onAppear {
        self.image.load()
      }
      .aspectRatio(
        aspectRadio,
        contentMode: .fit
      )
  }
}

struct PhotoDetailView_Previews: PreviewProvider {
  static var previews: some View {
    PhotoDetailView(URL(string: "https://picsum.photos/id/1009/5000/7502")!, aspectRadio: 0.7)
  }
}
