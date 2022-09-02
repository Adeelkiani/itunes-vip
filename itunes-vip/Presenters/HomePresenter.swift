//
//  HomePresenter.swift
//  Itunesvip
//
//  Created by Adeel kiani on 01/09/2022.
//

import Foundation

protocol HomePresenterDelegate {
    func presentMediaTypes(mediaTypes: [MediaTypePayload])
    func presentSelectedMediaTypes(mediaTypes: [MediaTypePayload])
    func formatContent(mediaType: String, content: [ContentPayload])
    func presentError(error: String)
    func presentContent()
}

class HomePresenter: HomePresenterDelegate {
    var view: HomeViewDelegate?
    var formatContentList: [String: [ContentPayload]] = [:]
    
    func presentMediaTypes(mediaTypes: [MediaTypePayload]) {
        self.view?.setMediaTypes(mediaTypes: mediaTypes.sorted(by: {$0.title ?? "" < $1.title ?? ""}))
    }
    
    func presentSelectedMediaTypes(mediaTypes: [MediaTypePayload]) {
        if !mediaTypes.isEmpty {
            self.view?.setSelectedMediaTypes(mediaTypes: mediaTypes.sorted(by: {$0.title ?? "" < $1.title ?? ""}))
        } else {
            self.view?.setEmptyMediaView()
        }
    }
    
    func presentContent() {
        self.view?.contentDidLoaded(content: formatContentList)
    }
    
    func formatContent(mediaType: String, content: [ContentPayload]) {
        formatContentList[mediaType] = content
        print("Presenting  mediaType: \(mediaType) and content: \(content.count)")
    }
    
    func presentError(error: String) {
        self.view?.contentDidFailed(error: error)
    }
}
