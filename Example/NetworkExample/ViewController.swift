//
//  ViewController.swift
//  NetworkExample
//
//  Created by Ahmet Utlu on 12.10.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPopularMovies()
    }

    func getPopularMovies() {
        Networking.request(router: MovieRouter.popular) { (response: PopularResponseModel?, errorString) in
            
            guard let response = response else { return }
            
            print("iiiiii......\(response)")
            
        } onFailure: { (errorString, errorType) in
            guard let error = errorString else { return }
            
            print(error)
        }
        
    }


}

