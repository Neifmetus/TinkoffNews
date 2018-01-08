//
//  NewsListModel.swift
//  TinkoffNews
//
//  Created by Екатерина Батеева on 26/12/2017.
//  Copyright © 2017 Екатерина Батеева. All rights reserved.
//

import Foundation
import CoreData

struct NewsDisplayModel {
    let newsId: String
    let title: String
    let publishDate: Date
    let viewCounter: Int32
}

class NewsListModel {
    
    var context: NSManagedObjectContext?
    var fetchedResultsController: NSFetchedResultsController<News>?
    var newsList: [NewsDisplayModel] = []
    
    init() {
        context = CoreDataManager.coreDataStack?.saveContext
        
        if let model = context?.persistentStoreCoordinator?.managedObjectModel {
            let fetchRequest = News.fetchRequestAllNews(model: model)
            let dateSortDescriptor = NSSortDescriptor(key: "publishDate", ascending: false)
            fetchRequest?.sortDescriptors = [dateSortDescriptor]
            
            self.fetchedResultsController = NSFetchedResultsController<News>(fetchRequest: fetchRequest!,
                                                                        managedObjectContext: context!,
                                                                        sectionNameKeyPath: "publishDate",
                                                                        cacheName: nil)
            do {
                try self.fetchedResultsController?.performFetch()
            } catch {
                print("Unable to perform fetch")
            }
            
            if let objects = self.fetchedResultsController?.fetchedObjects {
                for news in objects {
                    if let id = news.newsId, let title = news.title, let date = news.publishDate {
                        newsList.append(NewsDisplayModel(newsId: id,
                                                         title: title,
                                                         publishDate: date,
                                                         viewCounter: news.viewCounter))
                    }
                }
            }
        }
    }
    
    func fetchNewApps(from first: Int, to last: Int, completionHandler: @escaping ([NewsDisplayModel]?) -> Void) {
        
        NewsService().loadNewsList(from: first, to: last) { (news: [NewsApiModel]?, error) in
            
            if let news = news, let context = self.context {
                var cells: [NewsDisplayModel] = []
                for foundNews in news {
                    let object = News.findOrInsertNewsWith(id: foundNews.newsId,
                                              date: foundNews.publishDate,
                                              title: foundNews.title,
                                              in: context)
                    cells.append(NewsDisplayModel(newsId: foundNews.newsId,
                                                  title: foundNews.title,
                                                  publishDate: foundNews.publishDate,
                                                  viewCounter: object?.viewCounter ?? 0))
                    
                }
                
                completionHandler(cells)
            } else {
                print("error")
                completionHandler(nil)
            }
        }
    }
    
    func updateNewsBy(id: String, viewCounter: Int) {
        if let context = self.context {
            let isUpdated = News.updateNews(in: context, id: id, viewCounter: viewCounter)
            print("News update: \(isUpdated)")
        }
    }
}
