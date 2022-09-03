//
//  HomePresenterTests.swift
//  ItunesvipTests
//
//  Created by Adeel kiani on 03/09/2022.
//

import XCTest
@testable import Itunesvip

class HomePresenterTests: XCTestCase {

    var sut: HomePresenter!
    var viewSpy: HomeViewSpy!
    
    override func setUpWithError() throws {
      try super.setUpWithError()
        sut = HomePresenter()
        viewSpy = HomeViewSpy()
    }
    
    // MARK: - Test Spy
    class HomeViewSpy: HomeViewDelegate {
       
        var contentList: [String: [ContentPayload]] = [:]
        var mediaTypes: [MediaTypePayload] = []
        var selectedMediaTypes: [MediaTypePayload]?
        
        func setMediaTypes(mediaTypes: [MediaTypePayload]) {
            self.mediaTypes = mediaTypes
        }
        
        func setSelectedMediaTypes(mediaTypes: [MediaTypePayload]) {
            self.selectedMediaTypes = mediaTypes
        }
        
        func setEmptyMediaView() {
            
        }
        
        func contentDidLoaded(content: [String: [ContentPayload]]) {
            self.contentList = content
        }
        
        func contentDidFailed(error: String) {
            
        }
    }
    
    func testMediaTypesSorting() {
        
        // Given
        sut.view = viewSpy
        let mediaTypes: [MediaTypePayload] = [.init(title: "Book", parameter: "ebook"),
                                                 .init(title: "Album", parameter: "album"),
                                                 .init(title: "Movie", parameter: "movie")]
        
        // When
        sut.presentMediaTypes(mediaTypes: mediaTypes)
        let sortedTypes = mediaTypes.sorted(by: {$0.title ?? "" < $1.title ?? ""})
       
        // Then
        if sortedTypes != viewSpy.mediaTypes {
            XCTAssert(false, "List should be sorted in ascending order")
        }
    }
    
    func testSelectedMediaTypesSorting() {
        
        // Given
        sut.view = viewSpy
        let mediaTypes: [MediaTypePayload] = [.init(title: "Book", parameter: "ebook"),
                                                 .init(title: "Album", parameter: "album"),
                                                 .init(title: "Movie", parameter: "movie")]
        
        // When
        sut.presentSelectedMediaTypes(mediaTypes: mediaTypes)
        let sortedTypes = mediaTypes.sorted(by: {$0.title ?? "" < $1.title ?? ""})
       
        // Then
        if sortedTypes != viewSpy.selectedMediaTypes {
            XCTAssert(false, "List should be sorted in ascending order")
        }
    }
    
    func testContentLoaded() {
        
        // Given
        sut.view = viewSpy

        // When
        sut.formatContent(mediaType: "Book", content: [])
        sut.formatContent(mediaType: "Album", content: [])
        sut.formatContent(mediaType: "Movie", content: [])
        
        sut.presentContent()
       
        // Then
        XCTAssertTrue(!viewSpy.contentList.isEmpty, "Content list should not be empty")
    
    }
    
    override func tearDownWithError() throws {
        sut = nil
        viewSpy = nil
        try super.tearDownWithError()
    }
}
