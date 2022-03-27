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

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let d = dateFormatter.date(from: self)
        return  d ?? Date()
    }
    
    func dateToFormattedString() -> String {
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"
        
        let date: Date? = self.toDate()
        return dateFormatterPrint.string(from: date!);
    }
}



