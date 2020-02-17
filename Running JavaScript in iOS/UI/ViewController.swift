//
//  ViewController.swift
//  Running JavaScript in iOS
//
//  Created by Samantha Gatt on 2/14/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import UIKit
import WebKit

fileprivate let url = URL(string: "https://jumboassetsv1.blob.core.windows.net/publicfiles/interview_bundle.js")

class ViewController: UIViewController, WKScriptMessageHandler, ErrorAlertDelegate {
    
    // MARK: Properties
    lazy var operationView = view as? JumboOperationView

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        operationView?.setup(errorAlertDelegate: self, messageHandler: self)
                
        // Fetch JavaScript to inject into web view
        // Not using weak self since this is the only view/view controller in app and should never be thrown away in memory
        getJavaScript(success: { (javaScript) in
            self.operationView?.webView?.evaluateJavaScript(javaScript) { _, error in
                if let error = error {
                    self.showErrorAlert(title: "Error evaluating JavaScript", message: "\(error)")
                    return
                }
                // As long as there is no error allow the user to start operations
                self.operationView?.startButton.isEnabled = true
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
    /// Fetches javascript to inject into a `WKWebView`
    func getJavaScript(success: @escaping (String) -> Void, failure: @escaping (String, String) -> Void) {
        guard let url = url else {
            failure("An error occurred", "The url containing the javascript code is not working")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    failure("Error during data task", "\(error)")
                    return
                }
                guard let data = data else {
                    failure("No data", "No JavaScript code was returned from fetch")
                    return
                }
                guard let javaScript = String(data: data, encoding: .utf8) else {
                    NSLog("Error decoding JavaScript: \(data)")
                    failure("Error fetching JavaScript", "The data returned from the fetch could not be decoded into a string using `UTF-8`")
                    return
                }
                success(javaScript)
            }
        }.resume()
    }
}

// MARK: WKScriptMessageHandler implementation
extension ViewController {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // Not using an alert to show errors in this function because there's a potential for this to be called muliple times in a row
        // Instead using NSLog()
        switch message.name {
        case "jumbo":
            guard let bodyStr = message.body as? String,
                let body = bodyStr.data(using: .utf8) else {
                    NSLog("Error geting body data from script message: \(message)")
                    return
            }
            do {
                let jumboMessage = try JSONDecoder().decode(JumboMessage.self, from: body)
                operationView?.updateProgressView(from: jumboMessage)
            } catch {
                NSLog("Error decoding data from script message body into jumbo message")
                return
            }
        default:
            NSLog("WKScriptMessage with name, \(message.name), not implemented")
        }
    }
}
