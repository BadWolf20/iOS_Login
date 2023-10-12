//
//  SinusoidalView.swift
//  iOS_Login
//
//  Created by Roman on 12.10.2023.
//

import UIKit

/// `SinusoidalView` представляет собой пользовательский `UIView`, который отображает градиент
/// с формой, напоминающей синусоиду
class SinusoidalView: UIView {

    // Амплитуда синусоидальной волны.
    var amplitude: CGFloat = 25

    // Сдвиг фазы для синусоидальной волны.
    var phase: CGFloat = 0

    // Слой градиента, который будет отображать цвета градиента
    private var gradientLayer: CAGradientLayer!

    // Массив, представляющий цвета градиента
    var gradientColors: [CGColor] = [UIColor.blue.cgColor, UIColor.cyan.cgColor]

    // Флаг, определяющий ориентацию градиента: вертикальную или горизонтальную
    var isVerticalGradient: Bool = true {
        didSet {
            setupGradientLayer()
        }
    }

    // MARK: - Initial
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradientLayer()
    }


    // MARK: - Setup
    private func setupGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        if isVerticalGradient {
             gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
             gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
         } else {
             gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
             gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
         }
        layer.addSublayer(gradientLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupGradientLayer()
        gradientLayer.frame = bounds
        let maskLayer = CAShapeLayer()
        maskLayer.path = createSinusoidalPath().cgPath
        gradientLayer.mask = maskLayer

    }

    // MARK: - Functions
    private func createSinusoidalPath() -> UIBezierPath {
        let path = UIBezierPath()
        let startingHeight = bounds.height / 3 * 2

        path.move(to: CGPoint(x: 0, y: startingHeight))

        let width = bounds.width
        for x in stride(from: CGFloat(0), to: width + 1, by: 1) {
            let y: CGFloat = amplitude * sin((2 * .pi * x / width) + phase) + startingHeight
            path.addLine(to: CGPoint(x: x, y: y))
        }

        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.close()

        return path
    }

}
