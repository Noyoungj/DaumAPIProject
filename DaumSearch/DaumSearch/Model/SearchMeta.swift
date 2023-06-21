//
//  SearchMeta.swift
//  DaumSearch
//
//  Created by 노영재 on 2023/06/21.
//

import Foundation

struct SearchMeta: Decodable {
    var total_count : Int?
    var pageable_count : Int?
    var is_end : Bool?
}
