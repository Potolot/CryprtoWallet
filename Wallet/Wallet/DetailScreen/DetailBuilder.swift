//
//  ThirdScreenBuilder.swift
//  Wallet
//
//  Created by Вадим Воляс on 27.01.2023.
//

import Foundation
import UIKit

final class DetailBuilder {
    static func build(with detailData: Crypto.Data) -> UIViewController {
        let viewModel = DetailViewModel(detailData: detailData, maskManager: MaskManager.shared)
        let viewController = DetailVC(viewModel: viewModel)
        viewModel.view = viewController
        
        return viewController
    }
}
