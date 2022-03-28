//
//  PhotoCollectionViewCell.swift
//  TakeHomeApp
//
//  Created by Enas Ahmed Zaki on 27/03/2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let createdAtLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupLayouts()
    }
    
    func setupViews() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(photoImageView)
        contentView.addSubview(createdAtLabel)
        
    }
    
    // Handling the layout constraints of the CollectionView cell outlets
    func setupLayouts() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        createdAtLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
        
        NSLayoutConstraint.activate([
            createdAtLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            createdAtLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -30.0),
            createdAtLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
