//
//  Post.swift
//  RxUnsplashExample
//
//  Created by Kauna Mohammed on 08/05/2018.
//  Copyright © 2018 NytCompany. All rights reserved.
//

import RealmSwift

class Post: Decodable { 
    
    var results: [UnsplashResults] = []
    
}

class UnsplashResults: Object, Decodable {
        
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var createdAt: String = ""
    @objc dynamic var likes: Int = 0
    @objc dynamic var urls: URLS?
    @objc dynamic var user: User?
    
    enum CodingKeys: String, CodingKey {
       // case id
        case createdAt = "created_at"
        case likes
        case urls
        case user
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

class URLS: Object, Decodable {
    
    @objc dynamic var raw: String = ""
    
    enum CodingKeys: String, CodingKey {
        case raw
    }
    
}

class User: Object, Decodable {
    
    @objc dynamic var username: String = ""
    
    enum CodingKeys: String, CodingKey {
        case username
    }
    
}


