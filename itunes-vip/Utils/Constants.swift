//
//  Constants.swift
//  Itunesvip
//
//  Created by Adeel kiani on 01/09/2022.
//

import Foundation
import UIKit

// PRODUCTION URL Constants
let API_URL = "https://itunes.apple.com"

let BASE_URL = API_URL

/// Creates the string representation of the poo with requested size.
///
/// - parameter term: search string
/// - parameter entity: album || artist || book || movie || musicVide || podcast || song
let API_SEARCH = "\(BASE_URL)/search"

let MEDIA_FILE = "mediaTypes"

enum HTTP_CODE: Int {
    case HTTP_200 = 200
    case HTTP_400 = 400
    case HTTP_500 = 500
    
}

enum MediaTypes: String {
case Album = "Album"
case Artist = "Artist"
case Book = "Book"
case Movie = "Movie"
case MusicVideo = "Music Video"
case Podcast = "Podcast"
case Song = "Song"
}
