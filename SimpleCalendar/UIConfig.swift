//
//  UIConfig.swift
//  SimpleCalendar
//
//  Created by Xinyuan's on 5/5/17.
//  Copyright © 2017 Xinyuan's. All rights reserved.
//

import Foundation
import UIKit

enum Weekdays: String {
    case monday = "Mon", tuesday = "Tue", wednesday = "Wed", thursday = "Thu", friday = "Fir", saturday = "Sat", sunday = "Sun"
}

class UIConfig {
    static let weekdays: [Weekdays] = [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
    
    static let shared = UIConfig()
    
    private init() {}
    
    static let selectedTextColor: UIColor = UIColor.white
    
    static let normalTextColor: UIColor = UIColor.blue
    
    static let cellSelectedColor: UIColor = UIColor.blue
    
    static let backgroundColor: UIColor = UIColor.white
    
    static let topBannerBackgroundColor: UIColor = UIColor(red: 102, green: 204, blue: 255)
    
    static let topBannerButtonColor: UIColor = UIColor.clear
    
    static let weekBannerColor: UIColor = UIColor(red: 13, green: 63, blue: 145)
    
    static let topBannerHeight: CGFloat = 40
    
    static let topBannerButtonWidth: CGFloat = 50
    
    static let mainFrameHeight: CGFloat = 280
    
    static let weekdayBannerHeight: CGFloat = 30
    
    func configureTopBanner(button: inout UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIConfig.topBannerButtonColor
        //TODO: set other parameters here
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let r = red <= 255 ? red : 255
        let g = green <= 255 ? green : 255
        let b = blue <= 255 ? blue : 255
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
}
