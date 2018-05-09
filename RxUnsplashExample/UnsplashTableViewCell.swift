//
//  UnsplashTableViewCell.swift
//  MVVM
//
//  Created by Kauna Mohammed on 08/05/2018.
//  Copyright © 2018 NytCompany. All rights reserved.
//

import UIKit
import Kingfisher

class UnsplashTableViewCell: UITableViewCell {

    let photoView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .orange
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let usernameLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Unsplash Welcome"
        return label
    }()
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(photoView)
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        photoView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        photoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        photoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        
        contentView.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: 15).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoView.image = nil
        usernameLabel.text = nil
        
    }
    
    
    func configure(_ unsplash: UnsplashResults) {
        
        let urlString = unsplash.urls?.raw
        guard let url = URL(string: urlString!) else { return }
        let resource = ImageResource(downloadURL: url)
        photoView.kf.setImage(with: resource, options: [])
        usernameLabel.text = unsplash.user?.username
        
    }

}
