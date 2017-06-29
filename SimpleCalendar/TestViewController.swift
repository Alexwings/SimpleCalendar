//
//  TestViewController.swift
//  SimpleCalendar
//
//  Created by Xinyuan's on 6/27/17.
//  Copyright © 2017 Xinyuan's. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    var selectedDates: [Day] = [] {
        didSet {
            if !selectedDates.isEmpty {
                guard let first = selectedDates.first, let last = selectedDates.last else { return }
                if first == last {
                    label.text = "\(first.monthString), \(first.day) \(first.year)"
                }else {
                    label.text = "\(first.monthString), \(first.day) \(first.year) -- \(last.monthString), \(last.day) \(last.year)"
                }
            }else {
                label.text = "No Dates Selected"
            }
        }
    }
    
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.textAlignment = .center
        label.text = "No Dates Selected"
        label.textColor = UIColor.blue
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        let testButton = UIButton(frame: CGRect.zero)
        testButton.setTitle("Test", for: .normal)
        testButton.setTitleColor(UIColor.blue, for: .normal)
        testButton.addTarget(self, action: #selector(self.buttonClicked(_:)), for: .touchUpInside)
        testButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(testButton)
        testButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        testButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        testButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        testButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func buttonClicked(_ sender: UIButton) {
        
        let calendar = CalendarViewController()
        self.modalPresentationStyle = .popover
        calendar.delegate = self
        calendar.presentCalender(from: self, completionHandler: nil)
    }
}

extension TestViewController: SimpleCalendarCommunication {
    func willDismissCalendar(fromController calendar: UIViewController, withSelection selectedRange: [Day]) {
        self.selectedDates = selectedRange
    }
}
