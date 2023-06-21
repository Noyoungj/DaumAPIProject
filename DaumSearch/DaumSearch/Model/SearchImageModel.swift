//
//  File.swift
//  DaumSearch
//
//  Created by 노영재 on 2023/06/21.
//

import Foundation

struct SearchImageModel : Decodable {
    var documents: [SearchImage]?
    var meta: SearchMeta?
}

struct SearchImage : Decodable {
    var collection : String?
    var thumbnail_url: String?
    var image_url: String?
    var width: Int?
    var height: Int?
    var display_sitename: String?
    var doc_url: String?
    var datetime: String?
}

