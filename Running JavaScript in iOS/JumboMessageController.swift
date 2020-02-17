//
//  JumboMessageController.swift
//  Running JavaScript in iOS
//
//  Created by Samantha Gatt on 2/17/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import Foundation

fileprivate let url = URL(string: "https://jumboassetsv1.blob.core.windows.net/publicfiles/interview_bundle.js")

class JumboMessageController {
    
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
