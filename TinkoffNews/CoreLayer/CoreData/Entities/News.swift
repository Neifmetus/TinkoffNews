//
//  News.swift
//  TinkoffNews
//
//  Created by Екатерина Батеева on 08/01/2018.
//  Copyright © 2018 Екатерина Батеева. All rights reserved.
//

import Foundation
import CoreData

extension News {
    
    static func findOrInsertNewsWith(id: String, date: Date, title: String, in context: NSManagedObjectContext) -> News? {
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print("Unable to get model")
            return nil
        }
        
        var news: News?
        guard let fetchRequest = News.fetchRequestNewsWith(id: id, model: model) else {
            return nil
        }
        
        do {
            if let foundedNews = try context.fetch(fetchRequest).first {
                news = foundedNews
            } else {
                news = insertNews(in: context, id: id, date: date, title: title, viewCounter: 0)
            }
        } catch {
            print("Failed to fetch News: \(error)")
            return nil
        }
        
        CoreDataManager.save()
        return news
    }
    
    static func fetchRequestAllNews(model: NSManagedObjectModel) -> NSFetchRequest<News>? {
        let templateName = "AllNews"
        guard let fetchRequest = model.fetchRequestTemplate(forName: templateName) as? NSFetchRequest<News> else {
            assert(false, "No template with name \(templateName)!")
            return nil
        }
        
        return fetchRequest.copy() as? NSFetchRequest<News>
    }
    
    static func fetchRequestNewsWith(id: String, model: NSManagedObjectModel) -> NSFetchRequest<News>? {
        let templateName = "NewsById"
        guard let fetchRequest = model.fetchRequestFromTemplate(withName: templateName,
                                                                substitutionVariables: ["id" : id]) as? NSFetchRequest<News> else {
            assert(false, "No template with name \(templateName)!")
            return nil
        }
        
        return fetchRequest
    }
    
    static func insertNews(in context: NSManagedObjectContext, id: String, date: Date, title: String, viewCounter: Int)-> News? {
        let news = NSEntityDescription.insertNewObject(forEntityName: "News", into: context) as? News
        news?.newsId = id
        news?.publishDate = date
        news?.title = title
        news?.viewCounter = 0
        
        return news
    }
    
    static func updateNews(in context: NSManagedObjectContext, id: String, viewCounter: Int) -> Bool {
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print("Unable to get model")
            return false
        }
        
        guard let fetchRequest = News.fetchRequestNewsWith(id: id, model: model) else {
            return false
        }
        
        do {
            if let foundedNews = try context.fetch(fetchRequest).first {
                foundedNews.viewCounter = Int32(viewCounter)
            }
        } catch {
            print("Failed to update News: \(error)")
            return false
        }
        
        CoreDataManager.save()
        return true
    }
}
