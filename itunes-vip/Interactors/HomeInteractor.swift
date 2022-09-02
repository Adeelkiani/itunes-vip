//
//  HomeInteractor.swift
//  Itunesvip
//
//  Created by Adeel kiani on 01/09/2022.
//

import Foundation

protocol HomeInteractorDelegate {
    func loadMediaTypes()
    func setSelectedMediaTypes(mediaTypes: [MediaTypePayload])
    func removeSelectedMedia(type: MediaTypePayload)
    func fetchContent(searchQuery: String)
}

class HomeInteractor: HomeInteractorDelegate {
    
    var presenter: HomePresenterDelegate?
    var selectedMediaTypes: [MediaTypePayload] = []
    
    func loadMediaTypes() {
        
        guard let data = MediaType.parseJSONFile(fileName: MEDIA_FILE) else {
            print("Unable to load \(MEDIA_FILE) json file")
            return
        }
        
        presenter?.presentMediaTypes(mediaTypes: data.mediaTypes ?? [])
    }
    
    func setSelectedMediaTypes(mediaTypes: [MediaTypePayload]) {
        self.selectedMediaTypes = mediaTypes
        presenter?.presentSelectedMediaTypes(mediaTypes: mediaTypes)
    }
    
    func removeSelectedMedia(type: MediaTypePayload) {
        self.selectedMediaTypes.removeAll(where: {$0 == type})
        presenter?.presentSelectedMediaTypes(mediaTypes: selectedMediaTypes)
    }
    
    func fetchContent(searchQuery: String) {
        
        let dispatchGroup = DispatchGroup()
        
        for mediaType in selectedMediaTypes {
            
            dispatchGroup.enter()
            
            let parameters = [
                "term": searchQuery,
                "entity": mediaType.parameter ?? ""
            ]
            
            NetworkService.shared.makeGetRequest(model: ContentModel.self, path: API_SEARCH, parameters: parameters) { [weak self] response in
                
                DispatchQueue.main.async {
                    
                    guard let _content = response.results else {
                        print("No record found")
                        return
                    }
                    
                    self?.presenter?.formatContent(mediaType: mediaType.title ?? "", content: _content)
                }
                dispatchGroup.leave()
                
            } onError: { [weak self] error in
                
                DispatchQueue.main.async {
                    self?.presenter?.presentError(error: error ?? "Something went wrong")
                }
                dispatchGroup.leave()
                
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.presenter?.presentContent()
        }
    }
}
