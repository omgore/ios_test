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
    
    var sut:UserContentViewModel!
    var mockAPIService:MockApiService!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        mockAPIService = MockApiService()
        sut = UserContentViewModel(content: [], service: mockAPIService, title: "Title")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func test_FetchUserContentList() {
        sut.fetchContent()
        
        XCTAssert(mockAPIService.contentList.count > 0)
    }
    
    func test_FetchUserContentListFail() {
        let error = UserContentError.PermissionDenied
        
        sut.fetchContent()
        
        mockAPIService.fetchFail(error: error)
        
        XCTAssertEqual(sut.showError.value, error.rawValue)
    }
    
    func test_LoadingWhenFetching() {
        var showLoadingStatus = false
        let expect = XCTestExpectation(description: "Show Loading status updated")
        sut.showLoading.bind {
            showLoadingStatus = $0
            expect.fulfill()
        }
        
        sut.fetchContent()
        
        XCTAssertTrue( showLoadingStatus )
        
        mockAPIService!.fetchSuccess()
        
        XCTAssertFalse( showLoadingStatus )
        
        wait(for: [expect], timeout: 1.0)
    }
    
    func test_getCellViewModel() {
        let userContentList = MockApiService.makeMockContentList()
        mockAPIService.contentList = userContentList

        sut.fetchContent()
        mockAPIService.fetchSuccess()
        
        let indexPath = IndexPath(row: 1, section: 0)
        let testObjUserContent = userContentList[indexPath.row]
        
        let objUserContent = sut.contentList.value[indexPath.row]
        
        XCTAssertEqual(objUserContent.userContent.title, testObjUserContent.title)
        
    }
}


class MockApiService: ContentAPI {
    
    var contentList: [UserContent] = [UserContent]()
    var successClosure: (([UserContent], String) -> Void)!
    var failureClosure: ((UserContentError) -> Void)!

    
    func fetchContent(success: @escaping ([UserContent], String) -> Void, failure: @escaping (UserContentError) -> Void) {
        contentList = MockApiService.makeMockContentList()
        successClosure = success
        failureClosure = failure
    }
    
    func fetchSuccess() {
        successClosure(contentList, "Title")
    }
    
    func fetchFail(error: UserContentError) {
        failureClosure(error)
    }
    
    static func makeMockContentList() -> [UserContent]{
        return [
            UserContent(title: "Canada", description: "Canada is very beautiful place", imageHref: ""),
            UserContent(title: "India", description: "Inida is developing country", imageHref: ""),
            UserContent(title: "No title", description: "No subtitle", imageHref: "")]
    }
    
}
