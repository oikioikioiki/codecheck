//
//  Extensions.swift
//  iOSEngineerCodeCheck
//
//  Created by ふりかけ on R 5/09/22.
//  Copyright © Reiwa 5 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

extension UIViewController {
    
    @objc func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UILabel {
    
    func setText(_ prefix: String = "", with: Any?, final: String = "") {
        
        switch with {
        case let stringValue as String:
            self.text = prefix + (stringValue) + final
            break
        case let intValue as Int:
            self.text = prefix + "\(intValue)" + final
            break
        case let floatValue as Float:
            self.text = prefix + "\(floatValue)" + final
            break
        case .none, .some(_):
            self.text = prefix + final
            break
        }
    }
    
    func setText(_ text: Any?, with: String = "") {
        
        switch text {
        case let stringValue as String:
            self.text = (stringValue) + with
            break
        case let intValue as Int:
            self.text = "\(intValue)" + with
            break
        case let floatValue as Float:
            self.text = "\(floatValue)" + with
            break
        case .none, .some(_):
            self.text = with
            break
        }
    }
    
    func setText(_ text: String?) {
        self.text = text ?? ""
    }

    func setText(_ intValue: Int?) {
        self.text = "\(intValue ?? 0)"
    }
}

extension Encodable {

    var json: Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
    
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

extension Decodable {

    static func decode(json data: Data?) -> Self? {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(Self.self, from: data)
    }
}

extension UIButton {
    func applyGradient(colors: [CGColor]) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.frame.height/2

        gradientLayer.shadowColor = UIColor.darkGray.cgColor
        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        gradientLayer.shadowRadius = 5.0
        gradientLayer.shadowOpacity = 0.3
        gradientLayer.masksToBounds = false

        self.layer.insertSublayer(gradientLayer, at: 0)
        self.contentVerticalAlignment = .center
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        self.titleLabel?.textColor = UIColor.white
    }
}

extension UIView {
    func applyGradient(colors: [CGColor], roundedCorners: UIRectCorner? = nil, blurEffectStyle: UIBlurEffect.Style? = nil) {

        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds

        gradientLayer.shadowColor = UIColor.darkGray.cgColor
        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        gradientLayer.shadowRadius = 5.0
        gradientLayer.shadowOpacity = 0.3
        gradientLayer.masksToBounds = false

        self.layer.insertSublayer(gradientLayer, at: 0)

        if let corners = roundedCorners {
            let maskPath = UIBezierPath(roundedRect: self.bounds,
                                        byRoundingCorners: corners,
                                        cornerRadii: CGSize(width: 10.0, height: 10.0)) // 設定圓角的半徑
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = maskPath.cgPath
            self.layer.mask = maskLayer
        }

        if let blurStyle = blurEffectStyle {
            let blurEffect = UIBlurEffect(style: blurStyle)
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.frame = self.bounds
            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.addSubview(blurView)
            self.sendSubviewToBack(blurView)
        }
    }
}
