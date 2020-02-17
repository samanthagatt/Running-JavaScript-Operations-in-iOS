//
//  JumboMessageView.swift
//  Running JavaScript in iOS
//
//  Created by Samantha Gatt on 2/17/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import UIKit
import WebKit

class JumboMessageView: UIView {
    
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
    func setup(_ messageHandler: WKScriptMessageHandler) {
        let config = WKWebViewConfiguration()
        config.userContentController = WKUserContentController()
        self.webView = WKWebView(frame: .zero, configuration: config)
        config.userContentController.add(messageHandler, name: "jumbo")
    }
}
