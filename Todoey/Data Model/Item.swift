//
//  Item.swift
//  Todoey
//
//  Created by Remis on 2020-11-14.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    
    // inverse relationship that links back to the parent Category. Specifieng type of the destination of a link, and property name of the invert relationship
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
