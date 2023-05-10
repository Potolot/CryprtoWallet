//
//  ThirdScreenView.swift
//  Wallet
//
//  Created by Вадим Воляс on 27.01.2023.
//

import Foundation
import UIKit

final class DetailVC: UIViewController {
    
    //MARK: - Private properties
    private let viewModel: DetailProtocolIn
    
    private enum Constants {
        static let labelFontSize: CGFloat = 14
        static let stackSpacing: CGFloat = 16
        static let mainStackSpacing: CGFloat = 3
        static let volumeTextLabelSpacing: CGFloat = 70
        static let symbolTextLabelSpacing: CGFloat = 70
        static let stackTopInset: CGFloat = 105
        static let trailingLeadingStackInset: CGFloat = 8
    }
    
    private let nameTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.labelFontSize, weight: .bold)
        label.textColor = .white
        label.text = "Name:"
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.labelFontSize, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let symbolTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.labelFontSize, weight: .bold)
        label.textColor = .white
        label.text = "Short name:"
        return label
    }()
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.labelFontSize, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let priceTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.labelFontSize, weight: .bold)
        label.textColor = .white
        label.text = "Price:"
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.labelFontSize, weight: .bold)
        label.textColor = UIColors.lightGrey
        return label
    }()
    
    private let percentChangeUsdTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.labelFontSize, weight: .bold)
        label.textColor = .white
        label.text = "Price 24h change :"
        return label
    }()
    
    private let percentChangeUsdLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.labelFontSize, weight: .bold)
        label.textColor = UIColors.lightGrey
        return label
    }()
    
    private let volumeTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.labelFontSize, weight: .bold)
        label.textColor = .white
        label.text = "Volume:"
        return label
    }()
    
    private let volumeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.labelFontSize, weight: .bold)
        label.textColor = UIColors.lightGrey
        return label
    }()
    
    
    private let rankTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.labelFontSize, weight: .bold)
        label.textColor = .white
        label.text = "Rank"
        return label
    }()
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.labelFontSize, weight: .regular)
        label.textColor = UIColors.lightGrey
        return label
    }()
    
    private let marketcapDominancePercentTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.labelFontSize, weight: .bold)
        label.textColor = .white
        label.text = "Marketcap dominance"
        return label
    }()
    
    private let marketcapDominancePercentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.labelFontSize, weight: .regular)
        label.textColor = UIColors.lightGrey
        return label
    }()
    
    private let currentMarketcapUsdTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.labelFontSize, weight: .bold)
        label.textColor = .white
        label.text = "Current marketcap"
        return label
    }()
    
    private let currentMarketcapUsdLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.labelFontSize, weight: .regular)
        label.textColor = UIColors.lightGrey
        return label
    }()
    
    private let mainStack = UIStackView()
    private let textStack = UIStackView()
    private let labelWithDataStack = UIStackView()
    
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutVC() //прееименовть
        view.backgroundColor = UIColors.darkGrey
        viewModel.maskData()
    }
    
    //MARK: - init
    init(viewModel: DetailProtocolIn) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    private func layoutVC() {
        mainStack.axis = .horizontal
        mainStack.backgroundColor = UIColors.grey
        mainStack.distribution = .fillEqually
        mainStack.spacing = Constants.mainStackSpacing
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(textStack)
        mainStack.addArrangedSubview(labelWithDataStack)
        mainStack.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(Constants.trailingLeadingStackInset)
            make.top.equalToSuperview().inset(Constants.stackTopInset)
        }
        
        textStack.axis = .vertical
        textStack.addArrangedSubview(nameTextLabel)
        textStack.addArrangedSubview(symbolTextLabel)
        textStack.addArrangedSubview(priceTextLabel)
        textStack.addArrangedSubview(percentChangeUsdTextLabel)
        textStack.addArrangedSubview(volumeTextLabel)
        textStack.addArrangedSubview(rankTextLabel)
        textStack.addArrangedSubview(marketcapDominancePercentTextLabel)
        textStack.addArrangedSubview(currentMarketcapUsdTextLabel)
        textStack.spacing = Constants.stackSpacing
        textStack.setCustomSpacing(Constants.symbolTextLabelSpacing, after: symbolTextLabel)
        textStack.setCustomSpacing(Constants.volumeTextLabelSpacing, after: volumeTextLabel)
        
        labelWithDataStack.axis = .vertical
        labelWithDataStack.addArrangedSubview(nameLabel)
        labelWithDataStack.addArrangedSubview(symbolLabel)
        labelWithDataStack.addArrangedSubview(priceLabel)
        labelWithDataStack.addArrangedSubview(percentChangeUsdLabel)
        labelWithDataStack.addArrangedSubview(volumeLabel)
        labelWithDataStack.addArrangedSubview(rankLabel)
        labelWithDataStack.addArrangedSubview(marketcapDominancePercentLabel)
        labelWithDataStack.addArrangedSubview(currentMarketcapUsdLabel)
        labelWithDataStack.spacing = Constants.stackSpacing
        labelWithDataStack.setCustomSpacing(Constants.symbolTextLabelSpacing, after: symbolLabel)
        labelWithDataStack.setCustomSpacing(Constants.volumeTextLabelSpacing, after: volumeLabel)
    }
    
}

//MARK: - DetailProtocolOut
extension DetailVC: DetailProtocolOut {
    func getMaskData(data: MakeCryptoToString) {
        nameLabel.text = data.name
        symbolLabel.text = data.symbol
        priceLabel.text = data.price
        percentChangeUsdLabel.text = data.percentChangeUsd
        volumeLabel.text = data.volume
        rankLabel.text = data.rank
        marketcapDominancePercentLabel.text = data.marketcapDominancePercent
        currentMarketcapUsdLabel.text = data.currentMarketcapUsd
    }
    
}
