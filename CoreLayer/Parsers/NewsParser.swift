//
//  NewsParser.swift
//  TinkoffNews
//
//  Created by Екатерина Батеева on 25/12/2017.
//  Copyright © 2017 Екатерина Батеева. All rights reserved.
//

import Foundation

struct NewsApiModel {
    let newsId: String
    let title: String
    let publishDate: Date
}

class NewsParser: IParser {
    typealias Model = [NewsApiModel]
    
    func parse(data: Data) -> [NewsApiModel]? {
        // parse the result as JSON, since that's what the API provides
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {
                return nil
            }
            
            guard let payload = json["payload"] as? [[String : Any]] else {
                    return nil
            }
            
            var news: [NewsApiModel] = []
            
            for article in payload {
                guard let id = article["id"] as? String,
                    let title = article["text"] as? String,
                    let publicationDate = article["publicationDate"] as? [String : Any],
                    let date = getDate(publicationDate: publicationDate)
                    else {
                        continue
                    }
                news.append(NewsApiModel(newsId: id, title: title, publishDate: date))
            }
            
            return news
            
        } catch  {
            print("error trying to convert data to JSON")
            return nil
        }
    }
    
    private func getDate(publicationDate: [String : Any]) -> Date? {
        if let milliseconds = publicationDate["milliseconds"] as? Int {
            return Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
        } else {
            return nil
        }
    }
}
