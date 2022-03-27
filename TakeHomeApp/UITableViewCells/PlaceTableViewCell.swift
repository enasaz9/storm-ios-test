//
//  PlaceTableViewCell.swift
//  TakeHomeApp
//
//  Created by Enas Ahmed Zaki on 27/03/2022.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    
    let thumbnailImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor =  .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(thumbnailImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.backgroundColor = .white
        thumbnailImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        thumbnailImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        
        nameLabel.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:self.thumbnailImageView.trailingAnchor, constant:10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant:40).isActive = true
                
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
