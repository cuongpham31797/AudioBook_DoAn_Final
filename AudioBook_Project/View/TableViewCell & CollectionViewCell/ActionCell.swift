//
//  ActionCell.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 2/7/20.
//  Copyright © 2020 Cuong  Pham. All rights reserved.
//

import UIKit
import Stevia

protocol TapActionCell : class {
    func onTapCell(_index : IndexPath)
}

class ActionCell: UITableViewCell {
    
    weak var delegate : TapActionCell?
    
    var index : IndexPath?
    
    lazy var mainView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapView))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var mainImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var titleLabel : SubTitleLabel = SubTitleLabel(frame: .zero)
    
    @objc func onTapView(){
        self.delegate?.onTapCell(_index: index!)
    }
    
    fileprivate func setUpLayoutForCell(){
        self.sv(mainView)
        mainView.centerInContainer().width(100%).height(100%)
        mainView.sv(mainImage, titleLabel)
        mainImage.size(20).centerVertically().Leading == mainView.Leading + 15
        titleLabel.centerVertically().Leading == mainImage.Trailing + 10
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.setUpLayoutForCell()
    }

}
