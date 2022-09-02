//
//  APIdata.swift
//  Itunesvip
//
//  Created by Adeel kiani on 01/09/2022.
//

import Foundation

// MARK: - ContentModel
struct ContentModel: Codable {
    let resultCount: Int?
    let results: [ContentPayload]?
}

// MARK: - Result
struct ContentPayload: Codable {
    let wrapperType: String?
    let kind: String?
    let artistId, collectionId, trackId: Int?
    let artistName, collectionName, trackName, collectionCensoredName: String?
    let trackCensoredName: String?
    let artistViewUrl, collectionViewUrl, trackViewUrl: String?
    let previewUrl: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String?
    let collectionPrice, trackPrice,trackRentalPrice, collectionHDPrice: Double?
    let releaseDate: String?
    let collectionExplicitness, trackExplicitness: String?
    let discCount, discNumber, trackCount, trackNumber: Int?
    let trackTimeMillis: Int?
    let country, contentAdvisoryRating: String?
    let currency: String?
    let primaryGenreName: String?
    let isStreamable: Bool?
    let collectionArtistName: String?
    let collectionArtistId: Int?
    let collectionArtistViewUrl: String?
    let trackHDPrice, trackHDRentalPrice: Double?
    let shortDescription, longDescription: String?
}
