//
//  NewsPage.swift
//  TinkoffNews
//
//  Created by Екатерина Батеева on 08/01/2018.
//  Copyright © 2018 Екатерина Батеева. All rights reserved.
//

import Foundation
import CoreData

extension NewsPage {
    
    static func findNewsPageWith(id: String, in context: NSManagedObjectContext) -> NewsPage? {
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print("Unable to get model")
            return nil
        }
        
        guard let fetchRequest = NewsPage.fetchRequestNewsWith(id: id, model: model) else {
            return nil
        }
        
        do {
            if let foundedNewsPage = try context.fetch(fetchRequest).first {
                return foundedNewsPage
            }
        } catch {
            print("Failed to fetch News: \(error)")
        }
        
        return nil
    }
    
    static func insertNewsPageWith(id: String, text: String, in context: NSManagedObjectContext) -> NewsPage? {
        
        var newsPage: NewsPage?
        if let foundPage = findNewsPageWith(id: id, in: context) {
            newsPage = foundPage
        } else {
            newsPage = insertNewsPage(in: context, id: id, text: text)
        }
        
        CoreDataManager.save()
        return newsPage
    }
    
    static func fetchRequestNewsWith(id: String, model: NSManagedObjectModel) -> NSFetchRequest<NewsPage>? {
        let templateName = "NewsPageById"
        guard let fetchRequest = model.fetchRequestFromTemplate(withName: templateName,
                                                                substitutionVariables: ["id" : id]) as? NSFetchRequest<NewsPage> else {
                                                                    assert(false, "No template with name \(templateName)!")
                                                                    return nil
        }
        
        return fetchRequest
    }
    
    static func insertNewsPage(in context: NSManagedObjectContext, id: String, text: String)-> NewsPage? {
        let newsPage = NSEntityDescription.insertNewObject(forEntityName: "NewsPage", into: context) as? NewsPage
        newsPage?.newsId = id
        newsPage?.newsText = text
        
        return newsPage
    }
}
