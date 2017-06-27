//
//  TestViewController.swift
//  SimpleCalendar
//
//  Created by Xinyuan's on 6/27/17.
//  Copyright © 2017 Xinyuan's. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        self.present(calendar, animated: true, completion: nil)
        
    }
}
