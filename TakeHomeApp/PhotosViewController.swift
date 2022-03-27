//
//  PhotosViewController.swift
//  TakeHomeApp
//
//  Created by Enas Ahmed Zaki on 27/03/2022.
//


import UIKit

class PhotosViewController: UIViewController {
    
    var photos: [PhotosModel] = []
    var selectedPlace: PlacesModel!
    
    let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    var activityIndicator: UIActivityIndicatorView!

    let spacing: CGFloat = 16.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setupLayouts()
        getPlacePhotos()
    }
    
    func initialSetup() {
        
        navigationItem.title = selectedPlace.name
        
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        
        activityIndicator = UIActivityIndicatorView(style: .large)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setupLayouts() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // Layout constraints for collectionView
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func getPlacePhotos() {
        let viewModel = PhotosViewModel()
        activityIndicator.startAnimating()

        viewModel.getPhotosOf(placeID: self.selectedPlace.id) { response in
            self.activityIndicator.stopAnimating()
            
            if let photosArray = response, !(photosArray.isEmpty) {
                self.photos = photosArray
                self.collectionView.reloadData()
                
            } else {
                print("error or empty")
            }
        }
    }
    
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell

        let photo = photos[indexPath.row]
        cell.createdAtLabel.text = photo.createdAt.dateToFormattedString()
        cell.photoImageView.sd_setImage(with: URL.init(string: photo.image), completed: nil)
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = view.frame.width - (2*spacing)
        let height = collectionView.frame.height - spacing

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
}
