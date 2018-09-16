//
//  Catogary.swift
//  ToLifeDo
//
//  Created by Fahad Tariq on 09/09/2018.
//  Copyright © 2018 Fahad Tariq. All rights reserved.
//

import Foundation
import RealmSwift

class Catogary: Object {
    @objc dynamic var name : String = ""
    
    let items = List<Item>()
    
}
