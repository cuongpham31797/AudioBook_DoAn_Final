//
//  CategoryService.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 10/24/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol CategoryServiceDelegate : class {
    func getCategorySuccess(data : [Category])
    func getCategoryFail(error : Error)
}

class CategoryService {
    
    var categoryArray : Array<Category> = []
    
    weak var delegate : CategoryServiceDelegate?
    
    func getCategory(){
        Alamofire.request(CATEGORY_URL,
                          method: .get,
                          parameters: nil,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { (response) in
                            switch response.result {
                            case .failure(let error):
                                self.delegate?.getCategoryFail(error: error)
                            case .success(let value):
                                let json = JSON(value)
                                let catJSON = json["category"].arrayValue
                                for cat in catJSON {
                                    let category = Category(_json: cat)
                                    self.categoryArray.append(category)
                                }
                                self.delegate?.getCategorySuccess(data: self.categoryArray)
                            }
        }
    }
}
