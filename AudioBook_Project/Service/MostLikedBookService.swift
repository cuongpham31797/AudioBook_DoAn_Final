//
//  MostLikedBook.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 11/14/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol MostLikedBookDelegate : class {
    func getMostLikedBookSuccess(data : [Book])
    func getMostLikedBookFail(error : Error)
}

class MostLikeBookService {
    private lazy var dataArray : Array<Book> = []
    
    weak var delegate : MostLikedBookDelegate?
    
    func getMostLikedBook(url : String){
        Alamofire.request(url,
                          method: .get,
                          parameters: nil,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { (response) in
                            switch response.result {
                            case .failure(let error):
                                self.delegate?.getMostLikedBookFail(error: error)
                            case .success(let value):
                                let json = JSON(value)
                                let jsonArray = json["book"].arrayValue
                                for bookObj in jsonArray {
                                    let _book = Book(_json: bookObj)
                                    self.dataArray.append(_book)
                                }
                                self.delegate?.getMostLikedBookSuccess(data: self.dataArray)
                            }
        }
    }
}
