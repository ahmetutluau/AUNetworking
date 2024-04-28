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
    func getPopularMoviesAsync() async {
        do {
            let response: PopularResponseModel? = try await service.request(MovieRouter.popular)
            guard let response else { return }
            
            print(response.results[0].overview)
        } catch {
            print(error)
        }
    }
    
}
