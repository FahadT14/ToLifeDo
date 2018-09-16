//
//  Item.swift
//  ToLifeDo
//
//  Created by Fahad Tariq on 09/09/2018.
//  Copyright © 2018 Fahad Tariq. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var list : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCatogary = LinkingObjects(fromType: Catogary.self, property: "items")
    
}
