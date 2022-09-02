//
//  MediaTypes.swift
//  Itunesvip
//
//  Created by Adeel kiani on 01/09/2022.
//

import Foundation

// MARK: - MediaType
struct MediaType: Codable {
    let mediaTypes: [MediaTypePayload]?
}
// MARK: - MediaType
struct MediaTypePayload: Codable, Equatable {
    let title, parameter: String?
}
