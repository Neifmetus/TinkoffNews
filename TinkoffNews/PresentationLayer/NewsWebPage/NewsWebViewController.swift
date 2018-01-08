//
//  NewsWebViewController.swift
//  TinkoffNews
//
//  Created by Екатерина Батеева on 28/12/2017.
//  Copyright © 2017 Екатерина Батеева. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class NewsWebPageViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    var id: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newsModel = NewsWebPageModel()
        newsModel.fetchNewsPageBy(id: id) { news in
            DispatchQueue.main.async {
                self.webView.loadHTMLString((news?.pageHTML)!, baseURL: nil)
            }
        }
    }
}
