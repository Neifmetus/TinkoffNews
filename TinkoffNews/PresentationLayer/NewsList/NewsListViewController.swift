//
//  ViewController.swift
//  TinkoffNews
//
//  Created by Екатерина Батеева on 23/12/2017.
//  Copyright © 2017 Екатерина Батеева. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var newsTableView: UITableView!
    
    let newsModel = NewsListModel()
    var newsList: [NewsDisplayModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.newsList = newsModel.newsList.count > 20 ? Array(newsModel.newsList[0..<20]) : newsModel.newsList
        
        newsModel.fetchNewApps(from: 0, to: 20) { news in
            let count = news?.count ?? 0
            if count > 0 {
                self.newsList = news
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                }
            }
        }
        
        newsTableView.rowHeight = UITableViewAutomaticDimension
        newsTableView.estimatedRowHeight = 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! NewsCell
        
        if let newsList = newsList {
            if (newsList.count - 1) > indexPath.row {
                let news = newsList[indexPath.row]
                cell.publishDate = news.publishDate
                cell.title = news.title
                cell.newsId = news.newsId
                cell.counter = Int(news.viewCounter)
            } else {
                newsModel.fetchNewApps(from: indexPath.row, to: indexPath.row + 20) { news in
                    if let news = news {
                        self.newsList?.append(contentsOf: news)
                        DispatchQueue.main.async {
                            self.newsTableView.reloadData()
                        }
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let webViewController = UIStoryboard(name: "NewsPage", bundle: nil).instantiateViewController(withIdentifier: "NewsPage") as? NewsWebPageViewController {
            if let cell = tableView.cellForRow(at: indexPath) as? NewsCell {
                cell.counter = cell.counter + 1
                webViewController.id = cell.newsId
                newsModel.updateNewsBy(id: cell.newsId, viewCounter: cell.counter)
            }
            
            if let navigator = navigationController {
                navigator.pushViewController(webViewController, animated: true)
            }
        }
    }
}
