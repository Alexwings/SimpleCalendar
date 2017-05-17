//
//  CanlendarView.swift
//  SimpleCalendar
//
//  Created by Xinyuan's on 5/5/17.
//  Copyright © 2017 Xinyuan's. All rights reserved.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
 
    func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}

class CalendarView: BaseView {
    
    let topBanner: TopBannerView = TopBannerView(frame: .zero)
    
    let weekdayBanner: WeekBannerView = WeekBannerView(frame: .zero)
    
    let grid: DayGridView = DayGridView(frame: .zero)
    
    override func setupViews() {
        
        addSubview(topBanner)
        topBanner.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topBanner.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topBanner.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topBanner.heightAnchor.constraint(equalToConstant: UIConfig.topBannerHeight).isActive = true
        
        addSubview(weekdayBanner)
        weekdayBanner.topAnchor.constraint(equalTo: topBanner.bottomAnchor).isActive = true
        weekdayBanner.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        weekdayBanner.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        weekdayBanner.heightAnchor.constraint(equalToConstant: UIConfig.weekdayBannerHeight).isActive = true
        
        addSubview(grid)
        grid.topAnchor.constraint(equalTo: weekdayBanner.bottomAnchor).isActive = true
        grid.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        grid.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        grid.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}
