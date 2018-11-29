//
//  APIClient.swift
//  Bolts-API-Sample
//
//  Created by kawaharadai on 2018/11/30.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

import Alamofire
import BoltsSwift

enum APIResult {
    case success(Data)
    case error(Error)
}

final class APIClient {
    
    /// API通信を行う
    ///
    /// - Parameters:
    ///   - option: リクエストするパラメータなど
    ///   - completionHandler: 実行結果を返す
    static func request(option: RequestOption) -> Task<Data> {
        let completionSource = TaskCompletionSource<Data>()
        Alamofire.request(option).responseData { response in
            switch response.result {
            case .success(let value):
                completionSource.set(result: value)
            case .failure(let error):
                completionSource.set(error: error)
            }
        }
        return completionSource.task
    }
    
    /// 通信状態を返す
    ///
    /// - Returns: true: オンライン, false: オフライン
    static func onLineNetwork() -> Bool {
        if let reachabilityManager = NetworkReachabilityManager() {
            reachabilityManager.startListening()
            return reachabilityManager.isReachable
        }
        return false
    }
    
}
