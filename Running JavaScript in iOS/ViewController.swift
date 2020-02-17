//
//  ViewController.swift
//  Running JavaScript in iOS
//
//  Created by Samantha Gatt on 2/14/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKScriptMessageHandler {
    
    // MARK: Properties
    let messageController = JumboMessageController()
    lazy var messageView = view as? JumboMessageView

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageView?.setup(self)
                
        // Fetch JavaScript to inject into web view
        // Not using weak self since this is the only view/view controller in app and should never be thrown away in memory
        messageController.getJavaScript(success: { (javaScript) in
            self.messageView?.webView?.evaluateJavaScript(javaScript) { _, error in
                if let error = error {
                    self.showErrorAlert(title: "Error evaluating JavaScript", message: "\(error)")
                    return
                }
                // As long as there is no error allow the user to start operations
                self.messageView?.startButton.isEnabled = true
            }
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

extension ViewController {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case "jumbo":
            // TODO: Handle script messages
            return
        default:
            NSLog("WKScriptMessage with name, \(message.name), not implemented")
        }
    }
}
