//
//  BookService.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 11/21/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol BookServiceDelegate : class {
    func getBookSuccess(data : [Book])
    func getBookFail(error : Error)
}

class BookService {
    private lazy var dataArray : Array<Book> = []
    
    weak var delegate : BookServiceDelegate?
    
    func loadBook(){
        Alamofire.request(BOOK_URL,
                          method: .get,
                          parameters: nil,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { (response) in
                            switch response.result {
                            case .failure(let error):
                                self.delegate?.getBookFail(error: error)
                            case .success(let value):
                                let json = JSON(value)
                                let jsonArray = json["book"].arrayValue
                                for bookObj in jsonArray {
                                    let _book = Book(_json: bookObj)
                                    self.dataArray.append(_book)
                                }
                                self.delegate?.getBookSuccess(data: self.dataArray)
                            }
        }
    }
}
