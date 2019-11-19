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
        
        self.setUpNavigation()
        self.setUpLayout()
        setUpCollectionView()
    }
    
    fileprivate func setUpLayout(){
        view.sv(allMostLikeCollectionView)
        allMostLikeCollectionView.Leading == view.Leading + 15
        allMostLikeCollectionView.Trailing == view.Trailing - 15
        allMostLikeCollectionView.Top == view.safeAreaLayoutGuide.Top + 20
        allMostLikeCollectionView.Bottom == view.safeAreaLayoutGuide.Bottom - 10
    }
    
    fileprivate func setUpCollectionView(){
        self.allMostLikeCollectionView.delegate = self
        self.allMostLikeCollectionView.dataSource = self
        self.allMostLikeCollectionView.register(BookCell.self, forCellWithReuseIdentifier: "most_like")
        //self.allMostLikeCollectionView.bounces = false
        if let flowLayout = self.allMostLikeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
        }
        self.allMostLikeCollectionView.showsVerticalScrollIndicator = false
        self.allMostLikeCollectionView.backgroundColor = .white
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
        self.navigationItem.title = "Top ưa thích"
    }
//----------------------------------------------------------------------------------------------
    @objc func onTapBack(){
        self.navigationController?.popViewController(animated: true)
    }
} 

extension AllMostLikeBookScreen : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allMostLikeDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.allMostLikeCollectionView.dequeueReusableCell(withReuseIdentifier: "most_like", for: indexPath) as? BookCell else { fatalError() }
        cell.avatarImage.sd_setImage(with: URL(string: self.allMostLikeDataArray[indexPath.row].image), completed: nil)
        cell.nameLabel.text = self.allMostLikeDataArray[indexPath.row].name
        return cell
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
