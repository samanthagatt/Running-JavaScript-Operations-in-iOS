//
//  JumboMessage.swift
//  Running JavaScript in iOS
//
//  Created by Samantha Gatt on 2/14/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import Foundation

/** The message that will be sent to the app through the JavaScript code
 
 Contains information about the progress of the operation
 */
struct JumboMessage: Decodable {
    /// Uniqe id of the operation this message is regarding
    let id: String
    /// The message as a string
    let message: String
    /// The progress as an integer
    let progress: Int?
    /// The state of the operation this emssage is regarding.
    let state: String?
}

/* JSON example
 {
     "id": String,
     "message": String,
     "progress": Number, // optional, depending on the value of message
     "state": String // optional, depending on the value of message
 }
 */
