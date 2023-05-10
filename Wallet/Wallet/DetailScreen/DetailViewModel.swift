//
//  ThirdScreenViewModel.swift
//  Wallet
//
//  Created by Вадим Воляс on 27.01.2023.
//

import Foundation

final class DetailViewModel: DetailProtocolIn {
    
    //MARK: Public properties
    weak var view: DetailProtocolOut?
    
    //MARK: Private properties
    private let detailData: Crypto.Data
    
    private let maskManager: MaskManager
    
    //MARK: - init
    init(detailData: Crypto.Data, maskManager: MaskManager) {
        self.detailData = detailData
        self.maskManager = maskManager
    }

    //MARK: - Public methods
    func maskData() {
        self.view?.getMaskData(data: self.makeData())
    }
    
    //MARK: - Private methods
    private func makeData() -> MakeCryptoToString {
        let name = maskManager.checkName(symbol: detailData.name)
        let symbol = maskManager.checkName(symbol: detailData.symbol)
        let price = maskManager.separatedNumber(number: detailData.marketData?.priceUsd)
        let percentChangeUsd = maskManager.separatedNumber(number: detailData.marketData?.percentChangeUsdLast24Hours, maxFractionDigits: 2) + " %"
        let volume = maskManager.rounded(number: detailData.marketData?.realVolumeLast24Hours)
        let rank = maskManager.convertToString(int: detailData.marketcap?.rank)
        let marketcapDominancePercent = maskManager.separatedNumber(number: detailData.marketcap?.marketcapDominancePercent, maxFractionDigits: 2) + " %"
        let currentMarketcapUsd = maskManager.rounded(number: detailData.marketcap?.currentMarketcapUsd)
        
       return MakeCryptoToString(name: name, symbol: symbol, price: price, percentChangeUsd: percentChangeUsd, volume: volume, rank: rank, marketcapDominancePercent: marketcapDominancePercent, currentMarketcapUsd: currentMarketcapUsd)
    }
}
