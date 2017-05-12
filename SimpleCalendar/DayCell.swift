//
//  DayCell.swift
//  SimpleCalendar
//
//  Created by Xinyuan's on 5/5/17.
//  Copyright © 2017 Xinyuan's. All rights reserved.
//

import UIKit

class DayCell: UICollectionViewCell {
    let label: UILabel = {
        let l = UILabel()
        l.text = "01"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let line: UILabel = {
        let l = UILabel()
        l.backgroundColor = UIColor.black
        l.translatesAutoresizingMaskIntoConstraints = false
        l.isHidden = true
        return l
    }()
    
    var highlightColor = UIConfig.cellSelectedColor
    var normalColor = UIColor.white
    
    var highlightTextColor = UIConfig.selectedTextColor
    var normalTextColor = UIColor.white
    
    override var isSelected: Bool{
        didSet {
            if isSelected {
                label.textColor = normalTextColor
                backgroundColor = normalColor
                line.isHidden = true
            }else {
                label.textColor = highlightTextColor
                backgroundColor = highlightColor
                line.isHidden = false
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    private func setUpView(){
        addSubview(label)
        addSubview(line)
        
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        line.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        line.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        line.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
