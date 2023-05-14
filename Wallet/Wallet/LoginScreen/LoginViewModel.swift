//
//  ViewModel.swift
//  Wallet
//
//  Created by Вадим Воляс on 21.01.2023.
//

final class LoginViewModel: LoginProtocolIn {
    
    //MARK: - Properties
    weak var view: LoginProtocolOut?
    
    //MARK: - Private properties
    private enum UIConstants {
        static let loginDefault = "1234"
        static let pasDefault = "1234"
    }

    private let authManager: AuthorizeManager
    
    // MARK: - init
    init(authManager: AuthorizeManager) {
        self.authManager = authManager
    }
    
    //MARK: - Public methods
    func checkUserInputs(login: String, pass: String) {
        if login == UIConstants.loginDefault && pass == UIConstants.pasDefault {
            authManager.changeAuthorizeState(checkUserInputs: true)
            view?.successAuth()
            
        } else {
            view?.showErrorAlert()
        }
    }
}

