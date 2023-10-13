//
//  SocialLoginView.swift
//  iOS_Login
//
//  Created by Roman on 12.10.2023.
//

import UIKit

class SocialLoginView: UIView {

    // MARK: - Components
    private lazy var connectLabel: UILabel = {
        let label = UILabel()
        label.text = "or Connect with"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = safeResource(UIColor(named: "GrayAcent"))

        label.textAlignment = .center
        return label
    }()

    private lazy var twitterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = safeResource(UIColor(named: "Twitter"))
        button.layer.cornerRadius = 35 / 2
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

        return button
    }()

    private lazy var facebookButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = safeResource(UIColor(named: "Facebook"))
        button.layer.cornerRadius = 35 / 2
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

        return button
    }()

    private let leftLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()

    private let rightLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()

    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()

    // MARK: - Initial
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Setup
    private func setupUI() {
        setupHierarchy()
        setupConstraints()
        setupComponents()
        setupText()

    }

    private func setupHierarchy() {
        addSubview(connectLabel)
        addSubview(leftLine)
        addSubview(rightLine)
        addSubview(buttonStackView)

        buttonStackView.addArrangedSubview(facebookButton)
        buttonStackView.addArrangedSubview(twitterButton)

    }

    private func setupComponents() {

    }

    private func setupText() {
        connectLabel.text = "or connect with"
        twitterButton.setTitle("Twitter", for: .normal)
        facebookButton.setTitle("Facebook", for: .normal)

    }

    private func setupConstraints() {
        connectLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }

        leftLine.snp.makeConstraints { make in
            make.centerY.equalTo(connectLabel)
            make.right.equalTo(connectLabel.snp.left).offset(-8)
            make.left.equalToSuperview()
            make.height.equalTo(1)
        }

        rightLine.snp.makeConstraints { make in
            make.centerY.equalTo(connectLabel)
            make.left.equalTo(connectLabel.snp.right).offset(8)
            make.right.equalToSuperview()
            make.height.equalTo(1)
        }

        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(connectLabel.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(35)
        }

        twitterButton.snp.makeConstraints { make in
            make.width.equalTo(facebookButton)
        }
    }

    @objc func buttonTapped(_ sender: UIButton) {
        if let buttonTitle = sender.currentTitle {
            NotificationManager.shared.sendNotification(withTitle: "Кнопка '\(buttonTitle)' была нажата!")
            }
    }

}
