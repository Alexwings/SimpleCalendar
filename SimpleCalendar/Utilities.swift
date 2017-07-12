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
    case monday = "Mon", tuesday = "Tue", wednesday = "Wed", thursday = "Thu", friday = "Fir", saturday = "Sat", sunday = "Sun", undefined = "undefined"
    static func weekday(fromNumber num: Int) -> Weekdays {
        switch num {
        case 1:
            return .sunday
        case 2:
            return .monday
        case 3:
            return .tuesday
        case 4:
            return .wednesday
        case 5:
            return .thursday
        case 6:
            return .friday
        case 7:
            return .saturday
        default:
            return .undefined
        }
    }
    func number() -> Int {
        switch self {
        case .sunday:
            return 1
        case .monday:
            return 2
        case .tuesday:
            return 3
        case .wednesday:
            return 4
        case .thursday:
            return 5
        case .friday:
            return 6
        case .saturday:
            return 7
        case .undefined:
            return -1
        }
    }
}

enum SelectionPositionState: Int{
    case start = 0, middle, end, undefined = -1;
}

class UIConfig {
    static let weekdays: [Weekdays] = [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
    
    static let shared = UIConfig()
    
    private init() {}
    
    static var selectedTextColor: UIColor = UIColor.white
    
    static var normalTextColor: UIColor = UIColor.blue
    
    static var cellSelectedColor: UIColor = UIColor(red: 82, green: 191, blue: 248)
    
    static var backgroundColor: UIColor = UIColor.white
    
    static var topBannerBackgroundColor: UIColor = UIColor(red: 102, green: 204, blue: 255)
    
    static var topBannerButtonColor: UIColor = UIColor.clear
    
    static var weekBannerColor: UIColor = UIColor(red: 13, green: 63, blue: 145)
    
    static var topBannerHeight: CGFloat = 40
    
    static var topBannerButtonWidth: CGFloat = 50
    
    static var weekdayBannerHeight: CGFloat = 30
    static var windowWidth: CGFloat = UIScreen.main.bounds.size.width
    
    func configureTopBanner(button: inout UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIConfig.topBannerButtonColor
        //TODO: set other parameters here
    }
}

class Utilities {
    static var formatter = DateFormatter()
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let r = red <= 255 ? red : 255
        let g = green <= 255 ? green : 255
        let b = blue <= 255 ? blue : 255
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
}
