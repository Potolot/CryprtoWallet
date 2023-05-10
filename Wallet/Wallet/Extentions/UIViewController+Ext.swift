//
//  UIViewController+Ext.swift
//  Wallet
//
//  Created by Вадим Воляс on 27.01.2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, preferredStyle: UIAlertController.Style = .alert, withCancel: Bool = true) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { _ in
        })
        alert.addAction(ok)
        
        if withCancel {
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancel)
        }
        
        present(alert, animated: true)
    }
}
