//
//  ViewController.swift
//  Bolts-API-Sample
//
//  Created by kawaharadai on 2018/11/29.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

import UIKit
import BoltsSwift

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 非同期でレスポンスを取得
        let response = requestApi()
        print(response.result!)
    }
    
    /// API通信の結果をStringとして取得
    func requestApi() -> Task<String> {
        return APIClient.request(option: .smallAreaSeach(parameters: [:])).continueOnSuccessWith(.queue(DispatchQueue.global()), continuation: { (data) -> String in
            return self.converJsonString(data: data)
        }).continueOnErrorWith(continuation: { (error) -> String in
            return error.localizedDescription
        })
    }
    
    func converJsonString(data: Data) -> String {
        return String(data: data, encoding: .utf8)!
    }
    
}

