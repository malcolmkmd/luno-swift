# luno-swift

============

Unofficial iOS client for Luno API.

## Todo

- Implement remaining API methods (authenticated calls)
- Unit Tests

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
