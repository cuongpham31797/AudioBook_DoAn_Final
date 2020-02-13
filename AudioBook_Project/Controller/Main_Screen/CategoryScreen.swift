//
//  CategoryScreen.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 10/24/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit
import Stevia
import SDWebImage
import SVProgressHUD

class CategoryScreen: UIViewController {
    
    private lazy var dataArray : Array<Category> = []
    private let service = CategoryService()
    
    var categoryCollectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        SVProgressHUD.show()
        service.delegate = self
        service.getCategory()
        setUpNavigationController(viewController: self, title: "Thể loại") {  }
        setUpLayout()
        setUpCollectionView(parent: self, collectionView: categoryCollectionView, scrollDirection: .vertical) {
            categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.className)
        }
    }
    
    deinit {
        print("category deinit")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        SVProgressHUD.dismiss()
    }
    
    fileprivate func setUpLayout(){
        view.sv(categoryCollectionView)
        categoryCollectionView.Leading == view.Leading + 15
        categoryCollectionView.Trailing == view.Trailing - 15
        categoryCollectionView.Top == view.safeAreaLayoutGuide.Top + 20
        categoryCollectionView.Bottom == view.safeAreaLayoutGuide.Bottom - 10
    }
    
}

extension CategoryScreen : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return categoryCollectionView.customDequeReuseable(type: CategoryCell.self, indexPath: indexPath, handle: { (cell) in
            cell.nameLabel.text = self.dataArray[indexPath.row].name
            cell.mainImage.sd_setImage(with: URL(string: self.dataArray[indexPath.row].image), completed: nil)
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextScreen = CategoryDetailScreen()
        nextScreen.id_category = self.dataArray[indexPath.row].id
        nextScreen.name_category = self.dataArray[indexPath.row].name
        self.navigationController?.pushViewController(nextScreen, animated: true)
    }
}

extension CategoryScreen : CategoryServiceDelegate {
    func getCategorySuccess(data: [Category]) {
        self.dataArray = data
        DispatchQueue.main.async {
            self.categoryCollectionView.reloadData()
            SVProgressHUD.dismiss()
        }
    }
    
    func getCategoryFail(error: Error) {
        print(error)
    }
}
