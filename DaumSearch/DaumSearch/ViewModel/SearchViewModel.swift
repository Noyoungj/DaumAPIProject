//
//  SearchViewModel.swift
//  DaumSearch
//
//  Created by 노영재 on 2023/06/21.
//

import Foundation
import RxSwift
import RxRelay

final class SearchViewModel {
    private let searchService: SearchServiceProtocol

    let disposeBag = DisposeBag()
    init(searchService: SearchServiceProtocol) {
        self.searchService = searchService
    }
    
    func fetchISearch(_ search: String, _ sort: String) -> Observable<[SearchImage]> {
        return searchService.fetchISearch(search, sort).map{ $0.documents! }.map{ $0.map{ self.dateFormatter($0) } }
    }
    
    func dateFormatter(_ model: SearchImage) -> SearchImage {
        var now = model
        let dateStr = now.datetime ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let converData = dateFormatter.date(from: dateStr)
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy.MM.dd"
        myDateFormatter.locale = Locale(identifier: "ko_KR")
        let convertStr = myDateFormatter.string(from: converData!)
        
        now.datetime = convertStr
        return now
    }
}
