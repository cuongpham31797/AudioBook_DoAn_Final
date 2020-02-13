//
//  BookDetailScreen.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 10/29/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//
//                              MÀN CHI TIẾT TRUYỆN
import UIKit
import Stevia
import Alamofire
import SwiftyJSON
import SDWebImage
import SVProgressHUD

class BookDetailScreen: UIViewController {
    
    lazy var subView : UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    var id_book : Int!
    private lazy var mainScrollView : MyScrollView = MyScrollView()
    private lazy var relateArray : Array<Book> = []

//NOTE: view trên đầu bao gồm bìa sách, tên sách, tên tác giả, tên thể loại
    private lazy var firstView : ContainerView = ContainerView()
    
    lazy var bookImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = UIView.ContentMode.scaleToFill
        return image
    }()
    
    lazy var bookNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 2
        label.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        return label
    }()
    
    lazy var authorLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    lazy var categoryLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var listenImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "listen")
        return image
    }()
    
    private lazy var listenLabel : UILabel = {
        let label = UILabel()
        label.text = "Nghe ngay"
        label.textColor = .white
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var listenView : UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        view.layer.cornerRadius = 10
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapListen))
        view.addGestureRecognizer(tap)
        return view
    }()
//---------------------------------------------------------------------------------------------------
//NOTE: view thứ hai bao gồm 3 nút like, lượt nghe, share
    private lazy var secondView : ContainerView = ContainerView()
    
    private lazy var likeImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "like")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var likeLabel : SubTitleLabel = SubTitleLabel("")
    
    private lazy var viewImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "view")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var viewLabel : SubTitleLabel = SubTitleLabel("")
    
    private lazy var shareImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "share")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var shareLabel : SubTitleLabel = SubTitleLabel("Chia sẻ")
    
    private lazy var likeView : UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapLike))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private lazy var shareView : UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapShare))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private lazy var viewView : UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private lazy var secondStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = NSLayoutConstraint.Axis.horizontal
        stack.distribution = UIStackView.Distribution.fillEqually
        stack.spacing = 90
        return stack
    }()
//---------------------------------------------------------------------------------------------------
//NOTE: view thứ 3 gồm 1 label và 1 textview giới thiệu truyện
    private lazy var thirdView : ContainerView = ContainerView()
    
    private lazy var introLabel : TitleLabel = TitleLabel("Giới thiệu")
    
    private lazy var contentLabel : UILabel = {
        let textView = UILabel()
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.numberOfLines = 0
        textView.sizeToFit()
        return textView
    }()
//---------------------------------------------------------------------------------------------------
//NOTE: view thứ 4 gồm 1 collection view và 1 label
    private lazy var relationBookCollectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    private lazy var relationLabel : TitleLabel = TitleLabel("Có thể bạn cũng thích")
    
    private lazy var fourthView : ContainerView = ContainerView()
//---------------------------------------------------------------------------------------------------
//NOTE: view thứ 5 gồm 1 table view, 1 label, 1 button
    private lazy var fifthView : ContainerView = ContainerView()
    
    private lazy var commentLabel : TitleLabel = TitleLabel("Nhận xét")
    
    lazy var numberOfCommentLabel : SubTitleLabel = SubTitleLabel("")
    
    private lazy var allCommentButton : UIButton = {
        let button = UIButton()
        button.setTitle("Tất cả >", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(onTapViewAllComment), for: .touchUpInside)
        return button
    }()
    
    private lazy var commentTableView : UITableView = UITableView()
//---------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        setUpNavigationController(viewController: self, title: "Chi tiết truyện") {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-2"), style: .done, target: self, action: #selector(onTapBack))
        }
        self.setUpLayout()
        self.setUpAllCollectionView()
        self.getData()
        print(self.id_book!)
    }
    
