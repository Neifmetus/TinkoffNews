//
//  NewsRequests.swift
//  TinkoffNews
//
//  Created by Екатерина Батеева on 25/12/2017.
//  Copyright © 2017 Екатерина Батеева. All rights reserved.
//

import Foundation

class NewsRequests: IRequest {
    private var baseUrl: String =  "https://api.tinkoff.ru/v1/"
    private var method: String = "news"
    private var first: String = "0"
    private var last: String = "0"
    private var getParameters: [String : String]  {
        return ["first" : first,
                "last": last]
    }
    private var urlString: String {
        let getParams = getParameters.flatMap({ "\($0.key)=\($0.value)"}).joined(separator: "&")
        return baseUrl + method + "?" + getParams
    }
    
    // MARK: - IRequest
    
    var urlRequest: URLRequest? {
        if let url = URL(string: urlString) {
            return URLRequest(url: url)
        }
        return nil
    }
    
    // MARK: - Initialization
    init(first: Int, last: Int) {
        self.first = String(first)
        self.last = String(last)
    }
}
