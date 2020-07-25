//
//  Photo.swift
//  ThinkingInSwiftUI
//
//  Created by yk on 2020/7/25.
//

import Foundation


struct Photo: Codable, Identifiable {
  var id, author: String
  let width, height: Int
  let url, download_url: URL
}
