//
//  RequestFactory.swift
//  TinkoffNews
//
//  Created by Екатерина Батеева on 26/12/2017.
//  Copyright © 2017 Екатерина Батеева. All rights reserved.
//

import Foundation

struct RequestsFactory {
    
    struct NewsListRequests {
        
        static func newsConfig(first: Int, last: Int) -> RequestConfig<NewsParser> {
            return RequestConfig<NewsParser>(request: NewsRequests(first: first, last: last), parser: NewsParser())
        }
        
        static func newsPageConfig(id: String) -> RequestConfig<NewsPageParser> {
            return RequestConfig<NewsPageParser>(request: NewsInfoRequests(id: id), parser: NewsPageParser())
        }
    }
    
}
