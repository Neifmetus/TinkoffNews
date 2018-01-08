//
//  RequestSender.swift
//  TinkoffNews
//
//  Created by Екатерина Батеева on 25/12/2017.
//  Copyright © 2017 Екатерина Батеева. All rights reserved.
//

import Foundation

class RequestSender: IRequestSender {
    
    let session = URLSession.shared
    
    func send<Parser>(requestConfig config: RequestConfig<Parser>,
                      completionHandler: @escaping (Result<Parser.Model>) -> Void) {
        guard let urlRequest = config.request.urlRequest else {
            completionHandler(Result.error("url string can't be parsed to URL"))
            return
        }
        
        let task = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                completionHandler(Result.error(error.localizedDescription))
                return
            }
            guard let data = data,
                let parsedModel: Parser.Model = config.parser.parse(data: data) else {
                    completionHandler(Result.error("received data can't be parsed"))
                    return
            }
            
            completionHandler(Result.success(parsedModel))
        }
        
        task.resume()
    }
}
