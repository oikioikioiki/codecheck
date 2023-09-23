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
