//
//  MainScreen.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 10/24/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit
import Stevia
import FSPagerView

class MainScreen: UIViewController {
    
    private lazy var authorDataArray : Array<Author> = []
    private let authorService = AuthorService()
    
    private lazy var newestBookDataArray : Array<Book> = []
    private let newestBookService = NewBookService()
    
    private lazy var mostLikedBookDataArray : Array<Book> = []
    private let mostLikedBookService = MostLikeBookService()
    
    private lazy var mostViewBookDataArray : Array<Book> = []
    private let mostViewBookService = MostViewBookService()
    
    private lazy var mainScrollView : MyScrollView = MyScrollView()
    
    private let pagerView = FSPagerView(frame: .zero)
//NOTE: container view 1 gồm có 1 label, 1 button, 1 collection view
    private lazy var containerView1 : ContainerView = ContainerView()
    
    private lazy var authorLabel : TitleLabel = TitleLabel("Tác giả")
    
    private lazy var allButton1 : AllButton = {
        let button = AllButton()
        button.addTarget(self, action: #selector(onTapAllButton1), for: .touchUpInside)
        return button
    }()
    
    private lazy var authorCollectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
//------------------------------------------------------------------------------------------------------------------------
//NOTE: container view 3 gồm có 1 label, 1 button, 1 collection
    private lazy var containerView3 : ContainerView = ContainerView()
    
    private lazy var hightlightLabel : TitleLabel = TitleLabel("Nổi bật")
    
    private lazy var allButton3 : AllButton = {
        let button = AllButton()
        button.addTarget(self, action: #selector(onTapAllButton3), for: .touchUpInside)
        return button
    }()
    
    private lazy var mostLikeCollectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
//------------------------------------------------------------------------------------------------------------------------
//NOTE: container view 2 gồm có 1 label, 1 button, 1 collection
    private lazy var containerView2 : ContainerView = ContainerView()
    
    private lazy var mostViewLabel : TitleLabel = TitleLabel("Xem nhiều")
    
    private lazy var allButton2 : AllButton = {
        let button = AllButton()
        button.addTarget(self, action: #selector(onTapAllButton2), for: .touchUpInside)
        return button
    }()
    
    private lazy var mostViewCollection : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
//------------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorService.delegate = self
        authorService.loadLimitAuthor(url: AUTHOR_LIMIT_URL)
        
        newestBookService.delegate = self
        newestBookService.getNewestBook(url: NEWEST_BOOK_URL)
        
        mostLikedBookService.delegate = self
        mostLikedBookService.getMostLikedBook(url: MOST_LIKED_LIMIT_BOOK)
        
        mostViewBookService.delegate = self
        mostViewBookService.getMostViewBook(url: MOST_VIEW_LIMIT_BOOK)
        
        setUpAuthorCollectionView()
        setUpMostLikeCollectionView()
        setUpMostViewCollectionVIew()
        setUpNavigation()
        setUpLayout()
    }
    
    deinit {
        print("main screen deinit")
    }
    
    fileprivate func setUpNavigation(){
    //NOTE: thay đổi font chữ, màu chữ và màu nền của navigation title
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                              NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 22)]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    //---------------------------------------------------------------------------------------------------
    //NOTE: thay đổi màu của right bar button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search"), style: .done, target: self, action: #selector(onTapSearch))
        self.navigationItem.rightBarButtonItem?.tintColor = .white
    //---------------------------------------------------------------------------------------------------
        self.navigationItem.title = "Trang chủ"
    }
    
    fileprivate func setUpAuthorCollectionView(){
        self.authorCollectionView.delegate = self
        self.authorCollectionView.dataSource = self
        self.authorCollectionView.register(AuthorCell.self, forCellWithReuseIdentifier: "Author")
        if let flowLayout = self.authorCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        self.authorCollectionView.backgroundColor = .white
        self.authorCollectionView.bounces = false
        self.authorCollectionView.showsHorizontalScrollIndicator = false
    }
    
    fileprivate func setUpMostLikeCollectionView(){
        self.mostLikeCollectionView.delegate = self
        self.mostLikeCollectionView.dataSource = self
        self.mostLikeCollectionView.register(BookCell.self, forCellWithReuseIdentifier: "most_like")
        if let flowLayout = self.mostLikeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        self.mostLikeCollectionView.backgroundColor = .white
        self.mostLikeCollectionView.bounces = false
        self.mostLikeCollectionView.showsHorizontalScrollIndicator = false
    }
    
