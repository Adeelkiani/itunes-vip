//
//  HomeInteractor.swift
//  Itunesvip
//
//  Created by Adeel kiani on 01/09/2022.
//

import Foundation

protocol HomeInteractorDelegate {
    func loadMediaTypes()
    func setSelectedMediaTypes(mediaTypes: [String])
}

class HomeInteractor: HomeInteractorDelegate {
    var presenter: HomePresenterDelegate?
    var selectedMediaTypes: [String] = []
    
    func loadMediaTypes() {
        
        guard let data = MediaType.parseJSONFile(fileName: MEDIA_FILE) else {
            print("Unable to load \(MEDIA_FILE) json file")
            return
        }
        
        presenter?.presentMediaTypes(mediaTypes: data.mediaTypes ?? [])
    }
    
    func setSelectedMediaTypes(mediaTypes: [String]) {
        self.selectedMediaTypes = mediaTypes
        presenter?.presentSelectedMediaTypes(mediaTypes: mediaTypes)
    }
}
