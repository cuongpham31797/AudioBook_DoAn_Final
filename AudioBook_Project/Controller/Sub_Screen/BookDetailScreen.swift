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

class BookDetailScreen: UIViewController {
    
    private lazy var mainScrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.contentSize.height = 1200
        scroll.bounces = false
        scroll.showsVerticalScrollIndicator = true
        return scroll
    }()

//NOTE: view trên đầu bao gồm bìa sách, tên sách, tên tác giả, tên thể loại
    private lazy var firstView : UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9534785151, green: 0.9497569203, blue: 0.9563729167, alpha: 1)
        return view
    }()
    
    lazy var bookImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "thien_long_bat_bo")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var bookNameLabel : UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        label.text = "Ỷ thiên đồ long ký"
        label.textAlignment = .left
        return label
    }()
    
    lazy var authorLabel : UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.text = "Tác giả: Kim Dung"
        label.textAlignment = .left
        return label
    }()
    
    lazy var categoryLabel : UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.text = "Thể loại: Kiếm hiệp"
        label.textAlignment = .left
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
    private lazy var secondView : UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9534785151, green: 0.9497569203, blue: 0.9563729167, alpha: 1)
        return view
    }()
    
    private lazy var likeImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "like")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var likeLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "1234"
        return label
    }()
    
    private lazy var viewImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "view")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var viewLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "1234"
        return label
    }()
    
    private lazy var shareImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "share")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var shareLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Chia sẻ"
        return label
    }()
    
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
    private lazy var thirdView : UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9534785151, green: 0.9497569203, blue: 0.9563729167, alpha: 1)
        return view
    }()
    
    private lazy var introLabel : UILabel = {
        let label = UILabel()
        label.text = "Giới thiệu:"
        label.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.sizeToFit()
        return label
    }()
    
    private lazy var introTextView : UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.text = "Giới thiệu:Giới thiệu: Giới thiệu: Giới thiệu:Giới thiệu:Giới thiệu:Giới thiệu:Giới thiệu: Giới thiệu:Giới thiệu:Giới thiệu:Giới thiệu:Giới thiệu: Giới thiệu:Giới thiệu:Giới thiệu:Giới thiệu:Giới thiệu: Giới thiệu:Giới thiệu:Giới thiệu:Giới thiệu:Giới thiệu: Giới thiệu:Giới thiệu:Giới thiệu:Giới thiệu:Giới thiệu: Giới thiệu:Giới thiệu:Giới thiệu:Giới thiệu:    Giới thiệu:Giới thiệu:Giới thiệu:Giới thiệu:Giới thiệu: Giới thiệu:Giới thiệu:"
        textView.backgroundColor = .clear
        textView.showsVerticalScrollIndicator = false
        textView.bounces = false
        //textView.sizeToFit()
        return textView
    }()
//---------------------------------------------------------------------------------------------------
//NOTE: view thứ 4 gồm 1 collection view và 1 label
    private lazy var relationBookCollectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    private lazy var relationLabel : UILabel = {
        let label = UILabel()
        label.text = "Có thể bạn cũng thích"
        label.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.sizeToFit()
        return label
    }()
    
    private lazy var fourthView : UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9534785151, green: 0.9497569203, blue: 0.9563729167, alpha: 1)
        return view
    }()
//---------------------------------------------------------------------------------------------------
//NOTE: view thứ 5 gồm 1 table view, 1 label, 1 button
    private lazy var fifthView : UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9534785151, green: 0.9497569203, blue: 0.9563729167, alpha: 1)
        return view
    }()
    
    private lazy var commentLabel : UILabel = {
        let label = UILabel()
        label.text = "Nhận xét:"
        label.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var numberOfCommentLabel : UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 16)
        label.sizeToFit()
        label.textColor = .black
        label.alpha = 0.6
        return label
    }()
    
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
        view.backgroundColor = .white
        self.setUpNavigation()
        self.setUpLayout()
        self.setUpCollectionView()
    }
//NOTE: Setup navigation
    fileprivate func setUpNavigation(){
    //NOTE: thay đổi font chữ, màu chữ và màu nền của navigation title
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                              NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 22)]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    //---------------------------------------------------------------------------------------------------
        self.navigationItem.title = "Chi tiết truyện"
    }
//----------------------------------------------------------------------------------------------
//NOTE: layout cho view đầu tiên
    fileprivate func setUpLayoutForFirstView() {
        mainScrollView.sv(firstView)
        firstView.centerHorizontally().width(100%).height(250).Top == mainScrollView.Top
        
        firstView.sv(bookImage, bookNameLabel, categoryLabel, authorLabel, listenView)
        
        bookImage.Leading == firstView.Leading + 40
        bookImage.Top == firstView.Top + 10
        bookImage.Bottom == firstView.Bottom - 10
        bookImage.width(100)
        
        bookNameLabel.Top == bookImage.Top + 20
        bookNameLabel.Leading == bookImage.Trailing + 40
        
        authorLabel.Top == bookNameLabel.Bottom + 20
        authorLabel.Leading == bookNameLabel.Leading
        
        categoryLabel.Top == authorLabel.Bottom + 20
        categoryLabel.Leading == bookNameLabel.Leading
        
        listenView.sv(listenImage, listenLabel)
        listenImage.centerVertically().size(25).Leading == listenView.Leading + 10
        listenLabel.centerVertically().Leading == listenImage.Trailing + 10
        listenView.Leading == bookNameLabel.Leading
        listenView.width(150).height(45).Bottom == bookImage.Bottom - 20
    }
//----------------------------------------------------------------------------------------------
//NOTE: layout cho view thứ hai
    fileprivate func setUpLayoutForSecondView(){
        mainScrollView.sv(secondView)
        secondView.centerHorizontally().width(100%).height(80).Top == firstView.Bottom + 5
        
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
        thirdView.centerHorizontally().width(100%).height(230).Top == secondView.Bottom + 5
        thirdView.sv(introLabel, introTextView)
        introLabel.Top == thirdView.Top + 5
        introLabel.Leading == thirdView.Leading + 20
        
        introTextView.Leading == introLabel.Leading
        introTextView.Top == introLabel.Bottom + 5
        introTextView.Trailing == thirdView.Trailing - 15
        introTextView.height(200)
    }
//----------------------------------------------------------------------------------------------
//NOTE: layout cho view thứ tư
    fileprivate func setUpLayoutForFourthView(){
        mainScrollView.sv(fourthView)
        fourthView.centerHorizontally().width(100%).height(200).Top == thirdView.Bottom + 5
        
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
    }
//----------------------------------------------------------------------------------------------
//NOTE: setup relation collection view
    fileprivate func setUpCollectionView(){
//        relationBookCollectionView.delegate = self
//        relationBookCollectionView.dataSource = self
    }
//----------------------------------------------------------------------------------------------
    @objc func onTapLike(){
        print("like")
    }
    
    @objc func onTapShare(){
        print("Share")
    }
    
    @objc func onTapListen(){
        print("listen")
    }
    
    @objc func onTapViewAllComment(){
        print("view all comment")
    }
}

