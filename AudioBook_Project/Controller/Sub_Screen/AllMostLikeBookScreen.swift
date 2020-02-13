//
//  AllMostLikeBookScreen.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 11/15/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit
import Stevia
import SDWebImage
import SVProgressHUD

class AllMostLikeBookScreen: UIViewController {
    
    private lazy var allMostLikeDataArray : Array<Book> = []
    private let mostLikeBookService = MostLikeBookService()
    
    private lazy var allMostLikeCollectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        SVProgressHUD.show()
        
        mostLikeBookService.delegate = self
        mostLikeBookService.getMostLikedBook(url: MOST_LIKED_ALL_BOOK)
        
        setUpNavigationController(viewController: self, title: "Top ưa thích") {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-2"), style: .done, target: self, action: #selector(onTapBack))
        }
        self.setUpLayout()
        setUpAllCollectionView()
    }
    
    fileprivate func setUpLayout(){
        view.sv(allMostLikeCollectionView)
        allMostLikeCollectionView.Leading == view.Leading + 15
        allMostLikeCollectionView.Trailing == view.Trailing - 15
        allMostLikeCollectionView.Top == view.safeAreaLayoutGuide.Top + 20
        allMostLikeCollectionView.Bottom == view.safeAreaLayoutGuide.Bottom - 10
    }
    
    fileprivate func setUpAllCollectionView(){
        setUpCollectionView(parent: self,
                            collectionView: allMostLikeCollectionView, scrollDirection: .vertical) {
              self.allMostLikeCollectionView.register(BookCell.self, forCellWithReuseIdentifier: BookCell.className)
        }
    }
    
    @objc func onTapBack(){
        self.navigationController?.popViewController(animated: true)
    }
} 

extension AllMostLikeBookScreen : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allMostLikeDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return allMostLikeCollectionView.customDequeReuseable(type: BookCell.self, indexPath: indexPath, handle: { (cell) in
            cell.avatarImage.sd_setImage(with: URL(string: self.allMostLikeDataArray[indexPath.row].image), completed: nil)
            cell.nameLabel.text = self.allMostLikeDataArray[indexPath.row].name
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bookDetailScreen = BookDetailScreen()
        bookDetailScreen.id_book = self.allMostLikeDataArray[indexPath.row].id
        self.navigationController?.pushViewController(bookDetailScreen, animated: true)
        print(self.allMostLikeDataArray.count)
    }
}

extension AllMostLikeBookScreen : MostLikedBookDelegate {
    func getMostLikedBookSuccess(data: [Book]) {
        self.allMostLikeDataArray = data
        DispatchQueue.main.async {
            self.allMostLikeCollectionView.reloadData()
            SVProgressHUD.dismiss()
        }
    }
    
    func getMostLikedBookFail(error: Error) {
        print(error)
    }
}
