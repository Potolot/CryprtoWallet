//
//  AuthorizationManager.swift
//  Wallet
//
//  Created by Вадим Воляс on 31.01.2023.
//

import Foundation

class AuthorizeManager {
    
    //MARK: - Propirties
    static let shared = AuthorizeManager()
    
    enum UIConstants {
        static let saveLoginKey = "checkLogin"
    }
    
    //MARK: - Public methods
    func isUserAuthorize() -> Bool {
        guard let userAuthorize = UserDefaults.standard.value(LoginSaved.self, forKey: UIConstants.saveLoginKey) else { return false }
        let isUserAuthorize = userAuthorize.isItLoggedIn
        return isUserAuthorize
    }
    
    func changeAuthorizeState(checkUserInputs: Bool) {
        if checkUserInputs == true {
            let userAuthorize = LoginSaved(isItLoggedIn: true)
            UserDefaults.standard.set(encodable: userAuthorize, forKey: AuthorizeManager.UIConstants.saveLoginKey)
        } else {
            let userAuthorize = LoginSaved(isItLoggedIn: false)
            UserDefaults.standard.set(encodable: userAuthorize, forKey: AuthorizeManager.UIConstants.saveLoginKey)
        }
    }
    
}
