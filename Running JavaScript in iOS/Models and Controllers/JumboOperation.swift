//
//  JumboOperation.swift
//  Running JavaScript in iOS
//
//  Created by Samantha Gatt on 2/17/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import Foundation

struct JumboOperation: Equatable {
    /// Unique id for operation
    let id: String
    /// Progress of operation as an integer 0 - 100
    var progress: Float = 0
    /**
     Status of operation
     
     nil = operation not finished yet
     
     true = operation is done and reached 100
     
     false = operation is done and failed
     */
    var succeeded: Bool? = nil
    
    /// Index corresponding to the order of operations displayed in view
    let index: Int
}
