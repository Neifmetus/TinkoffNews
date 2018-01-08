//
//  NewsPageParcer.swift
//  TinkoffNews
//
//  Created by Екатерина Батеева on 07/01/2018.
//  Copyright © 2018 Екатерина Батеева. All rights reserved.
//

import Foundation
import UIKit

protocol INewsPageService {
    func loadNewsBy(id: String, completionHandler: @escaping (NewsPageApiModel?, String?) -> Void)
}

class NewsPageService: INewsPageService {
    
    func loadNewsBy(id: String, completionHandler: @escaping (NewsPageApiModel?, String?) -> Void) {
        let requestConfig = RequestsFactory.NewsListRequests.newsPageConfig(id: id)
        
        loadNews(requestConfig: requestConfig, completionHandler: completionHandler)
    }
    
    private func loadNews(requestConfig: RequestConfig<NewsPageParser>,
                          completionHandler: @escaping (NewsPageApiModel?, String?) -> Void) {
        RequestSender().send(requestConfig: requestConfig) { (result: Result<NewsPageApiModel>) in
            
            switch result {
            case .success(let apps):
                completionHandler(apps, nil)
            case .error(let error):
                completionHandler(nil, error)
            }
        }
    }
    
}

