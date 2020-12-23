//
//  User.swift
//  test-glade
//
//  Created by Allen Gu on 10/24/20.
//

public struct ProfileImage: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}

public struct User: Codable {
    var displayName: String?
    var email: String?
    var href: String?
    var id: String?
    var images: [ProfileImage]?
    var uri: String?
    var songs: [String]?
    var artists: [String]?
    var school: String?
    var description: String?
    var socials: [String: String]?


    
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case email
        case href
        case id
        case images
        case uri
        case songs
        case artists
        case school
        case description
        case socials
    }
}
