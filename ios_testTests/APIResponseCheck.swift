//
//  APIResponseCheck.swift
//  ios_testTests
//
//  Created by Om Gore on 07/03/19.
//  Copyright © 2019 Om Gore. All rights reserved.
//

import XCTest
@testable import ios_test

import Alamofire

class APIResponseCheck: XCTestCase {

    var sut: UserContentAPI?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = UserContentAPI()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }


    func testAPIRequest() {
        
        let sut = self.sut
        
        let expect = XCTestExpectation(description: "callback")
        
        sut?.fetchContent(success: { (content, str) in
            expect.fulfill()
            
            XCTAssertNotNil(content, "No response")
            
        }, failure: { (error) in
            XCTAssertNil(error, "Whoops, error \(error.rawValue)")
        })
        
        wait(for: [expect], timeout: 3.1)
    }
    
}
