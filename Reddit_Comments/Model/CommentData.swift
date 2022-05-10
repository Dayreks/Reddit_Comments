//
//  CommentStruct.swift
//  Reddit_Comments
//
//  Created by Bohdan on 29.04.2022.
//

import Foundation

//MARK: Json structs for uploading comments from the main url

struct CommentsList: Codable {
    
    let data: GeneralParams

    enum CodingKeys: String, CodingKey {
        case data
    }
    
}

struct GeneralParams: Codable {
    
    let children: [GeneralChilds]
    
    enum CodingKeys: String, CodingKey {
        case children
    }
    
}

struct GeneralChilds: Codable {
    
    let kind: String
    let comment: Comment
    
    enum CodingKeys: String, CodingKey {
        case comment = "data"
        case kind
    }
}

struct Comment: Codable {
    
    var username: String?
    var created: Double?
    var body: String?
    var rating: Int?
    var depth: Int?
    var permalink: String?
    var children: [String]?
    var parent_id: String?
    
    enum CodingKeys: String, CodingKey {
        case created, body, depth, permalink, children, parent_id
        case username = "author"
        case rating = "score"
    }
    
}

//MARK: Json struct for uploading children data

struct Json: Codable {
    let json: DataJson
}

struct DataJson: Codable {
    let data: Things
}

struct Things: Codable {
    let things: [GeneralChilds]
}



struct UIComment: Identifiable {
    var id = UUID()
    
    var username: String?
    var created: String?
    var body: String?
    var rating: Int?
    var depth: Int?
    var permalink: String?
    var children: [String]?
    var parent_id: String?
}
//MARK: Test case for comfortable testing

extension UIComment {
    static let testCase = UIComment(
        username: "UserTest",
        created: "",
        body: "Test comment about something very interesting, but no one really cares, lol",
        rating: 35,
        depth: 0,
        permalink: "Link.com",
        children: [])
}
