//
//  Category.swift
//  Todoey
//
//  Created by Roy Li on 10/8/18.
//  Copyright © 2018 Roy Li. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
    
}
