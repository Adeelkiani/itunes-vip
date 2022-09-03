//
//  HomeViewTests.swift
//  ItunesvipTests
//
//  Created by Adeel kiani on 03/09/2022.
//

import XCTest
@testable import Itunesvip

class HomeViewTests: XCTestCase {
    
    var sut: HomeViewController!
    var interactorSpy: HomeInteractorSpy!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = HomeViewController()
        interactorSpy = HomeInteractorSpy()
    }
    
    // MARK: - Test Spy
    class HomeInteractorSpy: HomeInteractorDelegate {
    
        var contentList: [String: [ContentPayload]] = [:]
        var mediaTypes: MediaType?
        var selectedMediaTypes: [MediaTypePayload] = []
        
        func loadMediaTypes() {
            
            mediaTypes = MediaType.parseJSONFile(fileName: MEDIA_FILE)
        }
        
        func setSelectedMediaTypes(mediaTypes: [MediaTypePayload]) {
            self.selectedMediaTypes = mediaTypes
        }
        
        func removeSelectedMedia(type: MediaTypePayload) {
            self.selectedMediaTypes.removeAll(where: {$0 == type})
        }
        
        func fetchContent(searchQuery: String) {
            
        }
    }
    
    func testSetSelectedMediaType() {
        // Given
        sut.interactor = interactorSpy
        let selectedTypes: [MediaTypePayload] = [.init(title: "Album", parameter: "album"),
                                                 .init(title: "Movie", parameter: "movie"),
                                                 .init(title: "Book", parameter: "ebook")]
        // When
        sut.selectMediaTypes(mediaTypes: selectedTypes)
        
        // Then
        XCTAssertTrue(!interactorSpy.selectedMediaTypes.isEmpty, "Selected media types should not be nil")
    }
    
    func testRemoveSelectedMediaType() {
        // Given
        sut.interactor = interactorSpy
        let selectedTypes: [MediaTypePayload] = [.init(title: "Album", parameter: "album"),
                                                 .init(title: "Movie", parameter: "movie"),
                                                 .init(title: "Book", parameter: "ebook")]
        let toBeRemoved: MediaTypePayload = .init(title: "Album", parameter: "album")

        // When
        sut.selectMediaTypes(mediaTypes: selectedTypes)
        
        // Then
        XCTAssertTrue(interactorSpy.selectedMediaTypes.contains(where: {$0 == toBeRemoved}), "To be removed media type should be from the types provided")

        sut.removeSelectMediaType(mediaType: toBeRemoved)
        
        XCTAssertFalse(interactorSpy.selectedMediaTypes.contains(where: {$0 == toBeRemoved}), "Media type should be removed")
    }
    
    func testValidateSearchQuery() {
        // Given
        let searchQuery = "Adeel"
        
        XCTAssertTrue(!searchQuery.isEmpty, "Search querry cannot be empty")
        sut.fetchContent(searchQuery: searchQuery)
       
    }
    
    override func tearDownWithError() throws {
        sut = nil
        interactorSpy = nil
        try super.tearDownWithError()
    }
    
}
