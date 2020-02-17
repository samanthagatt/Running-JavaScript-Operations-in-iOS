//
//  JumboMessageView.swift
//  Running JavaScript in iOS
//
//  Created by Samantha Gatt on 2/17/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import UIKit
import WebKit

class JumboOperationView: UIView {
    
    // MARK: IBOutlets
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberStepper: UIStepper!
    @IBOutlet weak var startButton: UIButton!
    
    // MARK: IBActions
    @IBAction func startOperations(_ sender: UIButton) {
        
    }
    
    // MARK: Properties
    var webView: WKWebView?
    
    // MARK: Methods
    /// Sets up web view. Should be called in view controllers viewDidLoad.
    func setup(_ messageHandler: WKScriptMessageHandler) {
        let config = WKWebViewConfiguration()
        config.userContentController = WKUserContentController()
        // Nothing will be displayed in webView so frame is set to .zero
        self.webView = WKWebView(frame: .zero, configuration: config)
        // Adds script message handler window.webkit.messageHandlers.jumbo
        // JavaScript code provided by Jumbo will call its .postMessage() function
        config.userContentController.add(messageHandler, name: "jumbo")
    }
}
