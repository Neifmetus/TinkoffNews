//
//  NewsCell.swift
//  TinkoffNews
//
//  Created by Екатерина Батеева on 27/12/2017.
//  Copyright © 2017 Екатерина Батеева. All rights reserved.
//

import Foundation
import UIKit

protocol INewsCell: class {
    var newsId: String {get set}
    var publishDate: Date? {get set}
    var title: String? {get set}
    var counter: Int {get set}
}

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewCounterLabel: UILabel!
    
    private var _newsId: String = ""
    private var _counter: Int = 0
    
    var newsId: String {
        get { return _newsId }
        set {
            _newsId = newValue
        }
    }
    
    var publishDate: Date {
        get { return Date() }
        set {
            let timeFormatter = DateFormatter()
            timeFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
            
            if (Calendar.current.dateComponents([.day], from: Date(), to: newValue).day ?? 0) > 7 {
                timeFormatter.setLocalizedDateFormatFromTemplate("dd/MM/yy")
            } else if (Calendar.current.dateComponents([.hour], from: Date(), to: newValue).hour ?? 0) > 24 {
                timeFormatter.setLocalizedDateFormatFromTemplate("EEE")
            }
            
            dateLabel.text = timeFormatter.string(from: newValue)
        }
    }
    
    var title: String? {
        get { return titleLabel.text }
        set {
            if let newMessage = newValue {
                titleLabel.numberOfLines = 0
                titleLabel.text = newMessage
            }
        }
    }
    
    var counter: Int {
        get { return _counter }
        set {
            _counter = newValue
            viewCounterLabel.text = String(counter)
        }
    }
}
