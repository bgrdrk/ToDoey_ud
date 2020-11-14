//
//  Category.swift
//  Todoey
//
//  Created by Remis on 2020-11-14.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
