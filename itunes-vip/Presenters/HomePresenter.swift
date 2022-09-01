//
//  HomePresenter.swift
//  Itunesvip
//
//  Created by Adeel kiani on 01/09/2022.
//

import Foundation

protocol HomePresenterDelegate {
    func presentMediaTypes(mediaTypes: [String])
    func presentSelectedMediaTypes(mediaTypes: [String])
}

class HomePresenter: HomePresenterDelegate {
    var view: HomeViewDelegate?
    
    func presentMediaTypes(mediaTypes: [String]) {
        self.view?.setMediaTypes(mediaTypes: mediaTypes)
    }
    
    func presentSelectedMediaTypes(mediaTypes: [String]) {
        if !mediaTypes.isEmpty {
            self.view?.setSelectedMediaTypes(mediaTypes: mediaTypes)
        } else {
            self.view?.setEmptyMediaView()
        }
    }
}
