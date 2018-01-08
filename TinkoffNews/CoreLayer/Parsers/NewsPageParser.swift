//
//  NewsPageParser.swift
//  TinkoffNews
//
//  Created by Екатерина Батеева on 29/12/2017.
//  Copyright © 2017 Екатерина Батеева. All rights reserved.
//

import Foundation

struct NewsPageApiModel {
    let content: String
}

class NewsPageParser: IParser {
    func parse(data: Data) -> NewsPageApiModel? {
        // parse the result as JSON, since that's what the API provides
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {
                return nil
            }
            
            guard let payload = json["payload"] as? [String : Any],
                let content = payload["content"] as? String else {
                return nil
            }
        
            return NewsPageApiModel(content: content)
        } catch  {
            print("error trying to convert data to JSON")
            return nil
        }
    }
}
