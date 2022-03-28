//
//  PlacesViewModel.swift
//  TakeHomeApp
//
//  Created by Enas Ahmed Zaki on 27/03/2022.
//

import Foundation
import Alamofire

class PlacesViewModel {
    
    // I prefer using Alamofire to handle errors with validate. It also provides high quality, elegant code and easy to deal with.
    func getPlaces(completionResult:@escaping ((([PlacesModel]?) -> Void))) -> Void {
        AF.request("https://608948878c8043001757e68c.mockapi.io/api/v1/places")
            .validate()
            .responseDecodable(of: [PlacesModel].self) { (response) in
                guard let places = response.value else {
                    completionResult(nil)
                    return
                }
                
                let sortedPlaces = places.sorted { $0.name.lowercased() < $1.name.lowercased() }
                completionResult(sortedPlaces)
            }
    }
}
