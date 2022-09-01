//
//  HomeInteractor.swift
//  Itunesvip
//
//  Created by Adeel kiani on 01/09/2022.
//

import Foundation

protocol HomeInteractorDelegate {
    func loadMediaTypes()
}

class HomeInteractor {
  var presenter: HomePresenterDelegate?
}

extension HomeInteractor: HomeInteractorDelegate {
    func loadMediaTypes() {
        print("LOADING DATA")
        
        guard let data = MediaType.parseJSONFile(fileName: MEDIA_FILE) else {
            print("Unable to load \(MEDIA_FILE) json file")
         return
        }
        
        presenter?.presentData(mediaTypes: data.mediaTypes ?? [])
    }
}
