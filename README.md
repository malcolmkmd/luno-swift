# luno-swift

Unofficial Swift iOS client for Luno API.

## Todo

- Implement authenticated API methods
- Unit Tests

## Example Projects

To use the example project download the repo build and run the 'example' target. (Requires Xcode 10)

## Usage

```swift

import UIKit
import Luno

class ExampleViewController: UIViewController {

    private let lunoClient = Luno(usingAPIKey: "api_key_id",
                                  andSecret: "api_key_secret")

    override func viewDidLoad() {
        super.viewDidLoad()

        self.lunoClient.ticker(pair: .ethXBT) { (ticker, error) in
            if let error = error {
                print(error)
            } else if let ticker = ticker {
                print(ticker)
            }
        }
    }

}

```
