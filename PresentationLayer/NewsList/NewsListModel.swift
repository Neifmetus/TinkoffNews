//
//  NewsListModel.swift
//  TinkoffNews
//
//  Created by Екатерина Батеева on 26/12/2017.
//  Copyright © 2017 Екатерина Батеева. All rights reserved.
//

import Foundation

struct NewsDisplayModel {
    let newsId: String
    let title: String
    let publishDate: Date
}

class NewsListModel {
    
    func fetchNewApps(from first: Int, to last: Int, completionHandler: @escaping ([NewsDisplayModel]?) -> Void) {
        NewsService().loadNewsList(from: first, to: last) { (news: [NewsApiModel]?, error) in
            
            if let news = news {
                let cells = news.map({ NewsDisplayModel(newsId: $0.newsId, title: $0.title, publishDate: $0.publishDate) })
                completionHandler(cells)
            } else {
                print("error")
                completionHandler(nil)
            }
        }
    }
}
