//
//  AllMostViewBookScreen.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 11/15/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit
import Stevia
import SVProgressHUD

class AllMostViewBookScreen: UIViewController {
    
    private lazy var allMostViewDataArray : Array<Book> = []
    private let mostViewBookService = MostViewBookService()
    
    private lazy var allMostViewCollectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        SVProgressHUD.show()
        
        mostViewBookService.delegate = self
        mostViewBookService.getMostViewBook(url: MOST_VIEW_ALL_BOOK)
        
        setUpNavigationController(viewController: self, title: "Top xem nhiều") {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-2"), style: .done, target: self, action: #selector(onTapBack))
        }
        self.setUpLayout()
        self.setUpAllCollectionView()
    }
    
    fileprivate func setUpLayout(){
        view.sv(allMostViewCollectionView)
        allMostViewCollectionView.Leading == view.Leading + 15
        allMostViewCollectionView.Trailing == view.Trailing - 15
        allMostViewCollectionView.Top == view.safeAreaLayoutGuide.Top + 20
        allMostViewCollectionView.Bottom == view.safeAreaLayoutGuide.Bottom - 10
    }
    
    fileprivate func setUpAllCollectionView(){
        setUpCollectionView(parent: self,
                            collectionView: allMostViewCollectionView,
                            scrollDirection: .vertical) {
            self.allMostViewCollectionView.register(BookCell.self, forCellWithReuseIdentifier: BookCell.className)
        }
    }
    
    deinit {
        print("all most view deinit")
    }
    
    @objc func onTapBack(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension AllMostViewBookScreen : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allMostViewDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return allMostViewCollectionView.customDequeReuseable(type: BookCell.self, indexPath: indexPath, handle: { (cell) in
            cell.avatarImage.sd_setImage(with: URL(string: self.allMostViewDataArray[indexPath.row].image), completed: nil)
            cell.nameLabel.text = self.allMostViewDataArray[indexPath.row].name
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bookDetailScreen = BookDetailScreen()
        bookDetailScreen.id_book = self.allMostViewDataArray[indexPath.row].id
        self.navigationController?.pushViewController(bookDetailScreen, animated: true)
        print(self.allMostViewDataArray.count)
    }
}

extension AllMostViewBookScreen : MostViewBookDelegate {
    func getMostViewBookSuccess(data: [Book]) {
        self.allMostViewDataArray = data
        DispatchQueue.main.async {
            self.allMostViewCollectionView.reloadData()
            SVProgressHUD.dismiss()
        }
    }
    
    func getMostViewBookFail(error: Error) {
        print(error)
    }
    
    
}
