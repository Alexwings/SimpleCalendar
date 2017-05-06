//
//  WeekBannerView.swift
//  SimpleCalendar
//
//  Created by Xinyuan's on 5/5/17.
//  Copyright © 2017 Xinyuan's. All rights reserved.
//

import UIKit

class WeekBannerView: BaseView {
    
    lazy var labels: [UILabel] = {
        var arr: [UILabel] = []
        for day in UIConfig.weekdays {
            let l = UILabel()
            l.text = day.rawValue
            l.textColor = UIColor.white
            l.textAlignment = .center
            l.backgroundColor = UIColor.clear
            l.translatesAutoresizingMaskIntoConstraints = false
            //TODO additional label settings here
            
            arr.append(l)
        }
        return arr
    }()
    override func setupViews() {
        
        backgroundColor = UIConfig.weekBannerColor
        translatesAutoresizingMaskIntoConstraints = false
        
        let stack = UIStackView(arrangedSubviews: labels)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stack)
        
        stack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
