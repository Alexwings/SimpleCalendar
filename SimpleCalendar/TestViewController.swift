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
    
    var allowMultiSelect: Bool = false
    
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
        let buttonLabel = UILabel(frame: .zero)
        let testSwitch = UISwitch(frame: .zero)
        let switchLabel = UILabel(frame: .zero)
        
        buttonLabel.text = "Press to open: "
        buttonLabel.textColor = UIColor.blue
        buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        switchLabel.text = "Enable to allow Multi-selection: "
        switchLabel.textColor = UIColor.blue
        switchLabel.translatesAutoresizingMaskIntoConstraints = false
        
        testButton.setTitle("Test", for: .normal)
        testButton.setTitleColor(UIColor.blue, for: .normal)
        testButton.addTarget(self, action: #selector(self.buttonClicked(_:)), for: .touchUpInside)
        testButton.translatesAutoresizingMaskIntoConstraints = false
        
        testSwitch.isOn = false
        testSwitch.addTarget(self, action: #selector(self.switchTurned(_:)), for: .valueChanged)
        testSwitch.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(testButton)
        view.addSubview(buttonLabel)
        view.addSubview(switchLabel)
        view.addSubview(testSwitch)
        testButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        testButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        testButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        testButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        buttonLabel.rightAnchor.constraint(equalTo: testButton.leftAnchor).isActive = true
        buttonLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        buttonLabel.bottomAnchor.constraint(equalTo: testButton.bottomAnchor).isActive = true
        testSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        testSwitch.topAnchor.constraint(equalTo: testButton.bottomAnchor, constant: 10).isActive = true
        switchLabel.leftAnchor.constraint(equalTo: buttonLabel.leftAnchor).isActive = true
        switchLabel.rightAnchor.constraint(equalTo: buttonLabel.rightAnchor).isActive = true
        switchLabel.bottomAnchor.constraint(equalTo: testSwitch.bottomAnchor).isActive = true
    }
    
    func switchTurned(_ sender: UISwitch) {
        self.allowMultiSelect = sender.isOn
    }
    
    func buttonClicked(_ sender: UIButton) {
        
        let calendar = CalendarViewController()
        calendar.allowMutiSelection = self.allowMultiSelect
        calendar.isFullView = true
        self.modalPresentationStyle = .pageSheet
        calendar.delegate = self
        calendar.presentCalender(from: self, completionHandler: nil)
    }
}

extension TestViewController: SimpleCalendarCommunication {
    func willDismissCalendar(fromController calendar: UIViewController, withSelection selectedRange: [Day]) {
        self.selectedDates = selectedRange
    }
}
