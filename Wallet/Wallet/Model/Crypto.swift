//
//  Crypto.swift
//  Wallet
//
//  Created by Вадим Воляс on 24.01.2023.
//

// MARK: - Crypto
struct Crypto: Decodable {
    let data: Data?
    
    // MARK: - DataClass
    struct Data: Decodable {
        let symbol: String? //2
        let name: String? //3
        let marketData: MarketData?
        let marketcap: Marketcap?
        
        // MARK: - MarketData
        struct MarketData: Decodable {
            let priceUsd: Double? //2
            let percentChangeUsdLast24Hours: Double? //2
            let realVolumeLast24Hours: Double? //2
        }

        // MARK: - Marketcap
        struct Marketcap: Decodable {
            let rank: Int? //3
            let marketcapDominancePercent: Double? //3
            let currentMarketcapUsd: Double? //3
        }
    }
}






