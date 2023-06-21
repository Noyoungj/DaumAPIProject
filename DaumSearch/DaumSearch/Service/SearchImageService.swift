//
//  SearchService.swift
//  DaumSearch
//
//  Created by 노영재 on 2023/06/21.
//

import Foundation
import Moya
import RxSwift

typealias SearchServiceProtocol = SearchImageServiceProtocol & SearchVClipServiceProtocol & SearchBlogServiceProtocol

protocol SearchImageServiceProtocol {
    func fetchISearch(_ search: String, _ sort: String) -> Observable<SearchImageModel>
}

protocol SearchVClipServiceProtocol {
    func fetchVSearch(_ search: String, _ sort: String) -> Observable<SearchVClipModel>
}

protocol SearchBlogServiceProtocol {
    func fetchBSearch(_ search: String, _ sort: String) -> Observable<SearchBlogModel>
}

final class SearchService : SearchServiceProtocol {
    //MARK: Image Servic
    func fetchISearch(_ search: String, _ sort: String) -> Observable<SearchImageModel> {
        return Observable.create { observable -> Disposable in
            self.fetchImageSearch(search, sort) { error, search in
                if let error = error {
                    observable.onError(error)
                }
                
                if let search = search {
                    observable.onNext(search)
                }
                
                observable.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    private func fetchImageSearch(_ search: String, _ sort: String, completion: @escaping((Error?, SearchImageModel?) -> Void)) {
        let provide = MoyaProvider<MainAPI>()
        
        provide.request(.searchblog(search, sort, 10, 10)) { result in
            switch result {
            case let .success(response):
                let result = try? response.map(SearchImageModel.self)
                completion(nil,result)
            case let .failure(error):
                print("SEARCH IMAGE API ERRPR: \(error.localizedDescription)")
                completion(error, nil)
            }
        }
    }
    
    //MARK: VClip Service
    func fetchVSearch(_ search: String, _ sort: String) -> RxSwift.Observable<SearchVClipModel> {
        return Observable.create { observable -> Disposable in
            self.fetchVClipSearch(search, sort) { error, search in
                if let error = error {
                    observable.onError(error)
                }
                
                if let search = search {
                    observable.onNext(search)
                }
                
                observable.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    private func fetchVClipSearch(_ search: String, _ sort: String, completion: @escaping((Error?, SearchVClipModel?) -> Void)) {
        let provider = MoyaProvider<MainAPI>()
        
        provider.request(.searchVideo(search, sort, 10, 10)) { result in
            switch result {
            case let .success(response):
                let result = try? response.map(SearchVClipModel.self)
                completion(nil, result)
            case let .failure(error):
                print("SEARCH VClip API ERROR: \(error.localizedDescription)")
                completion(error, nil)
            }
        }
    }
    
    //MARK: Blog Service
    func fetchBSearch(_ search: String, _ sort: String) -> RxSwift.Observable<SearchBlogModel> {
        return Observable.create { observable -> Disposable in
            self.fetchBlogSearch(search, sort) { error, search in
                if let error = error {
                    observable.onError(error)
                }
                
                if let search = search {
                    observable.onNext(search)
                }
                
                observable.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    private func fetchBlogSearch(_ search: String, _ sort: String, completion: @escaping((Error?, SearchBlogModel?) -> Void)) {
        let provider = MoyaProvider<MainAPI>()
        
        provider.request(.searchblog(search, sort, 10, 10)) { result in
            switch result {
            case let .success(response):
                let result = try? response.map(SearchBlogModel.self)
                completion(nil, result)
            case let .failure(error):
                print("SEARCH Blog API ERROR: \(error.localizedDescription)")
                completion(error, nil)
            }
        }
    }
    
    
}
