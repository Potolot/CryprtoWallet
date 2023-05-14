//
//  UrlManager.swift
//  Wallet
//
//  Created by Вадим Воляс on 29.01.2023.
//

class UrlManager {
    
    //MARK: - Public properties
    static let shared = UrlManager()
    
    //MARK: - Private properties
    private let tokenListForRequestArray = [
        "btc",
        "eth",
        "tron",
        "luna",
        "polkadot",
        "dogecoin",
        "tether",
        "stellar",
        "cardano",
        "xrp",
    ]
    
    //MARK: - Public methods
    func makeUrlArray() -> [String] {
        tokenListForRequestArray.map { tokenName in
            "https://data.messari.io/api/v1/assets/\(tokenName)/metrics"
        }
    }
    
}
