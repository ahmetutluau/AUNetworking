//
//  ViewController.swift
//  NetworkExample
//
//  Created by Ahmet Utlu on 12.10.2023.
//

import UIKit
import AUNetworking

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        APIConstants.baseURL = "https://api.themoviedb.org/3"
        getPopularMovies()
        getDetail()
    }

//    https://developer.themoviedb.org/reference/movie-popular-list
    func getPopularMovies() {
        Networking.request(router: MovieRouter.popular) { (response: PopularResponseModel?, errorString) in

            guard let response = response else { return }

            print("iiiiii......\(response)")

        } onFailure: { (errorString, errorType) in
            guard let error = errorString else { return }

            print(error)
        }
        
    }
    
//    https://developer.themoviedb.org/reference/movie-details
    func getDetail() {
        Networking.request(router: MovieRouter.detail(646389)) { (response: DetailResponseModel?, errorString) in
            
            guard let response = response else { return }
            
            print("iiiiii......\(response)")
            
        } onFailure: { (errorString, errorType) in
            guard let error = errorString else { return }
            
            print(error)
        }
    }

}

