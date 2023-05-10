//
//  TableViewCell.swift
//  Wallet
//
//  Created by Вадим Воляс on 25.01.2023.
//

import Foundation
import UIKit

final class QuotesCell: UITableViewCell {
    
    //MARK: - Private properties
    private enum UIConstants {
        static let labelFontSize: CGFloat = 14
        static let cellStackEdgesInset: CGFloat = 15
        static let percentChangeUsdLabelWidth: CGFloat = 75
    }
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.labelFontSize, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let volumeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.labelFontSize, weight: .regular)
        label.textColor = UIColors.lightGrey
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.labelFontSize, weight: .bold)
        label.textColor = UIColors.lightGrey
        return label
    }()
    
    private let percentChangeUsdLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.labelFontSize, weight: .bold)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    func configure(with quotesCellModel: QuotesCellModel) {
        symbolLabel.text = quotesCellModel.symbol
        volumeLabel.text = quotesCellModel.volume
        priceLabel.text = quotesCellModel.price
        percentChangeUsdLabel.text = quotesCellModel.percentChangeUsd
    }
}

//MARK: - Private methods
private extension QuotesCell {
    func initialize() {
        selectionStyle = .none
        
        contentView.backgroundColor = UIColors.grey
        
        let cellStack = UIStackView()
        cellStack.axis = .horizontal
        cellStack.addArrangedSubview(symbolLabel)
        cellStack.addArrangedSubview(volumeLabel)
        cellStack.addArrangedSubview(priceLabel)
        cellStack.addArrangedSubview(percentChangeUsdLabel)
        percentChangeUsdLabel.snp.makeConstraints { make in
            make.width.equalTo(UIConstants.percentChangeUsdLabelWidth)
        }
        
        cellStack.distribution = .equalCentering
        contentView.addSubview(cellStack)
        cellStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIConstants.cellStackEdgesInset)
        }
    }
    
}
