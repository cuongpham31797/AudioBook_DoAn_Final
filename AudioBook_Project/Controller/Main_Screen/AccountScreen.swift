//
//  AccountScreen.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 10/24/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit
import Stevia

class AccountScreen: UIViewController {
    
//NOTE: setup view đầu tiên
    private lazy var firstView : ContainerView = ContainerView()
    
    private lazy var avatarImage : UIImageView = {
        let image : UIImageView = UIImageView()
        image.image = UIImage(named: "avatar")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var emailLabel : SubTitleLabel = SubTitleLabel("Email: email@gmail.com")
    
    private lazy var dateLabel : SubTitleLabel = SubTitleLabel("Ngày lập: ")
    
    private lazy var changePasswordButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.setTitle("Đổi mật khẩu", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(onTapChangePassword), for: .touchUpInside)
        return button
    }()
//---------------------------------------------------------------------------------------------------
//NOTE: setup view thứ hai
    private lazy var secondView : UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9534785151, green: 0.9497569203, blue: 0.9563729167, alpha: 1)
        return view
    }()
    
    private lazy var secondTitleLabel : UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = "Sách của tôi"
        return label
    }()
//---------------------------------------------------------------------------------------------------
//NOTE: setup view thứ ba
    private lazy var thirdView : ContainerView = ContainerView()
    
    private lazy var likeImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "da-thich")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var likeLabel : SubTitleLabel = SubTitleLabel("Đã thích")
//---------------------------------------------------------------------------------------------------
//NOTE: setup view thứ tư
    private lazy var fourthView : UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9534785151, green: 0.9497569203, blue: 0.9563729167, alpha: 1)
        return view
    }()
    
    private lazy var applicationLabel : UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = "Ứng dụng"
        return label
    }()
//---------------------------------------------------------------------------------------------------
//NOTE: setup view thứ năm
    private lazy var fifthView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapIntro))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private lazy var introLabel : SubTitleLabel = SubTitleLabel("Giới thiệu về ứng dụng")
    
    private lazy var introImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "thong-tin")
        image.contentMode = .scaleAspectFit
        return image
    }()
//---------------------------------------------------------------------------------------------------
//NOTE: setup view thứ sáu
    private lazy var sixthView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapShare))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private lazy var shareImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "chia-se")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var shareLabel : SubTitleLabel = SubTitleLabel("Chia sẻ ứng dụng")
//---------------------------------------------------------------------------------------------------
//NOTE: setup view thứ bảy
    private lazy var seventhView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapReview))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private lazy var reviewImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "gop-y")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var reviewLabel : SubTitleLabel = SubTitleLabel("Góp ý")
//---------------------------------------------------------------------------------------------------
//NOTE: setup view thứ tám
    private lazy var eighthView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapRating))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private lazy var ratingImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "danh-gia")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var ratingLabel : SubTitleLabel = SubTitleLabel("Đánh giá ứng dụng")
//---------------------------------------------------------------------------------------------------
//NOTE: setup view thứ chín
    private lazy var ninethView : UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9534785151, green: 0.9497569203, blue: 0.9563729167, alpha: 1)
        return view
    }()
//---------------------------------------------------------------------------------------------------
//NOTE: setup view thứ mười
    private lazy var tenthView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapLogout))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private lazy var logoutImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "dang-xuat")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var logoutLabel : SubTitleLabel = SubTitleLabel("Đăng xuất")
