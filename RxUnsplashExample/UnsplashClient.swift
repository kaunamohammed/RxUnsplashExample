//
//  UnsplashClient.swift
//  MVVM
//
//  Created by Kauna Mohammed on 06/05/2018.
//  Copyright © 2018 NytCompany. All rights reserved.
//

import RxSwift
import RealmSwift

class UnsplashClient {
    
    let apiKey = "YOUR UNSPLASH API KEY"
    let session = URLSession(configuration: URLSessionConfiguration.default)

    func execute(query: String, callback: @escaping ([Post]) -> Void) -> URLSessionDataTask {
        
        let encodedQuery = encode(query: query) ?? ""
        var request = URLRequest(url: URL(string: "https://api.unsplash.com/search/photos/?client_id=\(apiKey)&page=4&per_page=5&order_by=latest&query=\(encodedQuery)")!)

        request.httpMethod = "GET"
        request.addValue("Accept-Version", forHTTPHeaderField: "v1")
        
        let task = session.dataTask(with: request) { (data, response, error) in

            do {
                guard let data = data else {
                    print("Something wrong with the data")
                    
                    return }
                
                    let posts = try JSONDecoder().decode(Post.self, from: data)
                    callback([posts])
                
            } catch {
                print(error)

            }
            
        }
        
        task.resume()
        return task
    }

    
    private func encode(query: String) -> String? {
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.insert(charactersIn: " ")
        return query.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)?
            .replacingOccurrences(of: " ", with: "+")
    }

}

extension UnsplashClient: ReactiveCompatible {}
//extension Reactive where Base: UnsplashClient {
//
//    func execute(query: String) -> Observable<[Post]> {
//        return Observable<[Post]>.create { observer in
//
//            let request = self.base.execute(query: query, callback: { results in
//                
//                observer.onNext(results)
//            })
//
//            return Disposables.create {
//                request.cancel()
//            }
//            }.observeOn(MainScheduler.instance)
//
//    }
//
//}
