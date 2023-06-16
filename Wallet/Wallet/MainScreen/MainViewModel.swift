//
//  SecondScreenViewModel.swift
//  Wallet
//
//  Created by Вадим Воляс on 27.01.2023.
//

import Foundation

final class MainViewModel: MainProtocolIn {    
    
    //MARK: - Properties
    weak var view: MainProtocolOut?
    
    //MARK: - Private properties
    private var dataArray: [Crypto.Data] = []
    private var ascendance: Bool = true
    
    private let apiManager: ApiManager
    private let authManager: AuthorizeManager
    private let urlManager: UrlManager
    private let maskManager: MaskManager
    
    // MARK: - init
    init(apiManager: ApiManager, authManager: AuthorizeManager, maskManager: MaskManager, urlManager: UrlManager) {
        self.apiManager = apiManager
        self.authManager = authManager
        self.maskManager = maskManager
        self.urlManager = urlManager
    }
    
    //MARK: - Public methods
    func logOut() {
        authManager.changeAuthorizeState(checkUserInputs: false)
    }
    
    func loadData() {
        let urlArray = urlManager.makeUrlArray()
        var error: Error?
        let dispatchGroup = DispatchGroup()
        _ = urlArray.map { url in
            dispatchGroup.enter()
            ApiManager.shared.makeRequest(for: url) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let crypto):
                    if let data = crypto.data {
                        self.dataArray.append(data)
                    }
                case .failure(let requestError):
                    error = requestError
                }
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            if let error = error {
                let errorMessage = error.localizedDescription
                self.view?.showError(message: errorMessage)
            }
            self.view?.reloadData(cellArray: self.makeCellModels())
        }
    }
    
    func changeSort() {
        if ascendance {
            dataArray = sortedArray()
        } else {
            dataArray = sortedArray().reversed()
        }
        ascendance.toggle()
        self.view?.reloadData(cellArray: self.makeCellModels())
    }
    
    func data(at index: Int) -> Crypto.Data {
        return dataArray[index]
    }
    
    //MARK: - Private methods
    private func makeCellModels() -> [QuotesCellModel] {
        let cellModelArray = self.dataArray.map { data in
            let symbol = maskManager.checkName(symbol: data.symbol)
            let volume = maskManager.rounded(number: data.marketData?.realVolumeLast24Hours)
            let price = maskManager.separatedNumber(number: data.marketData?.priceUsd)
            let percentChangeUsd = maskManager.separatedNumber(number: data.marketData?.percentChangeUsdLast24Hours, maxFractionDigits: 2) + " %"
            
            return  QuotesCellModel(symbol: symbol, volume: volume, price: price , percentChangeUsd: percentChangeUsd)
        }
        return cellModelArray
    }
    
    private func sortedArray() -> [Crypto.Data] {
        let sortedDataArray = dataArray.sorted {
            guard let lhs = $0.marketData?.percentChangeUsdLast24Hours else { return false }
            guard let rhs = $1.marketData?.percentChangeUsdLast24Hours else { return true }
            return lhs > rhs
        }
        return sortedDataArray
    }

}
