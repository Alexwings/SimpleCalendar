//
//  TopBannerView.swift
//  SimpleCalendar
//
//  Created by Xinyuan's on 5/5/17.
//  Copyright © 2017 Xinyuan's. All rights reserved.
//

import UIKit

class TopBannerView: BaseView {
    
    let prevMonthButton: UIButton = {
        var btn = UIButton()
        let prevImage = UIImage(named: "back")!.withRenderingMode(.alwaysTemplate)
        btn.setImage(prevImage, for: .normal)
        btn.sizeToFit()
        btn.tintColor = UIColor.blue
        UIConfig.shared.configureTopBanner(button: &btn)
        return btn
        }() 
    
    let nextMonthButton: UIButton = {
        var btn = UIButton()
        let nextImage = UIImage(named: "next")!.withRenderingMode(.alwaysTemplate)
        btn.setImage(nextImage, for: .normal)
        btn.tintColor = UIColor.blue
        UIConfig.shared.configureTopBanner(button: &btn)
        return btn
    }()
    
    let topBannerLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIConfig.topBannerBackgroundColor
        label.text = "April, 26th"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = UIConfig.topBannerBackgroundColor
        addSubview(prevMonthButton)
        addSubview(topBannerLabel)
        addSubview(nextMonthButton)
        
        //Previous month Button configuration
        prevMonthButton.widthAnchor.constraint(equalTo: prevMonthButton.heightAnchor).isActive = true
        prevMonthButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        prevMonthButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        prevMonthButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        //Month Label configuration
        topBannerLabel.leadingAnchor.constraint(equalTo: prevMonthButton.trailingAnchor).isActive = true
        topBannerLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topBannerLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        //Next month Button configuration
        nextMonthButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nextMonthButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        nextMonthButton.widthAnchor.constraint(equalTo: nextMonthButton.heightAnchor).isActive = true
        nextMonthButton.leadingAnchor.constraint(equalTo: topBannerLabel.trailingAnchor).isActive = true
        nextMonthButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
