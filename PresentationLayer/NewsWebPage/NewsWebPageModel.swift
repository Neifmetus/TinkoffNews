//
//  NewsWebPageModel.swift
//  TinkoffNews
//
//  Created by Екатерина Батеева on 28/12/2017.
//  Copyright © 2017 Екатерина Батеева. All rights reserved.
//

import Foundation

struct NewsPageModel {
    let pageHTML: String?
}

class NewsWebPageModel {
    
    func fetchNewsPageBy(id: String, completionHandler: @escaping (NewsPageModel?) -> Void) {
        NewsPageService().loadNewsBy(id: id) { (news: NewsPageApiModel?, error) in
            
            if let news = news {
                completionHandler(NewsPageModel(pageHTML: news.content))
            } else {
                print("error")
                completionHandler(nil)
            }
        }
    }
}
