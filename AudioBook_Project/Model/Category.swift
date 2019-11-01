//
//  Category.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 10/24/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import Foundation
import SwiftyJSON

class Category {
    var name : String
    var image : String
    
    init(_json : JSON) {
        self.name = _json["name"].stringValue
        self.image = _json["Image"].stringValue
    }
}
