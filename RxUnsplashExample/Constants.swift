//
//  Constants.swift
//  RealmApp
//
//  Created by Kauna Mohammed on 04/03/2018.
//  Copyright © 2018 Pavel Bogart. All rights reserved.
//

import Foundation

struct Constants {

    static let minimumCharacters = 3

    struct RealmConstants {

        static let MYINSTANCEADDRESS = ""
        static let AUTHURL  = URL(string: "https://\(MYINSTANCEADDRESS)")!
        static let REALMURL = URL(string: "realms://\(MYINSTANCEADDRESS)/Unsplash")!

    }

}
