//
//  ViewController.swift
//  SimpleCalendar
//
//  Created by Xinyuan's on 5/5/17.
//  Copyright © 2017 Xinyuan's. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    weak var viewModel: CalendarViewModel?
    
    lazy var calendar: CalendarView = { [unowned self] in
        let c = CalendarView()
        if let vm = self.viewModel as? UICollectionViewDelegate {
            c.grid.delegate = vm
        }
        return c
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = CalendarViewModel(withController: self)
        _ = self.calendar
    }
    override func viewDidAppear(_ animated: Bool) {
        calendar.frame = CGRect(x: 0.0, y: topLayoutGuide.length, width: view.bounds.width, height: UIConfig.mainFrameHeight)
        view.addSubview(calendar)
        super.viewDidAppear(animated)
    }

}

