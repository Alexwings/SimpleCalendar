//
//  DayCell.swift
//  SimpleCalendar
//
//  Created by Xinyuan's on 5/5/17.
//  Copyright © 2017 Xinyuan's. All rights reserved.
//

import UIKit

class DayCell: UICollectionViewCell {
    
    var day: Day? {
        didSet {
            if let d = day {
                label.text = String(d.day)
            }
        }
    }
    let label: UILabel = {
        let l = UILabel()
        l.text = "01"
        l.textColor = UIConfig.normalTextColor
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
    
    override var isSelected: Bool{
        didSet {
            self.label.textColor = isSelected ? UIConfig.selectedTextColor : UIConfig.normalTextColor
            self.contentView.backgroundColor = isSelected ? UIConfig.cellSelectedColor : UIConfig.backgroundColor
            self.line.isHidden = !isSelected
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    private func setUpView(){
        contentView.addSubview(line)
        contentView.addSubview(label)
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        line.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        line.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        line.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        line.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
}
