//
//  Codeable+Helper.swift
//  Itunesvip
//
//  Created by Adeel kiani on 01/09/2022.
//

import Foundation

extension Decodable {
    static func parseJSONFile(fileName: String) -> Self? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let output = try? JSONDecoder().decode(self, from: data)
        else {
            return nil
        }
        return output
    }
}
