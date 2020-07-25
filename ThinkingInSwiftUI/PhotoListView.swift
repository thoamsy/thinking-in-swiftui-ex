//
//  PhotoListView.swift
//  ThinkingInSwiftUI
//
//  Created by yk on 2020/7/25.
//

import SwiftUI

//
//struct PhotoDetailView: View {
//  let meta: Photos.PhotoMeta
//
//  var body: some View {
//    Image().frame(width: meta.width, height: meta.height)
//  }
//}

struct PhotoListView: View {
  @ObservedObject var photoData = PhotoData()

  var body: some View {
    NavigationView {
      Section(header: Text("This is photos")) {
        if photoData.loading == RequestStatus.none {
          EmptyView()
        } else {
          List(photoData.data?.photos ?? []) {
            PhotoCell(photoMeta: $0, redaction: photoData.loading == RequestStatus.loading ? .placeholder : nil)
          }.listStyle(InsetListStyle())
          .background(
            Color(UIColor.systemGroupedBackground)
          )
        }
      }.onAppear {
        photoData.startFetch()
      }.navigationTitle("Photos")
    }
  }
}


struct PhotoCell: View {
  let photoMeta: Photos.PhotoMeta
  var redaction: RedactionReasons?

  var body: some View {
    VStack(alignment: .leading) {
      Text(photoMeta.author).foregroundColor(Color(UIColor.label))
    }.frame(
      width: 100, height: 100
    ).background(
      Color(UIColor.secondarySystemGroupedBackground)
    ).redacted(reason: redaction ?? .init())
  }
}

struct PhotoListView_Previews: PreviewProvider {
  static var previews: some View {
    PhotoListView()
  }
}
