//
//  SearchVClipModel.swift
//  DaumSearch
//
//  Created by 노영재 on 2023/06/21.
//

import Foundation

import Foundation

struct SearchVClipModel : Decodable {
    var documents: [SearchVClip]?
    var meta: SearchMeta?
}


struct SearchVClip : Decodable {
    var title: String?
    var url: String?
    var datetime: String?
    var play_time: Int?
    var thumbnail: String?
    var author: String?
}

