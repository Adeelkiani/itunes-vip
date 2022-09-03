//
//  ContentViewTests.swift
//  ItunesvipTests
//
//  Created by Adeel kiani on 03/09/2022.
//

import XCTest
@testable import Itunesvip

class ContentViewTests: XCTestCase {
    
    var sut: ContentViewController!
    var interactorSpy: ContentInteractorSpy!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ContentViewController()
        interactorSpy = ContentInteractorSpy()
    }
    
    // MARK: - Test Spy
    class ContentInteractorSpy: ContentInteractorDelegate {
        
        var contentList: [String: [ContentPayload]] = [:]

        func loadContent() {
            contentList["Album"] = []
            contentList["Book"] = []
        }
    }
    
    func testLoadingContent() {
        // Given
        sut.interactor = interactorSpy

        // When
        sut.loadContent()
        
        // Then
        XCTAssertNotNil(interactorSpy.contentList, "Content cannot be nil")
        XCTAssertTrue(!interactorSpy.contentList.isEmpty, "Content cannot be empty")
    }
    
    override func tearDownWithError() throws {
        sut = nil
        interactorSpy = nil
        try super.tearDownWithError()
    }
    
}
