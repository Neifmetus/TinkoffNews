//
//  IParser.swift
//  TinkoffNews
//
//  Created by Екатерина Батеева on 25/12/2017.
//  Copyright © 2017 Екатерина Батеева. All rights reserved.
//

import Foundation

protocol IParser {
    associatedtype Model
    func parse(data: Data) -> Model?
}
