//
//  Running_JavaScript_in_iOS_Tests.swift
//  Running JavaScript in iOS Tests
//
//  Created by Samantha Gatt on 2/17/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import XCTest

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

    func testAddOperationReturnsCorrectId() {
        let testOp = JumboOperation(id: "test1", index: 0)
        let testOpController = JumboOperationController()
        
        let opId = testOpController.addOperation(testOp.id, index: testOp.index)
        XCTAssertEqual(testOp.id, opId)
    }
}
