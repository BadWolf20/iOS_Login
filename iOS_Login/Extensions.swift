//
//  Extensions.swift
//  iOS_Login
//
//  Created by Roman on 12.10.2023.
//

import UIKit

extension UITextField {
    enum IconSide {
        case left
        case right

    }

    func setIcon(image: UIImage, side: IconSide) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        let iconView = UIView(frame: CGRect(x: 0, y: 0,
                                                width: imageView.frame.width + 20,
                                                height: imageView.frame.height))
        iconView.addSubview(imageView)
        switch side {
        case .left:
            leftView = iconView
            leftViewMode = .always
        case .right:
            rightView = iconView
            rightViewMode = .always
        }
    }
}

extension UIViewController {
    func safeResource<T>(_ resource: T?) -> T where T: AnyObject {
        switch T.self {
        case is UIImage.Type:
            if let image = resource {
                return image
            } else {
                print("Ошибка: не удалось загрузить изображение. Возвращение дефолтного изображения.")
                return UIImage(named: "DefaultImage") as! T
            }

        case is UIColor.Type:
            if let color = resource {
                return color
            } else {
                print("Ошибка: не удалось загрузить цвет. Возвращение дефолтного цвета.")
                return UIColor(named: "DefaultColor") as! T
            }

        default:
            fatalError("Тип \(T.self) не поддерживается.")
        }
    }
}

extension UIView {
    func safeResource<T>(_ resource: T?) -> T where T: AnyObject {
        switch T.self {
        case is UIImage.Type:
            if let image = resource {
                return image
            } else {
                print("Ошибка: не удалось загрузить изображение. Возвращение дефолтного изображения.")
                return UIImage(named: "DefaultImage") as! T
            }

        case is UIColor.Type:
            if let color = resource {
                return color
            } else {
                print("Ошибка: не удалось загрузить цвет. Возвращение дефолтного цвета.")
                return UIColor(named: "DefaultColor") as! T
            }

        default:
            fatalError("Тип \(T.self) не поддерживается.")
        }
    }
}
