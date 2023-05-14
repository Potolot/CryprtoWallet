//
//  ThirdScreenProtocols.swift
//  Wallet
//
//  Created by Вадим Воляс on 27.01.2023.
//

protocol DetailProtocolIn {
    func maskData()
}

protocol DetailProtocolOut: AnyObject {
    func getMaskData(data: MakeCryptoToString)
}
