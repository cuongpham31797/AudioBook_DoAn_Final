//
//  AllAuthorScreen.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 11/5/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import Stevia
import UIKit
import SDWebImage
import SVProgressHUD
//import SCLAlertView

class AllAuthorScreen: UIViewController {
    
    private lazy var dataArray : Array<Author> = []
    private let service = AuthorService()
    
    private lazy var authorCollectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        SVProgressHUD.show()
        service.delegate = self
        service.loadLimitAuthor(url: AUTHOR_ALL_URL)
        
        setUpNavigationController(viewController: self, title: "Các tác giả") {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-2"), style: .done, target: self, action: #selector(onTapBack))
        }
        self.setUpLayout()
        self.setUpAllCollectionView()
    }
    
    deinit {
        print("all author deinit")
    }
    
    fileprivate func setUpAllCollectionView(){
        setUpCollectionView(parent: self,
                            collectionView: authorCollectionView,
                            scrollDirection: .horizontal) {
            self.authorCollectionView.register(AuthorCell.self, forCellWithReuseIdentifier: AuthorCell.className)
        }
    }
    
    fileprivate func setUpLayout(){
        view.sv(authorCollectionView)
        authorCollectionView.Leading == view.Leading + 15
        authorCollectionView.Trailing == view.Trailing - 15
        authorCollectionView.Top == view.safeAreaLayoutGuide.Top + 20
        authorCollectionView.Bottom == view.safeAreaLayoutGuide.Bottom - 10
    }
    
    @objc func onTapBack(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension AllAuthorScreen : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return authorCollectionView.customDequeReuseable(type: AuthorCell.self, indexPath: indexPath, handle: { (cell) in
            cell.nameLabel.text = self.dataArray[indexPath.row].name
            cell.avatarImage.sd_setImage(with: URL(string: self.dataArray[indexPath.row].image), completed: nil)
        })
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailScreen = AuthorDetailScreen()
        detailScreen.id_author = self.dataArray[indexPath.row].id
        self.navigationController?.pushViewController(detailScreen, animated: true)
    }
}

extension AllAuthorScreen : AuthorServiceDelegate {
    func getAuthorSuccess(data: [Author]) {
        self.dataArray = data
        DispatchQueue.main.async {
            self.authorCollectionView.reloadData()
            SVProgressHUD.dismiss()
        }
    }
    
    func getAuthorFail(error: Error) {
        print(error)
    }
    
    
}
