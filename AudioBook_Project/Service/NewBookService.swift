//
//  BookService.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 11/14/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NewBookServiceDelegate : class {
    func getNewestBookSuccess(data : [Book])
    func getNewestBookFail(error : Error)
}

class NewBookService {
    private lazy var bookArray : Array<Book> = []
    
    weak var delegate : NewBookServiceDelegate?
    
    func getNewestBook(url : String){
        Alamofire.request(url,
                          method: .get,
                          parameters: nil,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { (response) in
                            switch response.result{
                            case .failure(let error):
                                self.delegate?.getNewestBookFail(error: error)
                            case .success(let value):
                                let json = JSON(value)
                                let jsonArray = json["book"].arrayValue
                                for bookObj in jsonArray{
                                    let _book = Book(_json: bookObj)
                                    self.bookArray.append(_book)
                                }
                                self.delegate?.getNewestBookSuccess(data: self.bookArray)
                            }
        }
    }
}
