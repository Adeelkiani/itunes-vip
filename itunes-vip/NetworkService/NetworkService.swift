//
//  NetworkService.swift
//  Itunesvip
//
//  Created by Adeel kiani on 01/09/2022.
//

import Foundation
import Alamofire

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    /// This function is used to call API with parameters in GET request.
    func makeGetRequest<T: Decodable> (model: T.Type, path: String, parameters: [String: Any], onResult: @escaping ((T) -> Void), onError: @escaping ((String?) -> Void)) {
        
        AF.request(path, method: .get, parameters: parameters).responseDecodable(of: T.self) { response in
            
            if let _error = response.error {
                onError(_error.localizedDescription)
                return
            }
            
            switch response.result {
            case .success(let post):
                DispatchQueue.main.async {
                    onResult(post)
                }
                print("Recieved post: \(post)")
                
            case .failure(let error):
                DispatchQueue.main.async {
                    onError(error.localizedDescription)
                }
            }
        }
    }
}
