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
        setUpNavigation()
        setUpLayout()
        setUpCollectionView()
    }
    
    deinit {
        print("category deinit")
    }
    
    fileprivate func setUpNavigation(){
        //NOTE: thay đổi font chữ và màu chữ của navigation title
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                              NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 22)]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        //---------------------------------------------------------------------------------------------------
        self.navigationItem.title = "Thể loại"
    }
    
    fileprivate func setUpLayout(){
        view.sv(categoryCollectionView)
        categoryCollectionView.Leading == view.Leading + 15
        categoryCollectionView.Trailing == view.Trailing - 15
        categoryCollectionView.Top == view.safeAreaLayoutGuide.Top + 20
        categoryCollectionView.Bottom == view.safeAreaLayoutGuide.Bottom - 10
    }
    
    fileprivate func setUpCollectionView(){
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "Category")
        if let flowLayout = categoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
        }
        categoryCollectionView.backgroundColor = .white
        categoryCollectionView.showsVerticalScrollIndicator = false
        categoryCollectionView.bounces = false
    }
}

extension CategoryScreen : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "Category", for: indexPath) as? CategoryCell else { fatalError() }
        cell.nameLabel.text = self.dataArray[indexPath.row].name
        cell.mainImage.sd_setImage(with: URL(string: self.dataArray[indexPath.row].image), completed: nil)
        return cell
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
