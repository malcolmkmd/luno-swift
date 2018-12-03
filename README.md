# luno-swift

Unofficial Swift iOS client for Luno API.

## Todo

- Implement authenticated API methods
- Unit Tests

## Example Projects

How to install:

1. Download the repo
2. Add a Property List file with the 'Keys.plist' (If committing to source control add this file to your .gitignore)
3. Click on the Root dictionary and right-click to Add Row. Add a row for 'API_KEY' and another row for 'API_SECRET'
4. Insert your API Key and Secret as the values
5. Build and run.

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
