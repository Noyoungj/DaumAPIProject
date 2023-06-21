//
//  File.swift
//  DaumSearch
//
//  Created by 노영재 on 2023/06/21.
//

import Foundation
import Moya

enum MainAPI {
    case searchblog(_  query: String, _ sort: String, _ page: Int, _ size: Int)
    case searchVideo(_  query: String, _ sort: String, _ page: Int, _ size: Int)
    case searchImage(_  query: String, _ sort: String, _ page: Int, _ size: Int)
}

extension MainAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://dapi.kakao.com")!
    }
    
    var path: String {
        switch self {
        case .searchblog:
            return "/v2/search/blog"
        case .searchImage:
            return "/v2/search/image"
        case .searchVideo:
            return "/v2/search/vclip"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .searchImage(let q, let s, let p, let size):
            let parameter : [String: Any] = [
                "query" : q,
                "sort" : s,
                "page" : p,
                "size" : size
            ]
            
            return .requestParameters(parameters: parameter, encoding: URLEncoding.queryString)
        case .searchVideo(let q, let s, let p, let size):
            let parameter : [String: Any] = [
                "query" : q,
                "sort" : s,
                "page" : p,
                "size" : size
            ]
            
            return .requestParameters(parameters: parameter, encoding: URLEncoding.queryString)
        case .searchblog(let q, let s, let p, let size):
            let parameter : [String: Any] = [
                "query" : q,
                "sort" : s,
                "page" : p,
                "size" : size
            ]
            
            return .requestParameters(parameters: parameter, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Authorization": "KakaoAK 559b612caf722893cfe88e1b446e1709"]
    }
}
