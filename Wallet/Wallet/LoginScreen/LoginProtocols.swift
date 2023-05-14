//
//  Protocols.swift
//  Wallet
//
//  Created by Вадим Воляс on 21.01.2023.
//

protocol LoginProtocolIn {
    func checkUserInputs(login: String, pass: String)
}

protocol LoginProtocolOut: AnyObject { 
    func successAuth()
    func showErrorAlert()
}


