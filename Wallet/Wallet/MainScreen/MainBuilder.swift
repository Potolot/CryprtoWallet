//
//  SecondScreenViewBuilder.swift
//  Wallet
//
//  Created by Вадим Воляс on 27.01.2023.
//

import UIKit

final class MainBuilder {
    static func build() -> UIViewController {
        let viewModel = MainViewModel(apiManager: ApiManager.shared, authManager: AuthorizeManager.shared, maskManager: MaskManager.shared, urlManager: UrlManager.shared)
        let viewController = MainVC(viewModel: viewModel)
        viewModel.view = viewController
        
        return viewController
    }
}

