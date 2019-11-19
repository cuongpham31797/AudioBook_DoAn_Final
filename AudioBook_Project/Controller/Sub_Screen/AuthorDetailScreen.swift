//
//  AuthorDetailScreen.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 11/6/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
// 

import UIKit
import Stevia
import Alamofire
import SwiftyJSON
import SVProgressHUD

class AuthorDetailScreen: UIViewController {
    
    var id_author : Int!
    
    private lazy var mainScrollView : MyScrollView = MyScrollView()
    
    private lazy var relateArray : Array<Book> = []
//NOTE: container view 1 chứa avatar
    private lazy var avatarImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 60
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var containerView1 : ContainerView = ContainerView()
//--------------------------------------------------------------------------------------------
//NOTE: conatainer view 2 chứa 1 label và 1 textview
    private lazy var containerView2 : ContainerView = ContainerView()
    
    private lazy var introLabel : TitleLabel = TitleLabel("Giới thiệu")
    
    private lazy var contentLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
//--------------------------------------------------------------------------------------------
//NOTE: container view 3 chứa 1 label và 1 collection view
    private lazy var containerView3 : ContainerView = ContainerView()
    
    private lazy var relateLabel : TitleLabel = TitleLabel("Các tác phẩm")
    
    private lazy var relateCollection : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
//--------------------------------------------------------------------------------------------
    override func viewWillAppear(_ animated: Bool) {
        print(id_author!)
        loadDetailAuthor()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        setUpNavigation()
        setUpLayout()
    }
    
    deinit {
        print("author detail deinit")
    }
    
    fileprivate func setUpLayout(){
        view.sv(mainScrollView)
        mainScrollView.centerInContainer().size(100%)
        setUpContainer1()
        setUpContainer2()
        setUpContainer3()
    }
    
    fileprivate func setUpContainer1(){
        mainScrollView.sv(containerView1)
        containerView1.centerHorizontally().width(100%).height(160).Top == mainScrollView.Top
        
        containerView1.sv(avatarImage)
        avatarImage.centerInContainer().size(120)
    }
    
    fileprivate func setUpContainer2(){
        mainScrollView.sv(containerView2)
        containerView2.centerHorizontally().width(100%).Top == containerView1.Bottom + 5
        
        containerView2.sv(contentLabel, introLabel)
        introLabel.Leading == containerView2.Leading + 20
        introLabel.Top == containerView2.Top + 5
        
        contentLabel.Trailing == containerView2.Trailing - 20
        contentLabel.Leading == containerView2.Leading + 20
        contentLabel.Top == introLabel.Bottom + 5
        contentLabel.Bottom == containerView2.Bottom - 10
    }
    
    fileprivate func setUpContainer3(){
        mainScrollView.sv(containerView3)
        containerView3.centerHorizontally().width(100%).Top == containerView2.Bottom + 5
        containerView3.Bottom == view.safeAreaLayoutGuide.Bottom
        
        containerView3.sv(relateLabel, relateCollection)
        
        relateLabel.Leading == containerView3.Leading + 20
        relateLabel.Top == containerView3.Top + 5
        
        relateCollection.Leading == relateLabel.Leading
        relateCollection.Trailing == containerView3.Trailing - 20
        relateCollection.Top == relateLabel.Bottom + 10
        relateCollection.Bottom == containerView3.Bottom - 10
        
        self.setUpCollectionView()
    }
    
    fileprivate func setUpCollectionView(){
        self.relateCollection.delegate = self
        self.relateCollection.dataSource = self
        self.relateCollection.register(BookCell.self, forCellWithReuseIdentifier: "book")
        
        self.relateCollection.backgroundColor = .clear
        if let flowLayout = self.relateCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
        }
        self.relateCollection.showsVerticalScrollIndicator = false
        self.relateCollection.bounces = false
    }
    
    fileprivate func setUpNavigation(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-2"), style: .done, target: self, action: #selector(onTapBack))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    fileprivate func loadDetailAuthor(){
        guard let id = id_author else { return }
        let para : Parameters = [
            "id_author" : id
        ]
        Alamofire.request(AUTHOR_BY_ID_URL,
                          method: .post,
                          parameters: para,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { (response) in
                            switch response.result{
                            case .failure(let error):
                                print(error)
                            case .success(let value):
                                let json = JSON(value)
                                print(json)
                                self.updateUI(json)
                            }
        }
        Alamofire.request(BOOKBY_AUTHOR_ID_URL,
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
                                    self.relateArray.append(_book)
                                    DispatchQueue.main.async {
                                        self.relateCollection.reloadData()
                                    }
                                }
                            }
        }
    }
    
    fileprivate func updateUI(_ source : JSON){
        self.navigationItem.title = source["author"]["name"].stringValue
        self.avatarImage.sd_setImage(with: URL(string: source["author"]["image"].stringValue), completed: nil)
        self.contentLabel.text = source["author"]["intro"].stringValue
        SVProgressHUD.dismiss()
    }
    
    @objc func onTapBack(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension AuthorDetailScreen : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.relateArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.relateCollection.dequeueReusableCell(withReuseIdentifier: "book", for: indexPath) as? BookCell else { fatalError() }
        cell.avatarImage.sd_setImage(with: URL(string: self.relateArray[indexPath.row].image), completed: nil)
        cell.nameLabel.text = self.relateArray[indexPath.row].name
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
        let nextScreen = BookDetailScreen()
        nextScreen.id_book = self.relateArray[indexPath.row].id
        self.navigationController?.pushViewController(nextScreen, animated: true)
    }
}
