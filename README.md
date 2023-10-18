# AUNetworking

This package is a generic network layer that you can easily use when networking in your projects. I got help from Alamofire while making this package and it is also suitable for writing unit tests.

## Installation

To install this package, import `https://github.com/ahmetutluau/AUNetworking` in SPM.

## Usage example

I have left a simple code example below, but for a more detailed example, you can examine the file named NetworkExample under the file named Example.


1) import AUNetworking and give your baseUrl inside of AppDelegate class.

```swift
import UIKit
import AUNetworking

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        APIConstants.baseURL = "https://api.themoviedb.org/3"

        return true
    }
}
```

2) Create your response and/or request models.

```swift
struct YourResponseModel: Codable {
    let a: String
    let b: [C]
    let c: Int
}
```

3) import AUNetworking and Alamofire. Create your endpointConfiguration enum/struct by EndpointConfiguration protocol and give your method,path,queryParameters,httpBody,headers.  

```swift
import Foundation
import AUNetworking
import Alamofire

enum YourRouter: EndpointConfiguration {
    
    case yourEndpoint
    
    var method: HTTPMethod {
        switch self {
        case .yourEndpoint:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .yourEndpoint:
            return "write/your/endpoint"
        }
    }
    
    var queryParameters: QueryStringParameters {
        switch self {
        case .yourEndpoint:
            return ["api_key": "your_api_key"]
        }
    }
    
    var httpBody: Data? {
        return nil
    }
    
    var headers: [CustomHTTPHeader]? {
        return nil
    }
}

```



3) import AUNetworking. Write your networking function in your viewController class and active it in viewDidload.  

```swift
import UIKit
import AUNetworking

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }

    func getData() {
        Networking.request(router: YourRouter.yourEndpoint) { (response: YourResponseModel?, errorString) in

            guard let response = response else { return }

            print("iiiiii......\(response)")

        } onFailure: { (errorString, errorType) in
            guard let error = errorString else { return }

            print(error)
        }
        
    }
}
```
