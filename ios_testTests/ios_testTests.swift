//
//  ios_testTests.swift
//  ios_testTests
//
//  Created by Om Gore on 07/03/19.
//  Copyright © 2019 Om Gore. All rights reserved.
//

import XCTest
@testable import ios_test

class ios_testTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserContentViewModel(){
        let objUserContent = UserContent(title: "Public", description: nil, imageHref: "imageName")
        let objUserContentViewModel = UserContentViewModel(objUserContent: objUserContent)
        
        if AppManager.sharedInstance.isEmptyString(string: objUserContent.title)
        {
            XCTAssertEqual(NO_TITLE, objUserContentViewModel.title)
        }
        else
        {
            XCTAssertEqual(objUserContent.title, objUserContentViewModel.title)
        }
        
        if AppManager.sharedInstance.isEmptyString(string: objUserContent.description)
        {
            XCTAssertEqual(NO_SUBTITLE, objUserContentViewModel.description)
        }
        else
        {
            XCTAssertEqual(objUserContent.description, objUserContentViewModel.description)
        }
        
        if AppManager.sharedInstance.isEmptyString(string: objUserContent.imageHref)
        {
            XCTAssertEqual(NO_IMGEREF, objUserContentViewModel.imageHref)
        }
        else
        {
            XCTAssertEqual(objUserContent.imageHref, objUserContentViewModel.imageHref)
        }
        
    }
    
}
