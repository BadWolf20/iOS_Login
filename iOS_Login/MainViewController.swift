//
//  ViewController.swift
//  iOS_Login
//
//  Created by Roman on 11.10.2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    // MARK: - Properties
    // MARK: - Components
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = safeResource(UIColor(named: "TextField"))

        return label
    }()

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.clipsToBounds = true
        textField.backgroundColor = safeResource(UIColor(named: "TextField"))

        textField.setIcon(image: safeResource(
            UIImage(
                systemName: "person")?.withTintColor(
                    safeResource(UIColor(named: "GrayAcent")),
                    renderingMode: .alwaysOriginal)),
                          side: .left)

        textField.setIcon(image: safeResource(
            UIImage(
                systemName: "checkmark.circle.fill")?.withTintColor(
                    .green,
                    renderingMode: .alwaysOriginal)),
                          side: .right)

        textField.rightViewMode = .never
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.clipsToBounds = true
        textField.backgroundColor = UIColor(named: "TextField")
        textField.setIcon(image: safeResource(
            UIImage(
                systemName: "lock")?.withTintColor(
                    safeResource(UIColor(named: "GrayAcent")),
                    renderingMode: .alwaysOriginal)),
                          side: .left)

        return textField

    }()

    private lazy var inputStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    private lazy var sinBackground: SinusoidalView = {
        let sinusoidal = SinusoidalView()

        sinusoidal.gradientColors = [UIColor.blue.cgColor, UIColor.systemPink.cgColor]
        sinusoidal.frame = view.bounds
        sinusoidal.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return sinusoidal
    }()

    private lazy var sinBackgroundBack: SinusoidalView = {
        let sinusoidal = SinusoidalView()

        sinusoidal.amplitude = 20
        sinusoidal.phase = 0.5
        sinusoidal.isVerticalGradient = false
        sinusoidal.gradientColors = [UIColor.red.cgColor, UIColor.cyan.cgColor]
        sinusoidal.frame = view.bounds
        sinusoidal.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return sinusoidal
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.backgroundColor = safeResource(UIColor(named: "LoginButton"))
        button.setTitleColor(safeResource(UIColor(named: "Title")), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)

        return button
    }()

    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(safeResource(UIColor(named: "Title")), for: .normal)

        return button
    }()

    private lazy var socialLoginView = SocialLoginView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTextField.layer.cornerRadius = emailTextField.frame.height / 2
        passwordTextField.layer.cornerRadius = emailTextField.frame.height / 2
        loginButton.layer.cornerRadius = loginButton.frame.height / 2

    }

    // MARK: - Setup

    private func setupUI() {
        view.backgroundColor = .white

        setupHierarchy()
        setupConstraints()
        setupComponents()
        setupText()

    }

    private func setupHierarchy() {
        view.addSubview(loginLabel)
        view.addSubview(inputStackView)
        view.addSubview(buttonStackView)

        view.addSubview(sinBackground)
        view.sendSubviewToBack(sinBackground)

        view.addSubview(sinBackgroundBack)
        view.sendSubviewToBack(sinBackgroundBack)

        inputStackView.addArrangedSubview(emailTextField)
        inputStackView.addArrangedSubview(passwordTextField)

        buttonStackView.addArrangedSubview(loginButton)
        buttonStackView.addArrangedSubview(forgotPasswordButton)
    }

    private func setupComponents() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)

    }

    private func setupText() {
        loginLabel.text = "Login"

        loginButton.setTitle("Login", for: .normal)
        forgotPasswordButton.setTitle("Forgot your password?", for: .normal)
    }

    private func setupConstraints() {
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
        loginButton.snp.remakeConstraints { make in
            make.height.equalTo(emailTextField)
        }
            make.centerX.equalTo(view)
        }

        inputStackView.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(30)
            make.left.right.equalTo(view).inset(UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 80))
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        buttonStackView.snp.remakeConstraints { make in
            make.top.equalTo(inputStackView.snp.bottom).offset(forOrientation(portrait: 45, landscape: 5))
            make.left.right.equalTo(inputStackView)
        }
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }


    func forOrientation(portrait: CGFloat, landscape: CGFloat) -> CGFloat {
        return UIDevice.current.orientation.isPortrait ? portrait : landscape
    }
    // MARK: - Update
    // MARK: - Actions
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Functions

}

