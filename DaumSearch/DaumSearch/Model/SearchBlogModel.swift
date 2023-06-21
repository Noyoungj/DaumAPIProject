//
//  SearchBlogModel.swift
//  DaumSearch
//
//  Created by 노영재 on 2023/06/21.
//

import Foundation

struct SearchBlogModel : Decodable {
    var documents: [SearchBlog]?
    var meta: SearchMeta?
}

struct SearchBlog : Decodable {
    var title: String?
    var contents: String?
    var url: String?
    var blogname: String?
    var thumbnail: String?
    var datetime: String?
}

