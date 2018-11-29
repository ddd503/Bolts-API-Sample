//
//  RequestOption.swift
//  Bolts-API-Sample
//
//  Created by kawaharadai on 2018/11/30.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

import Alamofire

private let apiAccessKey = "34b17333a5a4e674b5f674d075316dd2"
private let gnaviAPIBaseURL = "https://api.gnavi.co.jp/"
private let middleAreaSeachPath = "master/GAreaMiddleSearchAPI/v3/"
private let smallAreaSeachPath = "master/GAreaSmallSearchAPI/v3/"
private let restSeachPath = "RestSearchAPI/v3/"

/// リクエストするAPIタイプを管理するEnum
public enum RequestOption: URLRequestConvertible {
    case middleAreaSeach(parameters: [String: Any])
    case smallAreaSeach(parameters: [String: Any])
    
    public func asURLRequest() throws -> URLRequest {
        
        let (path, method, parameters): (String, HTTPMethod, [String: Any]) = {
            switch self {
            case .middleAreaSeach(let parameters):
                return (middleAreaSeachPath, .get, parameters)
            case .smallAreaSeach(let parameters):
                return (smallAreaSeachPath, .get, parameters)
            }
        }()
        
        if let url = URL(string: gnaviAPIBaseURL) {
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
        } else {
            fatalError("url is nil")
        }
        
    }
    
}
