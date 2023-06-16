//
//  SecondScreenView.swift
//  Wallet
//
//  Created by Вадим Воляс on 22.01.2023.
//
import UIKit

final class MainVC: UIViewController {
    
    //MARK: - Private properties
    private let viewModel: MainProtocolIn

    private enum Constants {
        static let buttonFontSize: CGFloat = 17
        static let alertTittle = "Error"
        static let logOutButtonTittle = " LogOut"
        static let cellId = String(describing: QuotesCell.self)
    }
    
    private lazy var tableView = UITableView()
    private lazy var cellModelArray: [QuotesCellModel] = []
    
    private let spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = .white
        view.style = .large
        
        return view
    }()
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right"), for: .normal)
        button.setTitle(Constants.logOutButtonTittle, for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: Constants.buttonFontSize)
        button.addTarget(self, action: #selector(didTapLogOutButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var sortedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.up.chevron.down"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapSortedButton), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: init
    init(viewModel: MainProtocolIn) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        viewModel.loadData()
    }
    
    //MARK: - Private methods
    private func initialize() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(QuotesCell.self, forCellReuseIdentifier: Constants.cellId)
        tableView.backgroundColor = UIColors.darkGrey
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        spinner.startAnimating()
        tableView.backgroundView = spinner
        setupNavigationNavigationBar()
    }
    
    private func setupNavigationNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = UIColors.darkGrey
        navigationController?.navigationBar.barStyle = .black
        navigationItem.leftBarButtonItems = makeLeftButtonItems()
        navigationItem.rightBarButtonItems = makeRightButtonItems()
    }
    
    private func makeRightButtonItems() -> [UIBarButtonItem] {
        let sortedItem = UIBarButtonItem(customView: sortedButton)
        return [sortedItem]
    }
    
    private func makeLeftButtonItems() -> [UIBarButtonItem] {
        let logOutItem = UIBarButtonItem(customView: logOutButton)
        return [logOutItem]
    }
    
    @objc
    private func didTapSortedButton() {
        viewModel.changeSort()
    }
    
    @objc
    private func didTapLogOutButton() {
        viewModel.logOut()
        AppDelegate.shared?.changeRoot(viewController: LoginBuilder.build())
        self.dismiss(animated: true)
    }
}

//MARK: - UITableViewDataSource
extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId, for: indexPath) as? QuotesCell else { return UITableViewCell() }
        cell.configure(with: cellModelArray[indexPath.row])
        return cell
    }
}

//MARK: - UITableViewDelegate
extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let detailData = viewModel.data(at: index)
        let controller = DetailBuilder.build(with: detailData)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - MainProtocolOut
extension MainVC: MainProtocolOut {
    func showError(message: String) {
        showAlert(title: Constants.alertTittle, message: message) 
    }
    
    func reloadData(cellArray: [QuotesCellModel]) {
        self.spinner.stopAnimating()
        self.cellModelArray = cellArray
        self.tableView.reloadData()
    }
}
