//
//  DayCell.swift
//  SimpleCalendar
//
//  Created by Xinyuan's on 5/5/17.
//  Copyright © 2017 Xinyuan's. All rights reserved.
//

import UIKit

class DayCell: UICollectionViewCell {
    let label = UILabel()
    
    var highlightColor = UIConfig.cellSelectedColor
    var normalColor = UIColor.white
    
    var highlightTextColor = UIConfig.selectedTextColor
    var normalTextColor = UIColor.white
    
    override var isSelected: Bool{
        didSet {
            if isSelected {
                label.textColor = normalTextColor
                backgroundColor = normalColor
            }else {
                label.textColor = highlightTextColor
                backgroundColor = highlightColor
            }
        }
    }
}
