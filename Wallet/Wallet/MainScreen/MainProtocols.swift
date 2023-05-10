//
//  SecondScreenViewProtocols.swift
//  Wallet
//
//  Created by Вадим Воляс on 27.01.2023.
//


import Foundation

protocol MainProtocolIn {
    func loadData()
    func changeSort()
    func logOut()
    func data(at index: Int) -> Crypto.Data
}

protocol MainProtocolOut: AnyObject {
    func reloadData(cellArray: [QuotesCellModel])
    func showError(message: String)
}
