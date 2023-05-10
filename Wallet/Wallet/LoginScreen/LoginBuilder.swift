//
//  Builder.swift
//  Wallet
//
//  Created by Вадим Воляс on 21.01.2023.
//

import Foundation
import UIKit

final class LoginBuilder {
    static func build() -> UIViewController {
        let viewModel = LoginViewModel(authManager: AuthorizeManager.shared)
        let viewController = LoginVC(viewModel: viewModel)
        viewModel.view = viewController
        
        return viewController
    }
}
