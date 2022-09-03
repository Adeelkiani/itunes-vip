//
//  HomeInteractorTests.swift
//  ItunesvipTests
//
//  Created by Adeel kiani on 03/09/2022.
//

import XCTest
@testable import Itunesvip

class HomeInteractorTests: XCTestCase {
    
    var sut: HomeInteractor!
    var presenterSpy: HomePresenterSpy!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = HomeInteractor()
        presenterSpy = HomePresenterSpy()
    }
    
    // MARK: - Test Spy
    class HomePresenterSpy: HomePresenterDelegate {
        
        var formatContentList: [String: [ContentPayload]] = [:]
        var mediaTypes: [MediaTypePayload]?
        var selectedMediaTypes: [MediaTypePayload]?
        var mediaTypeName: String?
        var errorMessage: String = ""
        
        func presentMediaTypes(mediaTypes: [MediaTypePayload]) {
            self.mediaTypes = mediaTypes
        }
        
        func presentSelectedMediaTypes(mediaTypes: [MediaTypePayload]) {
            self.selectedMediaTypes = mediaTypes
        }
        
        func formatContent(mediaType: String, content: [ContentPayload]) {
            self.mediaTypeName = mediaType
            self.formatContentList[mediaType] = content
        }
        
        func presentError(error: String) {
            self.errorMessage = error
        }
        
        func presentContent() {
        }
    }
    
    func testLoadMediaTypes() {
        // Given
        sut.presenter = presenterSpy
        
        // When
        sut.loadMediaTypes()
        
        // Then
        XCTAssertNotNil(presenterSpy.mediaTypes, "Loading media types from local json file should not be nil")
    }
    
    func testSetSelectedMediaType() {
        // Given
        sut.presenter = presenterSpy
        let selectedTypes: [MediaTypePayload] = [.init(title: "Album", parameter: "album"),
                                                 .init(title: "Movie", parameter: "movie"),
                                                 .init(title: "Book", parameter: "ebook")]
        
        // When
        sut.setSelectedMediaTypes(mediaTypes: selectedTypes)
        
        // Then
        XCTAssertNotNil(presenterSpy.selectedMediaTypes, "Selected media type should not be nil if its selected")
    }
    
    func testSelectedMediaTypeShouldBeFromExistingTypes() {
        // Given
        sut.presenter = presenterSpy
        let selectedType: MediaTypePayload = .init(title: "Album", parameter: "album")
        
        // When
        sut.loadMediaTypes()
        sut.setSelectedMediaTypes(mediaTypes: [selectedType])
        
        // Then
        XCTAssertTrue(presenterSpy.mediaTypes?.contains(where: {$0 == selectedType}) ?? false, "Selected media type should be from the types provided")
    }
    
    func testRemoveSelectedMediaType() {
        // Given
        sut.presenter = presenterSpy
        let selectedTypes: [MediaTypePayload] = [.init(title: "Album", parameter: "album"),
                                                 .init(title: "Movie", parameter: "movie"),
                                                 .init(title: "Book", parameter: "ebook")]
        let toBeRemoved: MediaTypePayload = .init(title: "Album", parameter: "album")
        
        // When
        sut.setSelectedMediaTypes(mediaTypes: selectedTypes)
        
        // Then
        XCTAssertTrue(presenterSpy.selectedMediaTypes?.contains(where: {$0 == toBeRemoved}) ?? false, "To be removed media type should be from the types provided")
        
        sut.removeSelectedMedia(type: toBeRemoved)
        
        XCTAssertFalse(presenterSpy.selectedMediaTypes?.contains(where: {$0 == toBeRemoved}) ?? false, "Media type should be removed")
        
    }
    
    override func tearDownWithError() throws {
        sut = nil
        presenterSpy = nil
        try super.tearDownWithError()
    }
    
}
