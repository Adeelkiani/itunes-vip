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
}

class HomePresenter: HomePresenterDelegate {
    var view: HomeViewDelegate?
    
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
}
