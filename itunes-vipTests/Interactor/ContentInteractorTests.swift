//
//  ContentInteractorTests.swift
//  ItunesvipTests
//
//  Created by Adeel kiani on 03/09/2022.
//

import XCTest
@testable import Itunesvip

class ContentInteractorTests: XCTestCase {
    
    var sut: ContentInteractor!
    var presenterSpy: ContentPresenterSpy!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ContentInteractor(content: [
            "Book": [],
            "Album": []
        ])
        presenterSpy = ContentPresenterSpy()
    }
    
    // MARK: - Test Spy
    class ContentPresenterSpy: ContentPresenterDelegate {
        
        var contentList: [String: [ContentPayload]] = [:]

        func presentContent(content: [String: [ContentPayload]]) {
            contentList = content
        }
    }
    
    func testCreatingSectionHeaders() {
        // Given
        sut.presenter = presenterSpy
        
        // When
        sut.loadContent()
        let sectionHeaders = Array(presenterSpy.contentList.keys.map { $0 }).sorted(by: {$0 < $1})
        
        // Then
        XCTAssertNotNil(sectionHeaders, "Section headers not be nil")
        XCTAssertTrue(!sectionHeaders.isEmpty, "Section headers not be nil")
    }
    
    override func tearDownWithError() throws {
        sut = nil
        presenterSpy = nil
        try super.tearDownWithError()
    }
    
}
