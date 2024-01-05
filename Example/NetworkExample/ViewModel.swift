//
//  ViewModel.swift
//  NetworkExample
//
//  Created by Ahmet Utlu on 5.01.2024.
//

import Foundation
import AUNetworking

class ViewModel {
    
    var service: NetworkRequester
    
    init(service: NetworkRequester) {
        self.service = service
    }
    
    //    https://developer.themoviedb.org/reference/movie-popular-list
        func getPopularMovies() {
            service.request(router: MovieRouter.popular) { (response: PopularResponseModel?, errorString) in

                guard let response = response else { return }

                print("iiiiii......\(response)")

            } onFailure: { (errorString, errorType) in
                guard let error = errorString else { return }

                print(error)
            }
            
        }
        
    //    https://developer.themoviedb.org/reference/movie-details
        func getDetail() {
            service.request(router: MovieRouter.detail(646389)) { (response: DetailResponseModel?, errorString) in
                
                guard let response = response else { return }
                
                print("iiiiii......\(response)")
                
            } onFailure: { (errorString, errorType) in
                guard let error = errorString else { return }
                
                print(error)
            }
        }
}
