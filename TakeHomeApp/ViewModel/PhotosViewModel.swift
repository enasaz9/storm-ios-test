//
//  PhotosViewModel.swift
//  TakeHomeApp
//
//  Created by Enas Ahmed Zaki on 27/03/2022.
//

import Foundation
import Alamofire

class PhotosViewModel {
    
    func getPhotosOf(placeID: String, completionResult:@escaping ((([PhotosModel]?) -> Void))) -> Void {
        
        let requestURL = String.init(format: "https://608948878c8043001757e68c.mockapi.io/api/v1/places/%@/photos", placeID)
        
        AF.request(requestURL)
            .validate()
            .responseDecodable(of: [PhotosModel].self) { (response) in
                guard let photos = response.value else {
                    completionResult(nil)
                    return
                }
                
                let sortedPhotos = photos.sorted { $0.createdAt.toDate() > $1.createdAt.toDate() }
                completionResult(sortedPhotos)
            }
    }
}
