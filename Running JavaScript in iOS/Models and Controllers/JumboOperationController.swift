//
//  JumboMessageController.swift
//  Running JavaScript in iOS
//
//  Created by Samantha Gatt on 2/17/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import Foundation

class JumboOperationController {
    
    // MARK: Properties
    private var operations: [String: JumboOperation] = [:]
    
    // MARK: Methods
    func addOperation(_ id: String = UUID().uuidString) {
        operations[id] = JumboOperation(id: id)
    }
    func getOperation(_ id: String) -> JumboOperation? {
        return operations[id]
    }
    func clearOperations() {
        operations = [:]
    }
}