//---------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(view.frame.size.height)
        setUpNavigation()
        setUpLayout()
    }
    
    fileprivate func setUpNavigation(){
        //NOTE: thay đổi font chữ và màu chữ của navigation title
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                              NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 22)]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        //---------------------------------------------------------------------------------------------------
        self.navigationItem.title = "Cuong Pham"
    }
    
    fileprivate func setUpLayout(){
        
        secondTitleLabel.alpha = 0.4
        applicationLabel.alpha = 0.4
        setUpFirstView()
        setUpSecondView()
        setUpThirdView()
        setUpFourthView()
        setUpFifthView()
        setUpSixthView()
        setUpSeventhView()
        setUpEighthView()
        setUpNinethView()
        setUpTenthView()
    }
    
    fileprivate func setUpFirstView(){
        view.sv(firstView)
        firstView.centerHorizontally().width(100%).height(80).Top == view.safeAreaLayoutGuide.Top
        
        firstView.sv(avatarImage, emailLabel, dateLabel, changePasswordButton)
        avatarImage.size(60).Top == firstView.Top + 10
        avatarImage.Leading == firstView.Leading + 15
        emailLabel.Top == avatarImage.Top
        emailLabel.Leading == avatarImage.Trailing + 15
        dateLabel.Bottom == avatarImage.Bottom
        dateLabel.Leading == emailLabel.Leading
        changePasswordButton.width(110).height(30).Leading == dateLabel.Trailing + 20
        changePasswordButton.Bottom == avatarImage.Bottom
    }
    
    fileprivate func setUpSecondView(){
        view.sv(secondView)
        secondView.centerHorizontally().width(100%).height(50).Top == firstView.Bottom
        secondView.sv(secondTitleLabel)
        secondTitleLabel.centerVertically().Leading == secondView.Leading + 15
    }
    
    fileprivate func setUpThirdView(){
        view.sv(thirdView)
        thirdView.width(50%).Top == secondView.Bottom
        thirdView.Height == secondView.Height
        thirdView.Leading == view.Leading
        thirdView.sv(likeImage, likeLabel)
        likeImage.size(20).centerVertically().Leading == thirdView.Leading + 15
        likeLabel.centerVertically().Leading == likeImage.Trailing + 10
    }
    
    fileprivate func setUpFourthView(){
        view.sv(fourthView)
        fourthView.centerHorizontally().width(100%).Top == thirdView.Bottom
        fourthView.Height == secondView.Height
        fourthView.sv(applicationLabel)
        applicationLabel.centerVertically().Leading == fourthView.Leading + 15
    }
    
    fileprivate func setUpFifthView(){
        view.sv(fifthView)
        fifthView.Leading == view.Leading
        fifthView.width(50%).Top == fourthView.Bottom
        fifthView.Height == secondView.Height
        fifthView.sv(introLabel, introImage)
        introImage.centerVertically().Leading == fifthView.Leading + 15
        introLabel.centerVertically().Leading == introImage.Trailing + 10
    }
    
    fileprivate func setUpSixthView(){
        view.sv(sixthView)
        sixthView.Leading == fifthView.Leading
        sixthView.Height == fifthView.Height
        sixthView.Top == fifthView.Bottom
        sixthView.Width == fifthView.Width
        
        sixthView.sv(shareImage, shareLabel)
        shareImage.centerVertically().Leading == sixthView.Leading + 15
        shareLabel.centerVertically().Leading == shareImage.Trailing + 10
    }
    
    fileprivate func setUpSeventhView(){
        view.sv(seventhView)
        seventhView.Leading == fifthView.Leading
        seventhView.Height == fifthView.Height
        seventhView.Top == sixthView.Bottom
        seventhView.Width == fifthView.Width
        
        seventhView.sv(reviewImage, reviewLabel)
        reviewImage.centerVertically().Leading == seventhView.Leading + 15
        reviewLabel.centerVertically().Leading == reviewImage.Trailing + 10
    }
    
    fileprivate func setUpEighthView(){
        view.sv(eighthView)
        eighthView.Leading == fifthView.Leading
        eighthView.Height == fifthView.Height
        eighthView.Top == seventhView.Bottom
        eighthView.Width == fifthView.Width
        
        eighthView.sv(ratingImage, ratingLabel)
        ratingImage.centerVertically().Leading == eighthView.Leading + 15
        ratingLabel.centerVertically().Leading == ratingImage.Trailing + 10
    }
    
    fileprivate func setUpNinethView(){
        view.sv(ninethView)
        ninethView.centerHorizontally().width(100%)
        ninethView.Height == secondView.Height
        ninethView.Top == eighthView.Bottom
    }
    
    fileprivate func setUpTenthView(){
        view.sv(tenthView)
        tenthView.Top == ninethView.Bottom
        tenthView.Leading == fifthView.Leading
        tenthView.Width == fifthView.Width
        tenthView.Height == secondView.Height
        
        tenthView.sv(logoutLabel, logoutImage)
        logoutImage.centerVertically().Leading == tenthView.Leading + 15
        logoutLabel.centerVertically().Leading == logoutImage.Trailing + 10
    }
    
    @objc func onTapChangePassword(){
        print("change password")
    }
    
    @objc func onTapLiked(){
        print("liked")
    }
    
    @objc func onTapIntro(){
        print("intro")
    }
    
    @objc func onTapShare(){
        print("share")
    }
    
    @objc func onTapReview(){
        print("review")
    }
    
    @objc func onTapRating(){
        print("rating")
    }
    
    @objc func onTapLogout(){
        print("logout")
    }
}
