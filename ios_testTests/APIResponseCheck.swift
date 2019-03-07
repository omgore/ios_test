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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testAPIRequest() {
        let e = expectation(description: "Alamofire")
        
        Alamofire.request(JSON_URL)
            .response { response in
                
                XCTAssertNotNil(response, "No response")
                
                XCTAssertEqual(response.response?.statusCode ?? 0, 200, "Status code not 200")
                
                XCTAssertNil(response.error, "Whoops, error \(response.error!.localizedDescription)")
                
                e.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
}