    fileprivate func setUpMostViewCollectionVIew(){
        self.mostViewCollection.delegate = self
        self.mostViewCollection.dataSource = self
        self.mostViewCollection.register(BookCell.self, forCellWithReuseIdentifier: "most_view")
        if let flowLayout = self.mostViewCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        self.mostViewCollection.backgroundColor = .white
        self.mostViewCollection.bounces = false
        self.mostViewCollection.showsHorizontalScrollIndicator = false
    }
    
    fileprivate func setUpLayout(){
        view.sv(mainScrollView)
        mainScrollView.centerInContainer().size(100%)
        setUpFSPagerView()
        setUpContainerView3()
        setUpContainerView2()
        setUpContainerView1()
    }
    
    fileprivate func setUpFSPagerView(){
        mainScrollView.sv(pagerView)
        pagerView.centerHorizontally().width(100%).height(220).Top == mainScrollView.Top
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerView.transformer = FSPagerViewTransformer(type: .coverFlow)
        pagerView.itemSize = CGSize(width: 140, height: 200)
        pagerView.isInfinite = true
        pagerView.contentMode = .scaleAspectFit
        pagerView.backgroundColor = .white
        pagerView.automaticSlidingInterval = 3.0
        pagerView.interitemSpacing = 200
    }
    
    fileprivate func setUpContainerView1(){
        mainScrollView.sv(containerView1)
        containerView1.centerHorizontally().width(100%).height(210).Top == containerView2.Bottom + 10
        
        containerView1.sv(authorLabel, allButton1, authorCollectionView)
        authorLabel.Leading == containerView1.Leading + 20
        authorLabel.Top == containerView1.Top + 10
        allButton1.size(30).Top == containerView1.Top + 5
        allButton1.Trailing == containerView1.Trailing - 15
        authorCollectionView.Leading == authorLabel.Leading
        authorCollectionView.Trailing == containerView1.Trailing
        authorCollectionView.Top == authorLabel.Bottom + 10
        authorCollectionView.Bottom == containerView1.Bottom - 10
    }
    
    fileprivate func setUpContainerView2(){
        mainScrollView.sv(containerView2)
        containerView2.centerHorizontally().width(100%).height(260).Top == containerView3.Bottom + 10
        
        containerView2.sv(mostViewLabel, allButton2, mostViewCollection)
        
        mostViewLabel.Leading == containerView2.Leading + 20
        mostViewLabel.Top == containerView2.Top + 10
        
        allButton2.size(30).Top == containerView2.Top + 5
        allButton2.Trailing == containerView2.Trailing - 15
        
        mostViewCollection.Leading == mostViewLabel.Leading
        mostViewCollection.Trailing == containerView2.Trailing
        mostViewCollection.Top == mostViewLabel.Bottom + 10
        mostViewCollection.Bottom == containerView2.Bottom - 10
    }
    
    fileprivate func setUpContainerView3(){
        mainScrollView.sv(containerView3)
        containerView3.centerHorizontally().width(100%).height(260).Top == pagerView.Bottom + 10
        
        containerView3.sv(hightlightLabel, allButton3, mostLikeCollectionView)
        
        hightlightLabel.Leading == containerView3.Leading + 20
        hightlightLabel.Top == containerView3.Top + 10
        
        allButton3.size(30).Top == containerView3.Top + 5
        allButton3.Trailing == containerView3.Trailing - 15
        
        mostLikeCollectionView.Leading == hightlightLabel.Leading
        mostLikeCollectionView.Trailing == containerView3.Trailing
        mostLikeCollectionView.Bottom == containerView3.Bottom - 10
        mostLikeCollectionView.Top == hightlightLabel.Bottom + 10
    }
    
    @objc func onTapSearch(){
        self.navigationController?.pushViewController(SearchScreen(), animated: true)
    }
    
    @objc func onTapAllButton1(){
        print("all author")
        self.navigationController?.pushViewController(AllAuthorScreen(), animated: true)
    }
    
    @objc func onTapAllButton3(){
        print("all most liked book")
        self.navigationController?.pushViewController(AllMostLikeBookScreen(), animated: true)
    }
    
