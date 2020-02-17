//
//  ViewController.swift
//  Running JavaScript in iOS
//
//  Created by Samantha Gatt on 2/14/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let messageController = JumboMessageController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageController.getJavaScript(success: { (javaScriptString) in
            
        }, failure: { (title, message) in
            
        })
    }


}

