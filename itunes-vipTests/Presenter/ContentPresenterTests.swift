//
//  ContentPresenterTests.swift
//  ItunesvipTests
//
//  Created by Adeel kiani on 03/09/2022.
//

import XCTest
@testable import Itunesvip

class ContentPresenterTests: XCTestCase {

    var sut: ContentPresenter!
    var viewSpy: ContentViewSpy!
    
    override func setUpWithError() throws {
      try super.setUpWithError()
        sut = ContentPresenter()
        viewSpy = ContentViewSpy()
    }
    
    // MARK: - Test Spy
    class ContentViewSpy: ContentViewDelegate {
       
        var contentList: [String: [ContentPayload]] = [:]
        var sectionHeader: [String] = []
        
        func contentLoaded(sectionHeaders: [String], content: [String: [ContentPayload]]) {
            self.sectionHeader = sectionHeaders
            self.contentList = content
        }
    }
    
    func testSectionHeaderSorting() {
        
        // Given
        sut.view = viewSpy
        let content: [String: [ContentPayload]] = ["Album": [], "Book": [], "Movie": []]
        let unSortedHeaders: [String] = ["Movie", "Book", "Album"]
        
        // When
        sut.presentContent(content: content)
        let sortedHeaders = unSortedHeaders.sorted(by: {$0 < $1})
       
        // Then
        if sortedHeaders != viewSpy.sectionHeader {
            XCTAssert(false, "List should be sorted in ascending order")
        }
    }
    
    override func tearDownWithError() throws {
        sut = nil
        viewSpy = nil
        try super.tearDownWithError()
    }
}
