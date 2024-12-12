//
//  CatViewModel_Tests.swift
//  CatFact_Tests
//
//  Created by Clark David on 12/12/24.
//

import XCTest
@testable import CatFact

final class CatViewModel_Tests: XCTestCase {
    
    var viewModel: CatViewModel!
    var mockSession: URLSessionMock!
    
    override func setUp() {
            super.setUp()
            mockSession = URLSessionMock()
            viewModel = CatViewModel()
    }
    
    override func tearDown() {
            viewModel = nil
            mockSession = nil
            super.tearDown()
    }
    
    func testFetchCatData_Success() {
        let factResponse = """
            {
                "data": ["Cats have five toes on their front paws."]
            }
            """
        let imageResponse = """
            [
                {
                    "id": "abc",
                    "url": "https://cdn2.thecatapi.com/images/abc.jpg",
                    "width": 500,
                    "height": 600
                }
            ]
            """
        
        mockSession.mockResponses = [
            "https://meowfacts.herokuapp.com/": factResponse,
            "https://api.thecatapi.com/v1/images/search": imageResponse
        ]
        
        viewModel.fetchCatData()
        
        XCTAssertEqual(viewModel.catFact, "Cats have five toes on their front paws.")
        XCTAssertEqual(viewModel.catImageURL, "https://cdn2.thecatapi.com/images/abc.jpg")
        XCTAssertFalse(viewModel.showLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testFetchCatData_Failure() {
            
            mockSession.mockErrors = [
                "https://meowfacts.herokuapp.com/": NSError(domain: "TestError", code: 404, userInfo: nil),
                "https://api.thecatapi.com/v1/images/search": NSError(domain: "TestError", code: 500, userInfo: nil)
            ]

            viewModel.fetchCatData()

            XCTAssertNotNil(viewModel.errorMessage)
            XCTAssertEqual(viewModel.catFact, "")
            XCTAssertEqual(viewModel.catImageURL, "")
            XCTAssertFalse(viewModel.showLoading)
        }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
