//
//  JumboMessageView.swift
//  Running JavaScript in iOS
//
//  Created by Samantha Gatt on 2/17/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import UIKit
import WebKit

fileprivate let defaultTintColor = UIColor(red: 168/255, green: 152/255, blue: 206/255, alpha: 1)
fileprivate let successTintColor = UIColor(red: 170/255, green: 204/255, blue: 140/255, alpha: 1)
fileprivate let failureTintColor = UIColor(red: 174/255, green: 67/255, blue: 45/255, alpha: 1)

protocol ErrorAlertDelegate: class {
    func showErrorAlert(title: String, message: String)
}

class JumboOperationView: UIView {
    
    // MARK: Properties
    let operationController = JumboOperationController()
    /// Delegate that handles presenting error alerts to screen
    weak var errorAlertDelegate: ErrorAlertDelegate?
    var currentNumber = 5
    var numberOfComplete = 0
    
    var webView: WKWebView?
    
    // MARK: IBOutlets
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberStepper: UIStepper!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
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
        // Disable start button and number stepper until reset button is tapped
        startButton.isEnabled = false
        numberStepper.isEnabled = false
        resetButton.isEnabled = false
        
        for i in 0..<currentNumber {
            let id = operationController.addOperation(index: i)
            webView?.evaluateJavaScript("startOperation('\(id)')")
        }
    }
    @IBAction func resetOperations(_ sender: UIButton) {
        // Clear operations from last time
        operationController.clearOperations()
        // Reset number of complete back to 0
        numberOfComplete = 0
        // Enable start button and stepper again
        startButton.isEnabled = true
        numberStepper.isEnabled = true
        // Resets all progress views tint colors back to default
        for progressView in progressViews {
            progressView.setProgress(0, animated: true)
            progressView.tintColor = defaultTintColor
        }
        
    }
    
    // MARK: Methods
    /// Sets up view. Should be called in view controllers viewDidLoad.
    func setup(errorAlertDelegate: ErrorAlertDelegate, messageHandler: WKScriptMessageHandler) {
        self.errorAlertDelegate = errorAlertDelegate
        
        // Sets up number stepper
        numberStepper.value = 5
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
    func updateProgressView(from message: JumboMessage) {
        // Makes sure to Re-enable reset button once all operations are complete before returning from function
        defer {
            if numberOfComplete == currentNumber {
                resetButton.isEnabled = true
            }
        }
        
        guard let operation = operationController.updateOperation(from: message) else {
            // Not using alert to display error since this gets called repeatedly so often
            NSLog("No operation found with id: \(message.id)")
            return
        }
        let progressView = progressViews[operation.index]
        if let success = operation.succeeded {
            numberOfComplete += 1
            progressView.tintColor = success ? successTintColor : failureTintColor
            
            // Don't update progress
            if !success { return }
        }
        progressView.setProgress(operation.progress, animated: true)
    }
}
