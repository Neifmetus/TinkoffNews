//
//  CoreDataManager.swift
//  TinkoffNews
//
//  Created by Екатерина Батеева on 08/01/2018.
//  Copyright © 2018 Екатерина Батеева. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    private static var _coreDataStack: CoreDataStack?
    public static var coreDataStack: CoreDataStack? {
        get {
            if _coreDataStack == nil {
                _coreDataStack = CoreDataStack()
            }
            return _coreDataStack
        }
    }
    
    static func save() {
        if let context = self.coreDataStack?.saveContext {
            self.coreDataStack?.performSave(context: context, completion: {
                print("Save context success!")
            })
        } else {
            print("Unable to save context!")
        }
    }
   
}
