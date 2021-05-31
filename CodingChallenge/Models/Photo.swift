//
//  Photo.swift
//  CodingChallenge
//
//  Created by Armaghan  on 5/30/21.
//

import Foundation

class Photo: Codable
{
    let albumID, id: Int
    let title: String
    let url, thumbnailURL: String
    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey
    {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
    // MARK: - init param
    init(albumID: Int, id: Int, title: String, url: String, thumbnailURL: String)
    {
        self.albumID = albumID
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailURL = thumbnailURL
    }
    
}
typealias Photos = [Photo]
