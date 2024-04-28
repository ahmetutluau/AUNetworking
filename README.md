# AUNetworking

This package is a generic network layer that you can easily use when networking in your projects. I got help from URLSession and Async-await while making this package and it is also suitable for dependency injection and unit tests.

## Technologies
- Async-await

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
        
        APIConstants.baseURL = "https://write-your-base-url"

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

3) import AUNetworking. Create your endpointConfiguration enum/struct by EndpointConfiguration protocol and give your method,path,queryParameters,httpBody,headers.  

```swift
import Foundation
import AUNetworking

enum YourRouter: EndpointConfiguration {
    
    case yourEndpoint
    
    var method: HTTPMethod {
        switch self {
        case .yourEndpoint:
            return .GET
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
    
    var multipartFormData: MultipartFormData {
        return nil
    }
}

```



3) import AUNetworking. Write your networking function in your viewModel class.

```swift
import Foundation
import AUNetworking

class ViewModel {
    var service: NetworkRequester
    
    init(service: NetworkRequester) {
        self.service = service
    }
    
    func getData() async {
        do {
            let response: YourResponseModel? = try await service.request(YourRouter.yourEndpoint)
            guard let response else { return }
            
            print(response)
        } catch {
            print(error)
        }
    }
    
}

```

4) call your networking functions in viewController.  

```swift
import UIKit
import AUNetworking

class ViewController: UIViewController {
    let viewModel = ViewModel(service: Networking())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await viewModel.getData()
        }
        
    }

}
```
