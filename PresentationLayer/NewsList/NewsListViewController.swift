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
        
        newsModel.fetchNewApps(from: 0, to: 20) { news in
            self.newsList = news
            DispatchQueue.main.async {
                self.newsTableView.reloadData()
            }
        }
        
        newsTableView.rowHeight = UITableViewAutomaticDimension
        newsTableView.estimatedRowHeight = 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = NewsCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! NewsCell
        if ((newsList?.count)! - 1 ) > indexPath.row {
            cell.publishDate = newsList![indexPath.row].publishDate
            cell.title = newsList![indexPath.row].title
            cell.newsId = newsList![indexPath.row].newsId
            cell.counter = 0
        } else {
            newsModel.fetchNewApps(from: indexPath.row, to: indexPath.row + 20) { news in
                if let news = news {
                    self.newsList?.append(contentsOf: news)
                    DispatchQueue.main.async {
                        newsTableView.reloadData()
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
                webViewController.id = cell.newsId
            }
            
            if let navigator = navigationController {
                navigator.pushViewController(webViewController, animated: true)
            }
        }
    }
}
