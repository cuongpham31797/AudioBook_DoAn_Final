//
//  UITableView + Extension.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 2/7/20.
//  Copyright © 2020 Cuong  Pham. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    class var className : String {
        return String(describing: self)
    }
}

extension UITableView {
    func customDequeReuseable <T : UITableViewCell> (type : T.Type, indexPath : IndexPath, handle : (T) -> Void) -> UITableViewCell{
        let cell = self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
        handle(cell)
        return cell
    }
}


extension UICollectionView {
    func customDequeReuseable <T : UICollectionViewCell> (type : T.Type, indexPath : IndexPath, handle : (T) -> Void) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as! T
        handle(cell)
        return cell
    }
}

public func setUpNavigationController(viewController : UIViewController , title : String, handle : () -> Void){
    handle()
    //NOTE: thay đổi font chữ, màu chữ và màu nền của navigation title
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                          NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 22)]
    viewController.navigationController?.navigationBar.titleTextAttributes = textAttributes
    viewController.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    viewController.navigationItem.leftBarButtonItem?.tintColor = .white
    viewController.navigationItem.rightBarButtonItem?.tintColor = .white
    viewController.navigationItem.title = title
}

public func setUpCollectionView(parent : UIViewController, collectionView : UICollectionView, scrollDirection : UICollectionView.ScrollDirection, handle : () -> Void){
    handle()
    collectionView.delegate = parent as? UICollectionViewDelegate
    collectionView.dataSource = parent as? UICollectionViewDataSource
    if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
        flowLayout.scrollDirection = scrollDirection
    }
    collectionView.backgroundColor = .clear
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.bounces = false
}

public func setUpTableView(parent : UIViewController, tableView : UITableView, isSelect : Bool, handle : () -> Void){
    handle()
    tableView.delegate = parent as? UITableViewDelegate
    tableView.dataSource = parent as? UITableViewDataSource
    tableView.showsHorizontalScrollIndicator = false
    tableView.backgroundColor = .clear
    tableView.bounces = false
    tableView.allowsSelection = isSelect
    tableView.tableFooterView = UIView()
}
