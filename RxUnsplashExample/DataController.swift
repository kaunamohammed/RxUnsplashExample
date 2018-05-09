

import Foundation
import RealmSwift

class DataController {

  private let api: UnsplashClient

  init(api: UnsplashClient) {
    self.api = api
  }

    func fetch(query: String) {
        
        api.execute(query: query) { (posts) in
            
            let syncConfig = Realm.Configuration.init(syncConfiguration: SyncConfiguration(user: SyncUser.current!, realmURL: Constants.RealmConstants.REALMURL))
            let realm = try! Realm(configuration: syncConfig)
            let _ = posts.map { newPost in
        
                try! realm.write {
                  //  realm.deleteAll()
                    if let _ = realm.object(ofType: UnsplashResults.self, forPrimaryKey: "id") {
                        print("Not a new post")
                    } else {
                        
                        newPost.results.forEach {
                            let post = UnsplashResults()
                            post.id = $0.id
                            post.createdAt = $0.createdAt
                            post.urls = $0.urls
                            post.user = $0.user
                            realm.add(post)
                            
                        }
                        
                    }
                    
                    
                }
            
            }
            
        }
        
    }
    
}



