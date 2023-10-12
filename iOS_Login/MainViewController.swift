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

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTextField.layer.cornerRadius = emailTextField.frame.height / 2
        passwordTextField.layer.cornerRadius = emailTextField.frame.height / 2

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

        view.addSubview(sinBackground)
        view.sendSubviewToBack(sinBackground)

        view.addSubview(sinBackgroundBack)
        view.sendSubviewToBack(sinBackgroundBack)

        inputStackView.addArrangedSubview(emailTextField)
        inputStackView.addArrangedSubview(passwordTextField)
    }

    private func setupComponents() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)

    }

    private func setupText() {
        loginLabel.text = "Login"

    }

    private func setupConstraints() {
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.centerX.equalTo(view)
        }

        inputStackView.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(30)
            make.left.right.equalTo(view).inset(UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 80))
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }


    }
    // MARK: - Update
    // MARK: - Actions
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Functions

}

