# AUNetworking

This package is a generic network layer that you can easily use when networking in your projects.

## Installation

To install this package, import `https://github.com/ahmetutluau/AUNetworking` in SPM.

## Usage example

I have left a simple code example below, but for a more detailed example, you can examine the file named NetworkExample under the file named Example.

```swift

import AUNetworking

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        APIConstants.baseURL = "write-your-base-url"
        getData()
    }

    func getData() {
        Networking.request(router: <YourEndpointsRouter>) { (response: <YourResponseModel>, errorString) in

            guard let response = response else { return }

            print("iiiiii......\(response)")

        } onFailure: { (errorString, errorType) in
            guard let error = errorString else { return }

            print(error)
        }
        
    }


}


```
