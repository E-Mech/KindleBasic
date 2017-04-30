//
//  PageCell.swift
//  KindleBasic
//
//  Created by Hoe Zhan Hui on 4/29/17.
//  Copyright © 2017 VMax. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "SOME TEXTOME TEXT EXTOME TEXEXTOME TEXEXTOME TEXEXTOME TEX"
       // label.backgroundColor = .green
        
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //backgroundColor = .yellow
        
        
        addSubview(textLabel)
        
        //not preferred --> use autolayout instead
        //textLabel.frame = CGRect(x: , y: 0, width: 100, height: 200)
        
        textLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
