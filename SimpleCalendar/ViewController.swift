//
//  ViewController.swift
//  SimpleCalendar
//
//  Created by Xinyuan's on 5/5/17.
//  Copyright © 2017 Xinyuan's. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel: CalendarViewModel?
    
    var calendar: CalendarView = CalendarView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = CalendarViewModel(withController: self)
        self.calendar.grid.delegate = viewModel
    }
    override func viewDidAppear(_ animated: Bool) {
        view.addSubview(calendar)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        calendar.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor).isActive = true
        calendar.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor).isActive = true
        calendar.heightAnchor.constraint(equalToConstant: UIConfig.mainFrameHeight).isActive = true
        super.viewDidAppear(animated)
    }

}

