//
//  NewsService.swift
//  TinkoffNews
//
//  Created by Екатерина Батеева on 26/12/2017.
//  Copyright © 2017 Екатерина Батеева. All rights reserved.
//

import UIKit

protocol INewsService {
    func loadNewsList(from first: Int, to last: Int, completionHandler: @escaping ([NewsApiModel]?, String?) -> Void)
}

class NewsService: INewsService {
    
    func loadNewsList(from first: Int, to last: Int, completionHandler: @escaping ([NewsApiModel]?, String?) -> Void) {
        let requestConfig = RequestsFactory.NewsListRequests.newsConfig(first: first, last: last)
        
        loadNews(requestConfig: requestConfig, completionHandler: completionHandler)
    }
    
    private func loadNews(requestConfig: RequestConfig<NewsParser>,
                          completionHandler: @escaping ([NewsApiModel]?, String?) -> Void) {
        RequestSender().send(requestConfig: requestConfig) { (result: Result<[NewsApiModel]>) in
            
            switch result {
            case .success(let apps):
                completionHandler(apps, nil)
            case .error(let error):
                completionHandler(nil, error)
            }
        }
    }
    
}
