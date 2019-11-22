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
        self.setUpNavigation()
        self.setUpLayout()
        self.setUpCollectionView()
        SVProgressHUD.show()
        print(id_category!)
    }
    
//NOTE: Setup navigation
    fileprivate func setUpNavigation(){
        //NOTE: thay đổi font chữ, màu chữ và màu nền của navigation title
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                              NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 22)]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-2"), style: .done, target: self, action: #selector(onTapBack))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        //---------------------------------------------------------------------------------------------------
        self.navigationItem.title = self.name_category!
    }
//-----------------------------------------------------------------------------------------------------------------------
    
    fileprivate func setUpLayout(){
        view.sv(bookCollectionView)
        bookCollectionView.Top == view.safeAreaLayoutGuide.Top + 10
        bookCollectionView.Leading == view.Leading + 20
        bookCollectionView.Trailing == view.Trailing - 20
        bookCollectionView.Bottom == view.safeAreaLayoutGuide.Bottom - 20
    }
    
    fileprivate func setUpCollectionView(){
        self.bookCollectionView.delegate = self
        self.bookCollectionView.dataSource = self
        self.bookCollectionView.register(BookCell.self, forCellWithReuseIdentifier: "book")
        if let flowLayout = self.bookCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
        }
        self.bookCollectionView.backgroundColor = .white
        self.bookCollectionView.bounces = false
        self.bookCollectionView.showsVerticalScrollIndicator = false
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
        guard let cell = self.bookCollectionView.dequeueReusableCell(withReuseIdentifier: "book", for: indexPath) as? BookCell else { fatalError() }
        cell.avatarImage.sd_setImage(with: URL(string: self.bookArray[indexPath.row].image), completed: nil)
        cell.nameLabel.text = self.bookArray[indexPath.row].name
        return cell
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
        print("a")
    }
}
