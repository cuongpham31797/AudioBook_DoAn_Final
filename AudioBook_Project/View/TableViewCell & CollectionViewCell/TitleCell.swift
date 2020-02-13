//
//  TitleCell.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 2/7/20.
//  Copyright © 2020 Cuong  Pham. All rights reserved.
//

import UIKit
import Stevia

class TitleCell: UITableViewCell {
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.alpha = 0.5
        return label
    }()
    
    fileprivate func setUpLayoutForCell(){
        self.backgroundColor = #colorLiteral(red: 0.9534785151, green: 0.9497569203, blue: 0.9563729167, alpha: 1)
        self.sv(titleLabel)
        titleLabel.centerVertically().Leading == self.Leading + 15
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.setUpLayoutForCell()
    }

}
