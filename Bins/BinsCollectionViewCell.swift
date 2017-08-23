//
//  BinsCollectionViewCell.swift
//  Bins
//
//  Created by Julian Weiss on 8/22/17.
//  Copyright © 2017 Julian Weiss. All rights reserved.
//

import UIKit

class BinsCollectionViewCell: UICollectionViewCell, ReusableView {
    static var reuseIdentifier: String = "BinsCollectionViewCellIdentifier"
    
    var bin: Bin? {
        didSet {
            if let validBin = bin {
                binNameLabel.text = validBin.name
            } else {
                binNameLabel.text = nil
            }
        }
    }
    
    let binNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.borderColor = UIColor(white: 1.0, alpha: 0.1).cgColor
        contentView.layer.borderWidth = 1.0
        
        binNameLabel.layer.cornerRadius = 6.0
        binNameLabel.layer.masksToBounds = true
        binNameLabel.backgroundColor = UIColor(white: 1.0, alpha: 0.85)
        binNameLabel.numberOfLines = 0
        binNameLabel.textColor = UIColor.black
        binNameLabel.textAlignment = .center
        binNameLabel.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightRegular)
        binNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(binNameLabel)
        
        let edgePadding = CGFloat(10.0)
        
        binNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: edgePadding).isActive = true
        binNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -edgePadding).isActive = true
        binNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: edgePadding).isActive = true
        binNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -edgePadding).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
