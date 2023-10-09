//
//  CircularImageView.swift
//  iOSEngineerCodeCheck
//
//  Created by ふりかけ on R 5/10/10.
//  Copyright © Reiwa 5 YUMEMI Inc. All rights reserved.
//

import UIKit

class CircularImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addCircularMask()
    }
    
    func addCircularMask() {

        let circularPath = UIBezierPath(ovalIn: bounds)
        let maskLayer = CAShapeLayer()
        maskLayer.path = circularPath.cgPath

        layer.mask = maskLayer
    }
}
