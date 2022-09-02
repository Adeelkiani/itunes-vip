//
//  ContentPresenter.swift
//  Itunesvip
//
//  Created by Adeel kiani on 02/09/2022.
//

import Foundation

protocol ContentPresenterDelegate {
    func presentContent(content: [String: [ContentPayload]])
}

class ContentPresenter: ContentPresenterDelegate {
    
    var view: ContentViewDelegate?
    
    func presentContent(content: [String: [ContentPayload]]) {
        
        let sectionHeaders = Array(content.keys.map { $0 }).sorted(by: {$0 < $1})
        print(sectionHeaders)
        self.view?.contentLoaded(sectionHeaders: sectionHeaders, content: content)
    }
    
}