//NOTE: get data
    fileprivate func getData(){
        guard let id = self.id_book else { return }
        let para : Parameters = [
            "id_book" : id
        ]
        Alamofire.request(BOOK_BY_ID_URL,
                          method: .post,
                          parameters: para,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { (response) in
                            switch response.result {
                            case .failure(let error):
                                print(error)
                            case .success(let value):
                                let json = JSON(value)
                                self.updateUI(json)
                            }
        }
        Alamofire.request(BOOK_RELATE_URL,
                          method: .post,
                          parameters: para,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { (response) in
                            switch response.result {
                            case.failure(let error):
                                print(error)
                            case.success(let value):
                                let json = JSON(value)
                                let jsonArray = json["book"].arrayValue
                                for bookObj in jsonArray {
                                    let _book = Book(_json: bookObj)
                                    self.relateArray.append(_book)
                                }
                                DispatchQueue.main.async {
                                    self.relationBookCollectionView.reloadData()
                                }
                            }
        }
    }
    
    fileprivate func updateUI(_ source : JSON){
        self.bookImage.sd_setImage(with: URL(string: source["book"]["image"].stringValue), completed: nil)
        self.bookNameLabel.text = source["book"]["book_name"].stringValue
        self.categoryLabel.text = "Thể loại: " + source["book"]["category_name"].stringValue
        self.authorLabel.text = "Tác giả: " + source["book"]["author_name"].stringValue
        self.contentLabel.text = source["book"]["introduction"].stringValue
        self.viewLabel.text = String(source["book"]["views"].intValue)
        self.likeLabel.text = String(source["book"]["liked"].intValue)
        SVProgressHUD.dismiss()
    }
//----------------------------------------------------------------------------------------------
//NOTE: layout cho view đầu tiên
    fileprivate func setUpLayoutForFirstView() {
        mainScrollView.sv(firstView)
        firstView.centerHorizontally().width(100%).height(230).Top == mainScrollView.Top
        
        firstView.sv(bookImage, bookNameLabel, categoryLabel, authorLabel, listenView)
        
        bookImage.Leading == firstView.Leading + 20
        bookImage.Top == firstView.Top + 20
        bookImage.width(130).height(200)
        
        bookNameLabel.Top == bookImage.Top + 10
        bookNameLabel.Leading == bookImage.Trailing + 30
        bookNameLabel.Trailing == firstView.Trailing - 10
        
        authorLabel.Top == bookNameLabel.Bottom + 15
        authorLabel.Leading == bookNameLabel.Leading
        authorLabel.Trailing == firstView.Trailing - 10
        
        categoryLabel.Top == authorLabel.Bottom + 15
        categoryLabel.Leading == bookNameLabel.Leading
        categoryLabel.Trailing == firstView.Trailing - 10
        
        listenView.sv(listenImage, listenLabel)
        listenImage.centerVertically().size(25).Leading == listenView.Leading + 10
        listenLabel.centerVertically().Leading == listenImage.Trailing + 10
        listenView.Leading == bookNameLabel.Leading
        listenView.width(150).height(45).Bottom == bookImage.Bottom
    }
//----------------------------------------------------------------------------------------------
//NOTE: layout cho view thứ hai
    fileprivate func setUpLayoutForSecondView(){
        mainScrollView.sv(secondView)
        secondView.centerHorizontally().width(100%).height(60).Top == firstView.Bottom + 5
        
        likeView.sv(likeImage, likeLabel)
        likeImage.centerHorizontally().width(80%).height(60%).Top == likeView.Top
        likeLabel.centerHorizontally().Top == likeImage.Bottom + 5
        
        shareView.sv(shareImage, shareLabel)
        shareImage.centerHorizontally().width(80%).height(60%).Top == shareView.Top
        shareLabel.centerHorizontally().Top == shareImage.Bottom + 5
        
        viewView.sv(viewImage, viewLabel)
        viewImage.centerHorizontally().width(80%).height(60%).Top == viewView.Top
        viewLabel.centerHorizontally().Top == viewImage.Bottom + 5
        
        secondStackView.addArrangedSubview(likeView)
        secondStackView.addArrangedSubview(viewView)
        secondStackView.addArrangedSubview(shareView)
        
        secondView.sv(secondStackView)
        secondStackView.centerInContainer().size(70%)
        
    }
//----------------------------------------------------------------------------------------------
//NOTE: layout cho view thứ ba
    fileprivate func setUpLayoutForThirdView(){
        mainScrollView.sv(thirdView)
        thirdView.centerHorizontally().width(100%).Top == secondView.Bottom + 5
        thirdView.sv(introLabel, contentLabel)
        introLabel.Top == thirdView.Top + 5
        introLabel.Leading == thirdView.Leading + 20
        
        contentLabel.Leading == introLabel.Leading
        contentLabel.Trailing == thirdView.Trailing - 20
        contentLabel.Top == introLabel.Bottom + 5
        contentLabel.Bottom == thirdView.Bottom - 10
    }
//----------------------------------------------------------------------------------------------
//NOTE: layout cho view thứ tư
    fileprivate func setUpLayoutForFourthView(){
        mainScrollView.sv(fourthView)
        fourthView.centerHorizontally().width(100%).height(250).Top == thirdView.Bottom + 5
        
        fourthView.sv(relationLabel, relationBookCollectionView)
        relationLabel.Top == fourthView.Top + 5
        relationLabel.Leading == fourthView.Leading + 20
        
        relationBookCollectionView.Top == relationLabel.Bottom + 10
        relationBookCollectionView.Leading == relationLabel.Leading
        relationBookCollectionView.Trailing == fourthView.Trailing
        relationBookCollectionView.Bottom == fourthView.Bottom - 10
    }
//----------------------------------------------------------------------------------------------
//NOTE: layout cho view thư năm
    fileprivate func setUpLayoutForFifthView(){
        mainScrollView.sv(fifthView)
        fifthView.centerHorizontally().width(100%).height(250).Top == fourthView.Bottom + 5
        
        fifthView.sv(commentLabel, numberOfCommentLabel, commentTableView, allCommentButton)
        commentLabel.Top == fifthView.Top + 5
        commentLabel.Leading == fifthView.Leading + 20
        
        numberOfCommentLabel.Top == fifthView.Top + 5
        numberOfCommentLabel.Leading == commentLabel.Trailing + 10
        numberOfCommentLabel.alpha = 0.6
        
        commentTableView.Leading == commentLabel.Leading
        commentTableView.Top == commentLabel.Bottom + 10
        commentTableView.Trailing == commentLabel.Trailing - 15
        commentTableView.height(150)
        
        allCommentButton.width(70).height(35).centerHorizontally().Bottom == fifthView.Bottom - 10
    }
//----------------------------------------------------------------------------------------------
//NOTE: setup layout
    fileprivate func setUpLayout(){
        view.sv(mainScrollView)
        mainScrollView.centerInContainer().size(100%)
        setUpLayoutForFirstView()
        setUpLayoutForSecondView()
        setUpLayoutForThirdView()
        setUpLayoutForFourthView()
        setUpLayoutForFifthView()
        setUpAllCollectionView()
    }
//----------------------------------------------------------------------------------------------
//NOTE: setup relation collection view
    fileprivate func setUpAllCollectionView(){
        setUpCollectionView(parent: self,
                            collectionView: relationBookCollectionView,
                            scrollDirection: .horizontal) {
             relationBookCollectionView.register(BookCell.self, forCellWithReuseIdentifier: BookCell.className)
        }
    }
//----------------------------------------------------------------------------------------------
    @objc func onTapLike(){
        print("like")
    }
    
    @objc func onTapShare(){
        print("Share")
    }
    
//NOTE: khi tap vào nút listen, truyền id_book sang màn hình playing để chuẩn bị phát nhạc
    @objc func onTapListen(){
        print("listen")
        let playingScreen = self.tabBarController?.viewControllers?[2] as! PlayingScreen
        playingScreen.id_book = self.id_book!
    }
//----------------------------------------------------------------------------------------------
    @objc func onTapViewAllComment(){
        print("view all comment")
        
        
    }
    
    @objc func onTapBack(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension BookDetailScreen : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.relateArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return relationBookCollectionView.customDequeReuseable(type: BookCell.self, indexPath: indexPath, handle: { (cell) in
            cell.avatarImage.sd_setImage(with: URL(string: self.relateArray[indexPath.row].image), completed: nil)
            cell.nameLabel.text = self.relateArray[indexPath.row].name
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextScreen = BookDetailScreen()
        nextScreen.id_book = self.relateArray[indexPath.row].id
        self.navigationController?.pushViewController(nextScreen, animated: true)
    }
}
