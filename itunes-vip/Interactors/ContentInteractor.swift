//
//  ContentInteractor.swift
//  Itunesvip
//
//  Created by Adeel kiani on 02/09/2022.
//

import Foundation

protocol ContentInteractorDelegate {
    func loadContent()
}

class ContentInteractor: ContentInteractorDelegate {
    
    var presenter: ContentPresenterDelegate?
    
    var contentList: [String: [ContentPayload]]!
    
    init(content: [String: [ContentPayload]]) {
        self.contentList = content
    }

    func loadContent() {
        self.presenter?.presentContent(content: contentList)
    }
}
