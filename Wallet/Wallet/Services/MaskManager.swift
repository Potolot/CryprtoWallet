//
//  MaskManager.swift
//  Wallet
//
//  Created by Вадим Воляс on 27.01.2023.
//

import Foundation

class MaskManager {
    //MARK: - Public properties
    static let shared = MaskManager()
    
    private enum Constants {
        static let defaultValueLabel = "N/A"
        static let formatForRounded = "%.2f"
        static let million = " Млн"
        static let billion = " Млрд"
    }
    
    func checkName(symbol: String?) -> String {
        guard let symbol = symbol else { return Constants.defaultValueLabel }
        return symbol
    }
    
    func separatedNumber(number: Double?, maxFractionDigits: Int = 3) -> String {
        guard let itIsNumber = number as? NSNumber else { return Constants.defaultValueLabel }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = ","
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = maxFractionDigits
        return formatter.string(from: itIsNumber) ?? ""
    }
    
    func rounded(number: Double?) -> String {
        guard let number = number else { return Constants.defaultValueLabel }
        let result: String
        let numberString = String(number.rounded())
        switch numberString.count {
        case 12...:
            result = String(format: Constants.formatForRounded, (number / 1000000000)) + Constants.billion
        case 9...11:
            result = String(format: Constants.formatForRounded,(number / 1000000)) + Constants.million
        default:
            result = String(format: Constants.formatForRounded, number)
        }
        return result
    }
    
    func convertToString(int: Int?) -> String {
        guard let int = int else { return Constants.defaultValueLabel }
        let result = String(int)
        return result
    }
    
}
