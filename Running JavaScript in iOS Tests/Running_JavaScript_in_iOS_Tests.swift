//
//  Running_JavaScript_in_iOS_Tests.swift
//  Running JavaScript in iOS Tests
//
//  Created by Samantha Gatt on 2/17/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import XCTest
import WebKit

class Running_JavaScript_in_iOS_Tests: XCTestCase {
    
    func testJumboOperation() {
        let testId = "test1"
        let testProg: Float = 0.5
        let testSucceed: Bool? = nil
        let testIndex = 0
        let testOp = JumboOperation(id: testId, progress: testProg, succeeded: testSucceed, index: testIndex)
        
        XCTAssertEqual(testId, testOp.id)
        XCTAssertEqual(testProg, testOp.progress)
        XCTAssertEqual(testSucceed, testOp.succeeded)
        XCTAssertEqual(testIndex, testOp.index)
    }

    func testAddOperation() {
        let testOp = JumboOperation(id: "test1", index: 0)
        let testOpController = JumboOperationController()
        
        let opId = testOpController.addOperation(testOp.id, index: testOp.index)
        
        let notNilOp = testOpController.operations[opId]
        XCTAssertNotNil(notNilOp)
        guard let storedOp = notNilOp else { XCTFail(); return }
        XCTAssertEqual(testOp, storedOp)
        
        // Makes sure addOperation() returns the correct id string
        XCTAssertEqual(testOp.id, opId)
    }
    
    func testClearOperations() {
        let testOp = JumboOperation(id: "test1", index: 0)
        let testOpController = JumboOperationController()
        testOpController.addOperation(testOp.id, index: testOp.index)
        
        XCTAssertNotEqual(testOpController.operations, [:])
        testOpController.clearOperations()
        XCTAssertEqual(testOpController.operations, [:])
    }
    
    func testUpdateOperation() {
        let testMessage = JumboMessage(id: "test1", message: "", progress: 30, state: nil)
        let testOpController = JumboOperationController()
        
        testOpController.addOperation(testMessage.id, index: 0)
        let operation = testOpController.updateOperation(from: testMessage)
        guard let op = operation else { XCTFail(); return }
        XCTAssertEqual(testMessage.id, op.id)
        XCTAssertEqual(testMessage.progress, Int(op.progress * 100))
        let succeeded = testMessage.state == nil ? nil : testMessage.state == "success" ? true : false
        XCTAssertEqual(succeeded, op.succeeded)
    }
}
