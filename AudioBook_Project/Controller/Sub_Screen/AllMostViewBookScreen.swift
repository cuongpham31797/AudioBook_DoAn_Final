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
        
        self.setUpNavigation()
        self.setUpLayout()
        self.setUpCollectionView()
    }
    
    fileprivate func setUpLayout(){
        view.sv(allMostViewCollectionView)
        allMostViewCollectionView.Leading == view.Leading + 15
        allMostViewCollectionView.Trailing == view.Trailing - 15
        allMostViewCollectionView.Top == view.safeAreaLayoutGuide.Top + 20
        allMostViewCollectionView.Bottom == view.safeAreaLayoutGuide.Bottom - 10
    }
    
    fileprivate func setUpCollectionView(){
        self.allMostViewCollectionView.delegate = self
        self.allMostViewCollectionView.dataSource = self
        self.allMostViewCollectionView.register(BookCell.self, forCellWithReuseIdentifier: "most_view")
        self.allMostViewCollectionView.backgroundColor = .white
        self.allMostViewCollectionView.bounces = false
        if let flowLayout = self.allMostViewCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
        }
        self.allMostViewCollectionView.showsVerticalScrollIndicator = false
    }
    
    deinit {
        print("all most view deinit")
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
        self.navigationItem.title = "Top xem nhiều"
    }
//----------------------------------------------------------------------------------------------
    @objc func onTapBack(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension AllMostViewBookScreen : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allMostViewDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.allMostViewCollectionView.dequeueReusableCell(withReuseIdentifier: "most_view", for: indexPath) as? BookCell else { fatalError() }
        cell.avatarImage.sd_setImage(with: URL(string: self.allMostViewDataArray[indexPath.row].image), completed: nil)
        cell.nameLabel.text = self.allMostViewDataArray[indexPath.row].name
        return cell
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
