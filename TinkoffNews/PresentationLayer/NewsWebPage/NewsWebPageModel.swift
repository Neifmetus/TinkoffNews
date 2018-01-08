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
        guard let context = CoreDataManager.coreDataStack?.saveContext else {
            print("Context error")
            completionHandler(nil)
            return
        }
        
        if let newsPage = NewsPage.findNewsPageWith(id: id, in: context) {
            completionHandler(NewsPageModel(pageHTML: newsPage.newsText))
        } else {
            NewsPageService().loadNewsBy(id: id) { (news: NewsPageApiModel?, error) in
                if let news = news {
                    let newsPage = NewsPage.insertNewsPage(in: context, id: id, text: news.content)
                    completionHandler(NewsPageModel(pageHTML: newsPage?.newsText))
                } else {
                    print("error")
                    completionHandler(nil)
                }
            }
        }
    }
}
