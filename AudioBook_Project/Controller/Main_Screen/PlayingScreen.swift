//
//  PlayingScreen.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 10/24/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit
import Stevia
import Alamofire
import SwiftyJSON
import SDWebImage

class PlayingScreen: UIViewController {
    
    var id_book : Int!
    
    var authorName : String!
    var categoryName : String!
    var bookName : String!
    var trapNumber : Int!
    
    var isPlaying : Bool = true
    
    private lazy var authorLabel : SubTitleLabel = SubTitleLabel()
    
    private lazy var bookNameLabel : UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var categoryLabel : SubTitleLabel = SubTitleLabel("Thể loại: ")
    
    private lazy var trapLabel : SubTitleLabel = SubTitleLabel("Phần: ")
    
    lazy var discImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 100
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var timeSlider : UISlider = {
        let slider = UISlider()
        slider.thumbTintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        slider.maximumTrackTintColor = .lightGray
        slider.minimumTrackTintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        slider.value = 0
        return slider
    }()
    
    private lazy var beginLabel : SubTitleLabel = SubTitleLabel("")
    
    private lazy var finishLabel : SubTitleLabel = SubTitleLabel("")
    
    private lazy var playButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "pause-2"), for: .normal)
        button.addTarget(self, action: #selector(onTapPlay), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "next"), for: .normal)
        button.addTarget(self, action: #selector(onTapNext), for: .touchUpInside)
        return button
    }()
    
    private lazy var previousButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "previous"), for: .normal)
        button.addTarget(self, action: #selector(onTapPrevious), for: .touchUpInside)
        return button
    }()
    
    private lazy var clockButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "clock"), for: .normal)
        button.addTarget(self, action: #selector(onTapClock), for: .touchUpInside)
        return button
    }()
    
    private lazy var listButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "list"), for: .normal)
        button.addTarget(self, action: #selector(onTapList), for: .touchUpInside)
        return button
    }()
    
    private lazy var controlStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = NSLayoutConstraint.Axis.horizontal
        stack.alignment = UIStackView.Alignment.center
        stack.distribution = UIStackView.Distribution.fillProportionally
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.trapNumber = 1
        
        //setUpNavigation()
        setUpNavigationController(viewController: self, title: self.bookName ?? "") { }
        setUpLayout()
        
        trapLabel.text = trapLabel.text! + String(self.trapNumber)
        
        self.finishLabel.text = "59:59"
        self.beginLabel.text = "00:01"
        
        self.tabBarItem.badgeValue = "N"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let id = self.id_book {
            self.updateUI(id)
        }else{
            return
        }
    }
    
//NOTE: update các UI như tên truyện, tên tác giả, tên thể loại, đĩa
    fileprivate func updateUI(_ id : Int){
        let para : Parameters = [
            "id_book" : id
        ]
        Alamofire.request("http://cuongpham.atwebpages.com/get_detail_book_by_id.php",
                          method: .post,
                          parameters: para,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { (response) in
                            switch response.result{
                            case .failure(_):
                                print("error")
                            case .success(let value):
                                let json = JSON(value)
                                self.bookNameLabel.text = json["book_detail"]["book_name"].stringValue
                                self.authorLabel.text = json["book_detail"]["author_name"].stringValue
                                self.categoryLabel.text = json["book_detail"]["category_name"].stringValue
                                self.discImage.sd_setImage(with: URL(string: json["book_detail"]["image"].stringValue), completed: nil)
                            }
        }
    }
    
    fileprivate func setUpLayout(){
        view.sv(bookNameLabel, authorLabel, categoryLabel, trapLabel, discImage, timeSlider, beginLabel, finishLabel, controlStackView, bookNameLabel)
        
        bookNameLabel.centerHorizontally().Top == view.safeAreaLayoutGuide.Top + 20
        bookNameLabel.Leading == view.Leading + 15
        bookNameLabel.Trailing == view.Trailing - 15
        authorLabel.centerHorizontally().Top == bookNameLabel.Bottom + 20
        categoryLabel.centerHorizontally().Top == authorLabel.Bottom + 20
        trapLabel.centerHorizontally().Top == categoryLabel.Bottom + 20
        
        discImage.centerHorizontally().size(200).Top == trapLabel.Bottom + 50
        timeSlider.centerHorizontally().width(90%).Top == discImage.Bottom + 20
        
        beginLabel.Leading == timeSlider.Leading
        beginLabel.Top == timeSlider.Bottom + 5
        beginLabel.alpha = 0.6
        
        finishLabel.Trailing == timeSlider.Trailing
        finishLabel.Top == timeSlider.Bottom + 5
        finishLabel.alpha = 0.6
        
        controlStackView.addArrangedSubview(clockButton)
        controlStackView.addArrangedSubview(previousButton)
        controlStackView.addArrangedSubview(playButton)
        controlStackView.addArrangedSubview(nextButton)
        controlStackView.addArrangedSubview(listButton)
        
        controlStackView.centerHorizontally().width(90%).height(45).Bottom == view.safeAreaLayoutGuide.Bottom - 20
    }
    
    @objc func onTapPlay(){
        print("play")
    
    }
    
    @objc func onTapNext(){
        print("next")
    }
    
    @objc func onTapPrevious(){
        print("previous")
    }
    
    @objc func onTapList(){
        print("list")
    }
    
    @objc func onTapClock(){
        print("clock")
    }
}
