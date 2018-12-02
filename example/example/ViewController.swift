//
//  ViewController.swift
//  example
//
//  Created by Malcolm Kumwenda on 2018/12/01.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import UIKit
import Luno

class ViewController: UIViewController {

    private var lunoClient: Luno!

    @IBOutlet private weak var tickerButton: UIButton! {
        didSet {
            tickerButton.addTarget(self,
                                   action: #selector(handleTickerButtonTouchUpInside(_:)),
                                   for: .touchUpInside)
            tickerButton.styleLunoButton()
        }
    }

    @IBOutlet private weak var tickersButton: UIButton! {
        didSet {
            tickersButton.addTarget(self,
                                    action: #selector(handleTickersButtonTouchUpInside(_:)),
                                    for: .touchUpInside)
            tickersButton.styleLunoButton()
        }
    }

    @IBOutlet private weak var orderBookTopButton: UIButton! {
        didSet {
            orderBookTopButton.addTarget(self,
                                         action: #selector(handleOrderBookTopButtonTouchUpInside(_:)),
                                         for: .touchUpInside)
            orderBookTopButton.styleLunoButton()
        }
    }

    @IBOutlet private weak var orderBookFullButton: UIButton! {
        didSet {
            orderBookFullButton.addTarget(self,
                                          action: #selector(handleOrderBookFullButtonTouchUpInside(_:)),
                                          for: .touchUpInside)
            orderBookFullButton.styleLunoButton()
        }
    }

    @IBOutlet private weak var tradesButton: UIButton! {
        didSet {
            tradesButton.addTarget(self,
                                   action: #selector(handleTradesButtonTouchUpInside(_:)),
                                   for: .touchUpInside)
            tradesButton.styleLunoButton()
        }
    }

    @IBOutlet private weak var segmentedControl: UISegmentedControl! {
        didSet {
            segmentedControl.setTitle("ETHXBT", forSegmentAt: 0)
            segmentedControl.setTitle("XBTZAR", forSegmentAt: 1)
        }
    }

    @IBOutlet private weak var outputTextView: UITextView!

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.stopAnimating()
        }
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        lunoClient = Luno.init(usingAPIKey: "",
                               andSecret: "")
    }

    // MARK: - Button Action Handler
    @objc private func handleTickerButtonTouchUpInside(_ button: UIButton) {
        let pair: LunoPair = segmentedControl.selectedSegmentIndex == 0 ? .ethXBT : .xbtZAR

        activityIndicator.startAnimating()
        lunoClient.ticker(pair: pair) { (ticker, error) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                if let error = error {
                    self.outputTextView.text = error
                } else if let ticker = ticker {
                    self.outputTextView.text = ticker.debugDescription
                }
            }
        }

    }

    @objc private func handleTickersButtonTouchUpInside(_ button: UIButton) {
        activityIndicator.startAnimating()
        lunoClient.tickers { (tickers, error) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                if let error = error {
                    self.outputTextView.text = error
                } else if let tickers = tickers {
                    self.outputTextView.text = tickers.debugDescription
                }
            }
        }

    }

    @objc private func handleOrderBookTopButtonTouchUpInside(_ button: UIButton) {
        let pair: LunoPair = segmentedControl.selectedSegmentIndex == 0 ? .ethXBT : .xbtZAR

        activityIndicator.startAnimating()
        lunoClient.orderBookTop(pair: pair) { (orderBook, error) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                if let error = error {
                    self.outputTextView.text = error
                } else if let orderBook = orderBook {
                    self.outputTextView.text = orderBook.debugDescription
                }
            }

        }

    }

    @objc private func handleOrderBookFullButtonTouchUpInside(_ button: UIButton) {
        let pair: LunoPair = segmentedControl.selectedSegmentIndex == 0 ? .ethXBT : .xbtZAR

        activityIndicator.startAnimating()
        lunoClient.orderBookFull(pair: pair) { (orderBook, error) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                if let error = error {
                    self.outputTextView.text = error
                } else if let orderBook = orderBook {
                    self.outputTextView.text = orderBook.debugDescription
                }
            }

        }

    }

    @objc private func handleTradesButtonTouchUpInside(_ button: UIButton) {
        let pair: LunoPair = segmentedControl.selectedSegmentIndex == 0 ? .ethXBT : .xbtZAR

        activityIndicator.startAnimating()
        lunoClient.trades(pair: pair) { (trades, error) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                if let error = error {
                    self.outputTextView.text = error
                } else if let trades = trades {
                    self.outputTextView.text = trades.debugDescription
                }
            }
        }

    }

}

extension UIButton {
    func styleLunoButton() {
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowOpacity = 0.24
        self.layer.shadowRadius = CGFloat(2.0)
    }
}

