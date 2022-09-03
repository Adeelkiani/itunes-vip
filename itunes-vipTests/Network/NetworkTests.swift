//
//  NetworkTests.swift
//  ItunesvipTests
//
//  Created by Adeel kiani on 03/09/2022.
//

import XCTest
@testable import Itunesvip

class NetworkTests: XCTestCase {
    
    var selectedType: MediaTypePayload!
    
    override func setUpWithError() throws {
        selectedType = .init(title: "Album", parameter: "album")
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchContent() {
        // Given
        let parameters = [
            "term": "jackjohnson",
            "entity": selectedType.parameter ?? ""
        ]
        
        let expectations = self.expectation(description: "Response received")
        
        // When
        NetworkService.shared.makeGetRequest(model: ContentModel.self, path: API_SEARCH, parameters: parameters) { response in
            
            // Then
            XCTAssertNotNil(response.results)
            expectations.fulfill()
            
        } onError: { error in
            
            // Then
            XCTAssert(false, error ?? "Api failed")
            expectations.fulfill()
            
        }
        
        waitForExpectations(timeout: 10)
    }
    
}
