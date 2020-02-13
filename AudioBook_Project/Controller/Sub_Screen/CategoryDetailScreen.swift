//
//  CategoryDetailScreen.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 11/21/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit
import Stevia
import Alamofire
import SwiftyJSON
import SDWebImage
import SVProgressHUD

class CategoryDetailScreen: UIViewController {
    
    var id_category : Int!
    var name_category : String!
    
    private lazy var bookArray : Array<Book> = []
    
    private lazy var bookCollectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
       // self.setUpNavigation()
        self.setUpLayout()
        self.setUpAllCollectionView()
        SVProgressHUD.show()
        print(id_category!)
        
        setUpNavigationController(viewController: self, title: self.name_category!) {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-2"), style: .done, target: self, action: #selector(self.onTapBack))
        }
    }
    
    deinit {
        print("Category Detail Screen deinit")
    }
    
    fileprivate func setUpLayout(){
        view.sv(bookCollectionView)
        bookCollectionView.Top == view.safeAreaLayoutGuide.Top + 10
        bookCollectionView.Leading == view.Leading + 20
        bookCollectionView.Trailing == view.Trailing - 20
        bookCollectionView.Bottom == view.safeAreaLayoutGuide.Bottom - 20
    }
    
    fileprivate func setUpAllCollectionView(){
        setUpCollectionView(parent: self,
                            collectionView: bookCollectionView,
                            scrollDirection: .vertical) {
            self.bookCollectionView.register(BookCell.self, forCellWithReuseIdentifier: BookCell.className)
        }
    }
    
    fileprivate func loadData(){
        guard let id = self.id_category else { return }
        let para : Parameters = [
            "id_category": id
        ]
        Alamofire.request(BOOK_BY_CATEGORY_URL,
                          method: .post,
                          parameters: para,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { (response) in
                            switch response.result{
                            case .failure(let error):
                                print(error)
                            case .success(let value):
                                let json = JSON(value)
                                let jsonArray = json["book"].arrayValue
                                for bookObj in jsonArray {
                                    let _book = Book(_json: bookObj)
                                    self.bookArray.append(_book)
                                }
                                DispatchQueue.main.async {
                                    self.bookCollectionView.reloadData()
                                    SVProgressHUD.dismiss()
                                }
                            }
        }
    }
    
    @objc func onTapBack(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension CategoryDetailScreen : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bookArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return bookCollectionView.customDequeReuseable(type: BookCell.self, indexPath: indexPath, handle: { (cell) in
            cell.avatarImage.sd_setImage(with: URL(string: self.bookArray[indexPath.row].image), completed: nil)
            cell.nameLabel.text = self.bookArray[indexPath.row].name
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextScreen = BookDetailScreen()
        nextScreen.id_book = self.bookArray[indexPath.row].id
        self.navigationController?.pushViewController(nextScreen, animated: true)
    }
}
