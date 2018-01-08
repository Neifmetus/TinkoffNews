//
//  NewsInfoRequests.swift
//  TinkoffNews
//
//  Created by Екатерина Батеева on 06/01/2018.
//  Copyright © 2018 Екатерина Батеева. All rights reserved.
//

import Foundation

class NewsInfoRequests: IRequest {
    private var baseUrl: String =  "https://api.tinkoff.ru/v1/"
    private var method: String = "news_content"
    private var id: String = ""
    private var getParameters: [String : String]  {
        return ["id" : id]
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
    init(id: String) {
        self.id = id
    }
}
