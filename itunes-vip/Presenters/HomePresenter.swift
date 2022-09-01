//
//  HomePresenter.swift
//  Itunesvip
//
//  Created by Adeel kiani on 01/09/2022.
//

import Foundation

protocol HomePresenterDelegate {
    func presentData(mediaTypes: [String])
}

class HomePresenter {
  var view: HomeViewDelegate?
}

extension HomePresenter: HomePresenterDelegate {
    func presentData(mediaTypes: [String]) {
        print("Presenting data")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.view?.setMediaTypes(mediaTypes: mediaTypes)
        }
    }
}
