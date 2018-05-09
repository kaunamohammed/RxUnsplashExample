//
//  LogInViewController.swift
//  MVVM
//
//  Created by Kauna Mohammed on 03/05/2018.
//  Copyright © 2018 NytCompany. All rights reserved.
//

import UIKit
import RealmSwift

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let creds = SyncCredentials.nickname("Kauna", isAdmin: true)
        SyncUser.logIn(with: creds, server: Constants.RealmConstants.AUTHURL) { (user, error) in
            
            if let _ = user {
                self.navigationController?.pushViewController(UnsplashViewController(), animated: true)
            } else if let _ = error {
                // handle error
            }
            
        }

    }
    
}
