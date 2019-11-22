//
//  Book.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 11/14/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import Foundation
import SwiftyJSON

class Book {
    var id : Int
    var name : String
    var image : String
    
    init(_json : JSON) {
        self.id = _json["id_book"].intValue
        self.name = _json["name"].stringValue
        self.image = _json["image"].stringValue
    }
}
