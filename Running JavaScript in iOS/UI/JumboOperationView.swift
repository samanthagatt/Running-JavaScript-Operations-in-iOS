//
//  JumboMessageView.swift
//  Running JavaScript in iOS
//
//  Created by Samantha Gatt on 2/17/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import UIKit
import WebKit

protocol ErrorAlertDelegate: class {
    func showErrorAlert(title: String, message: String)
}

class JumboOperationView: UIView {
    
    // MARK: Properties
    let operationController = JumboOperationController()
    /// Delegate that handles presenting error alerts to screen
    weak var errorAlertDelegate: ErrorAlertDelegate?
    var currentNumber = 4
    
    var webView: WKWebView?
    
    // MARK: IBOutlets
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberStepper: UIStepper!
    @IBOutlet weak var startButton: UIButton!
    /// An array of the 10 progress views
    @IBOutlet var progressViews: [UIProgressView]!
    
    // MARK: IBActions
    @IBAction func changeNumber(_ sender: UIStepper) {
        let prevNumber = currentNumber
        let number = Int(sender.value)
        // Updates class property
        currentNumber = number
        // Updates label
        numberLabel.text = "\(number)"
        // If user decremented hide last visible progress view
        if prevNumber > number {
            progressViews[prevNumber - 1].isHidden = true
        // If user incremented unhide first hidden progress view
        } else {
            progressViews[number - 1].isHidden = false
        }
    }
    @IBAction func startOperations(_ sender: UIButton) {
        // Clear operations from last time
        operationController.clearOperations()
        for i in 0..<currentNumber {
            operationController.addOperation(index: i)
        }
    }
    
    // MARK: Methods
    /// Sets up view. Should be called in view controllers viewDidLoad.
    func setup(errorAlertDelegate: ErrorAlertDelegate, messageHandler: WKScriptMessageHandler) {
        self.errorAlertDelegate = errorAlertDelegate
        
        // Sets up number stepper
        numberStepper.value = 4
        numberStepper.minimumValue = 1
        numberStepper.maximumValue = 10
        numberStepper.stepValue = 1
        
        // Sets up web view
        let config = WKWebViewConfiguration()
        config.userContentController = WKUserContentController()
        // Nothing will be displayed in webView so frame is set to .zero
        self.webView = WKWebView(frame: .zero, configuration: config)
        // Adds script message handler window.webkit.messageHandlers.jumbo
        // JavaScript code provided by Jumbo will call its .postMessage() function
        config.userContentController.add(messageHandler, name: "jumbo")
    }
}
