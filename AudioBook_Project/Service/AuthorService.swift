//
//  AuthorService.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 11/5/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol AuthorServiceDelegate : class {
    func getAuthorSuccess(data : [Author])
    func getAuthorFail(error : Error)
}

class AuthorService {
    private var authorArray : Array<Author> = []
    
    weak var delegate : AuthorServiceDelegate?
    
    func loadLimitAuthor(url : String){
        Alamofire.request(url,
                          method: .get,
                          parameters: nil,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { (response) in
                            switch response.result{
                            case .failure(let error):
                                self.delegate?.getAuthorFail(error: error)
                            case .success(let value):
                                let json = JSON(value)
                                let jsonArray = json["author"].arrayValue
                                for authorObj in jsonArray {
                                    let author = Author(_json: authorObj)
                                    self.authorArray.append(author)
                                }
                                self.delegate?.getAuthorSuccess(data: self.authorArray)
                            }
        }
    }
    
   
}