    @objc func onTapAllButton2(){
        print("all most view book")
        self.navigationController?.pushViewController(AllMostViewBookScreen(), animated: true)
    }
}

extension MainScreen : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == authorCollectionView {
            return self.authorDataArray.count
        }else if collectionView == mostViewCollection{
            return self.mostViewBookDataArray.count
        }else{
            return self.mostLikedBookDataArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == authorCollectionView{
            guard let cell = authorCollectionView.dequeueReusableCell(withReuseIdentifier: "Author", for: indexPath) as? AuthorCell else { fatalError() }
            cell.nameLabel.text = self.authorDataArray[indexPath.row].name
            cell.avatarImage.sd_setImage(with: URL(string: self.authorDataArray[indexPath.row].image), completed: nil)
            return cell
        }else if collectionView == mostViewCollection{
            guard let cell = mostViewCollection.dequeueReusableCell(withReuseIdentifier: "most_view", for: indexPath) as? BookCell else { fatalError() }
            cell.avatarImage.sd_setImage(with: URL(string: self.mostViewBookDataArray[indexPath.row].image), completed: nil)
            cell.nameLabel.text = self.mostViewBookDataArray[indexPath.row].name
            return cell
        }else{
            guard let cell = mostLikeCollectionView.dequeueReusableCell(withReuseIdentifier: "most_like", for: indexPath) as? BookCell else { fatalError() }
            cell.avatarImage.sd_setImage(with: URL(string: self.mostLikedBookDataArray[indexPath.row].image),
                                         completed: nil)
            cell.nameLabel.text = self.mostLikedBookDataArray[indexPath.row].name
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == authorCollectionView {
            return CGSize(width: 140, height: self.authorCollectionView.frame.size.height)
        }else if collectionView == mostViewCollection{
            return CGSize(width: 130, height: self.mostViewCollection.frame.size.height)
        }else{
            return CGSize(width: 130, height: self.mostLikeCollectionView.frame.size.height)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == authorCollectionView {
            let detailScreen = AuthorDetailScreen()
            detailScreen.id_author = self.authorDataArray[indexPath.row].id
            self.navigationController?.pushViewController(detailScreen, animated: true)
        }else if collectionView == mostViewCollection{
            let bookDetailScreen = BookDetailScreen()
            bookDetailScreen.id_book = self.mostViewBookDataArray[indexPath.row].id
            self.navigationController?.pushViewController(bookDetailScreen, animated: true)
        }else{
            let bookDetailScreen = BookDetailScreen()
            bookDetailScreen.id_book = self.mostLikedBookDataArray[indexPath.row].id
            self.navigationController?.pushViewController(bookDetailScreen, animated: true)
        }
    }
}

extension MainScreen : FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.newestBookDataArray.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.sd_setImage(with: URL(string: self.newestBookDataArray[index].image) ,
                                    completed: nil)
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let bookDetailScreen = BookDetailScreen()
        bookDetailScreen.id_book = self.newestBookDataArray[index].id
        self.navigationController?.pushViewController(bookDetailScreen, animated: true)
    }
}

extension MainScreen : AuthorServiceDelegate {
    func getAuthorSuccess(data: [Author]) {
        self.authorDataArray = data
        DispatchQueue.main.async {
            self.authorCollectionView.reloadData()
        }
    }
    
    func getAuthorFail(error: Error) {
        print(error)
    }
}

extension MainScreen : NewBookServiceDelegate {
    func getNewestBookSuccess(data: [Book]) {
        self.newestBookDataArray = data
        DispatchQueue.main.async {
            self.pagerView.reloadData()
        }
    }
    
    func getNewestBookFail(error: Error) {
        print(error)
    }
}

extension MainScreen : MostLikedBookDelegate {
    func getMostLikedBookSuccess(data: [Book]) {
        self.mostLikedBookDataArray = data
        DispatchQueue.main.async {
            self.mostLikeCollectionView.reloadData()
        }
    }
    
    func getMostLikedBookFail(error: Error) {
        print(error)
    }
}

extension MainScreen : MostViewBookDelegate {
    func getMostViewBookSuccess(data: [Book]) {
        self.mostViewBookDataArray = data
        DispatchQueue.main.async {
            self.mostViewCollection.reloadData()
        }
    }
    
    func getMostViewBookFail(error: Error) {
        print(error)
    }
}
