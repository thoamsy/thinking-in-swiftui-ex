//
//  PhotoData.swift
//  ThinkingInSwiftUI
//
//  Created by yk on 2020/7/25.
//

import Combine
import Foundation

enum RequestStatus {
  case none
  case loading
  case finish
}

final class PhotoData: ObservableObject {
  @Published var loading = RequestStatus.none
  @Published var data: Photos?


  func startFetch() {
    loading = .loading
    let url = URL(string: "https://picsum.photos/v2/list")!
    URLSession.shared.dataTask(with: url) {
      data, response, _ in
      guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
        return
      }

      let decoder = JSONDecoder()
      if let data = data {
        
        let photos = try! decoder.decode([Photos.PhotoMeta].self, from: data)

        DispatchQueue.main.async {
          [weak self] in
          self?.loading = .finish
          self?.data = Photos(photos: photos)
        }
      }
    }.resume()
  }


}
