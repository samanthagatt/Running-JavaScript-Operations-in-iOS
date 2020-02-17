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
    @discardableResult
    func addOperation(_ id: String = UUID().uuidString, index: Int) -> String {
        operations[id] = JumboOperation(id: id, index: index)
        return id
    }
    func getOperation(_ id: String) -> JumboOperation? {
        return operations[id]
    }
    @discardableResult
    func updateOperation(from message: JumboMessage) -> JumboOperation? {
        var op = getOperation(message.id)
        if let progress = message.progress {
            op?.progress = Float(progress) / 100
        }
        // If state property is provided by message set succeeded property of operation
        if let state = message.state {
            op?.succeeded = state == "success"
            if op?.succeeded == true {
                // Sets progress if succeeded since progress property is not provided by message once operation has been completed
                op?.progress = 1
            }
        }
        return op
    }
    func clearOperations() {
        operations = [:]
    }
}
