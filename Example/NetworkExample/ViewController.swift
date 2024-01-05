//
//  ViewController.swift
//  NetworkExample
//
//  Created by Ahmet Utlu on 12.10.2023.
//

import UIKit
import AUNetworking

class ViewController: UIViewController {
    let viewModel = ViewModel(service: Networking())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await viewModel.getPopularMoviesAsync()
        }
        
    }

}

