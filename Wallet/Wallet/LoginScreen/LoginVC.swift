//
//  View.swift
//  Wallet
//
//  Created by Вадим Воляс on 21.01.2023.
//
import Foundation
import UIKit
import SnapKit

final class LoginVC: UIViewController {
    
    //MARK: - Private properties
    private let viewModel: LoginProtocolIn
    
    private enum Constants {
        static let textSize: CGFloat = 20
        static let textFieldSize: CGFloat = 17
        static let authorizationStackSpacing: CGFloat = 6
        static let userLoginInset: CGFloat = 20
        static let authorizationStackTrailingInset: CGFloat = 70
        static let authorizationStackTopInset: CGFloat = 200
        static let eyeButtonInset: CGFloat = 8
        static let userLoginLabelText = "Login"
        static let passwordLabelText = "Password"
        static let title = "Authorisation Error"
        static let message = "Please enter correct username and password"
        static let loginPlaceholder = "userName"
        static let pasPlaceholder = "password"
        static let buttonTitle = "Далее"
    }
    
    private let userLoginLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: Constants.textSize, weight: .bold)
        label.text = Constants.userLoginLabelText
        
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: Constants.textSize, weight: .bold)
        label.text = Constants.passwordLabelText
        
        return label
    }()
    
    private let userLoginTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColors.grey
        textField.textColor = .white
        textField.autocorrectionType = .no
        textField.attributedPlaceholder = NSAttributedString(
            string: Constants.loginPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        
        textField.font = .systemFont(ofSize: Constants.textFieldSize)
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColors.grey
        textField.textColor = .white
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.keyboardType = .numberPad
        textField.attributedPlaceholder = NSAttributedString(
            string: Constants.pasPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        
        textField.font = .systemFont(ofSize: Constants.textFieldSize)
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private let authorizationStack = UIStackView()
    
    private lazy var eyeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(eyeButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColors.yellow
        button.setTitle(Constants.buttonTitle, for: .normal)
        button.tintColor = UIColors.darkGrey
        button.titleLabel?.font = .systemFont(ofSize: Constants.textSize)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: init
    init(viewModel: LoginProtocolIn) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override properties
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userLoginTextField.delegate = self
        self.passwordTextField.delegate = self
        tapGestureRecognizer()
        setup()
        view.backgroundColor = UIColors.darkGrey
        setupNavigationNavigationBar()
    }
    
    //MARK: - Private methods
    private func tapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc
    private func hideKeyboardOnTap() {
        view.endEditing(true)
    }
    
    @objc
    private func eyeButtonTap() {
        if passwordTextField.isSecureTextEntry {
            passwordTextField.isSecureTextEntry = false
            eyeButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        } else {
            passwordTextField.isSecureTextEntry = true
            eyeButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
    }
    
    @objc
    private func tapButton() {
        let login = userLoginTextField.text ?? ""
        let pass = passwordTextField.text ?? ""
        
        viewModel.checkUserInputs(login: login, pass: pass)
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case userLoginTextField:
            passwordTextField.becomeFirstResponder()
        default:
            self.passwordTextField.resignFirstResponder()
        }
    }
    
    private func setup() {
        authorizationStack.axis = .vertical
        authorizationStack.addArrangedSubview(userLoginLabel)
        authorizationStack.addArrangedSubview(userLoginTextField)
        authorizationStack.addArrangedSubview(passwordLabel)
        authorizationStack.addArrangedSubview(passwordTextField)
        authorizationStack.addArrangedSubview(button)
        authorizationStack.spacing = Constants.authorizationStackSpacing
        authorizationStack.setCustomSpacing(Constants.userLoginInset, after: userLoginTextField)
        authorizationStack.setCustomSpacing(Constants.userLoginInset, after: passwordTextField)
        view.addSubview(authorizationStack)
        authorizationStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.authorizationStackTopInset)
            make.leading.trailing.equalToSuperview().inset(Constants.authorizationStackTrailingInset)
        }
        
        view.addSubview(eyeButton)
        eyeButton.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField)
            make.trailing.equalTo(passwordTextField).inset(Constants.eyeButtonInset)
        }
    }
    
    private func setupNavigationNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColors.darkGrey
        navigationController?.navigationBar.barStyle = .black
    }
}

//MARK: - LoginProtocolOut
extension LoginVC: LoginProtocolOut {
    func successAuth() {
        let controller = MainBuilder.build()
        let navigationVC = UINavigationController(rootViewController: controller)
        AppDelegate.shared?.changeRoot(viewController: navigationVC)
    }
    
    func showErrorAlert() {
        showAlert(title: Constants.title, message: Constants.message, preferredStyle: .alert, withCancel: false)
    }
}

//MARK: - UITextFieldDelegate
extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switchBasedNextTextField(textField)
        return true
    }
    
}
