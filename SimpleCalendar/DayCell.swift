//
//  DayCell.swift
//  SimpleCalendar
//
//  Created by Xinyuan's on 5/5/17.
//  Copyright © 2017 Xinyuan's. All rights reserved.
//

import UIKit



class DayCell: UICollectionViewCell {
    
   internal var day: Day? {
        didSet {
            if let d = day {
                label.text = String(d.day)
            }
        }
    }
   internal let label: UILabel = {
        let l = UILabel()
        l.text = "01"
        l.textColor = UIConfig.normalTextColor
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    internal var selectedPosition: SelectionPositionState = .undefined {
        didSet {
            Utilities.animateCellSelection(at: selectedPosition, for: self)
        }
    }
    
    override var isSelected: Bool{
        didSet {
            self.label.textColor = isSelected ? UIConfig.selectedTextColor : UIConfig.normalTextColor
            let radius = self.contentView.bounds.size.width / 4
            self.contentView.layer.cornerRadius = self.isSelected ? radius : 0
            self.contentView.backgroundColor = self.isSelected ? UIConfig.cellSelectedColor : UIConfig.backgroundColor
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
        contentView.layer.masksToBounds = true
        contentView.addSubview(label)
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}
