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
        label.textColor = safeResource(UIColor(named: "Title"))

        return label
    }()

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()

        // Настройка основных свойств
        textField.backgroundColor = safeResource(UIColor(named: "TextField"))
        textField.textColor = .black
        textField.clipsToBounds = true
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.gray.cgColor

        // Настройка placeholder
        textField.attributedPlaceholder = NSAttributedString(string: " ", attributes: [
            .foregroundColor: safeResource(UIColor(named: "GrayAcent")?.withAlphaComponent(0.5)),
        ])

        // Настройка иконок
        textField.setIcon(image: safeResource(
            UIImage(
                systemName: "person")?
                .withTintColor(safeResource(UIColor(named: "GrayAcent")), renderingMode: .alwaysOriginal)),
                          side: .left)

        textField.setIcon(image: safeResource(
            UIImage(
                systemName: "checkmark.circle.fill")?
                .withTintColor(.green, renderingMode: .alwaysOriginal)),
                          side: .right)

        textField.rightViewMode = .never
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()

        // Настройка основных свойств
        textField.isSecureTextEntry = true
        textField.backgroundColor = safeResource(UIColor(named: "TextField"))
        textField.textColor = .black
        textField.isSecureTextEntry = true
        textField.clipsToBounds = true
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.gray.cgColor

        // Настройка placeholder
        textField.attributedPlaceholder = NSAttributedString(string: " ", attributes: [
            .foregroundColor: safeResource(UIColor(named: "GrayAcent")?.withAlphaComponent(0.5)),
        ])

        // Настройка иконок
        textField.setIcon(image: safeResource(
            UIImage(
                systemName: "lock")?
                .withTintColor(safeResource(UIColor(named: "GrayAcent")), renderingMode: .alwaysOriginal)),
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

    private lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = safeResource(UIColor(named: "GrayAcent"))

        label.textAlignment = .right
        return label
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(safeResource(UIColor(named: "LoginButton")), for: .normal)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

        return button
    }()

    private lazy var signUpStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [signUpLabel, signUpButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTextField.layer.cornerRadius = emailTextField.frame.height / 2
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height / 2
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
    }

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
        view.addSubview(socialLoginView)
        view.addSubview(signUpStackView)

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
        signUpLabel.text = "Don't have an account?"
    }

    private func setupConstraints() {
        emailTextField.snp.remakeConstraints { make in
            make.height.equalTo(40)
        }

        passwordTextField.snp.remakeConstraints { make in
            make.height.equalTo(emailTextField)
        }

        loginButton.snp.remakeConstraints { make in
            make.height.equalTo(emailTextField)
        }


        loginLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(forOrientation(portrait: 100, landscape: 0))
        }


        inputStackView.snp.remakeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(forOrientation(portrait: 60, landscape: 20))

            make.left.right.equalTo(view).inset(forOrientation(portrait: 60, landscape: 150))
        }

        buttonStackView.snp.remakeConstraints { make in
            make.top.equalTo(inputStackView.snp.bottom).offset(forOrientation(portrait: 45, landscape: 5))
            make.left.right.equalTo(inputStackView)
        }


        socialLoginView.snp.remakeConstraints { make in
            make.left.right.equalTo(inputStackView)
            make.bottom.equalTo(signUpStackView.snp.top).offset(forOrientation(portrait: -30, landscape: 0))
        }

        signUpStackView.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(forOrientation(portrait: 30, landscape: 0))
        }

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

    // MARK: - Functions
    /// Проверяет, является ли данная строка действительным адресом электронной почты.
    ///
    /// - Parameter email: Строка для проверки.
    /// - Returns: `true` если строка соответствует формату электронной почты, иначе `false`.
    func isValidEmail(_ email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
}

