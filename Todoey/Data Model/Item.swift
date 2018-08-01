//
//  Item.swift
//  Todoey
//
//  Created by Roy Li on 1/8/18.
//  Copyright © 2018 Roy Li. All rights reserved.
//

import Foundation

class Item : Encodable,Decodable {
    var title: String = ""
    var done: Bool = false
}

