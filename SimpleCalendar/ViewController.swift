//
//  ViewController.swift
//  SimpleCalendar
//
//  Created by Xinyuan's on 5/5/17.
//  Copyright © 2017 Xinyuan's. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var calendar: CalendarView = {
        let c = CalendarView()
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        calendar.frame = CGRect(x: 0.0, y: topLayoutGuide.length, width: view.bounds.width, height: UIConfig.mainFrameHeight)
        view.addSubview(calendar)
        super.viewDidAppear(animated)
    }

}

