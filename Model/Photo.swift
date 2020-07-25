//
//  Photo.swift
//  ThinkingInSwiftUI
//
//  Created by yk on 2020/7/25.
//

import Foundation


struct Photos {
  struct PhotoMeta: Codable, Identifiable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String


    var ID: String {
      return id
    }

//    private enum CodingKeys: String, CodingKey {
//      case downloadURL = "download_url"
//      case id
//      case author
//      case width
//      case height
//      case url
//    }
  }
  var photos: [PhotoMeta]
}

extension Photos: Codable {

}

