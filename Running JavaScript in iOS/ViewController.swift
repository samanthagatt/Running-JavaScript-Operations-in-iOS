//
//  ViewController.swift
//  Running JavaScript in iOS
//
//  Created by Samantha Gatt on 2/14/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    let messageController = JumboMessageController()
    lazy var messageView = view as? JumboMessageView

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Fetch JavaScript to inject into web view
        messageController.getJavaScript(success: { (javaScriptString) in
            
        }, failure: { (title, message) in
            self.showErrorAlert(title: title, message: message)
        })
    }

    // MARK: Methods
    func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel))
        present(alert, animated: true)
    }
}

