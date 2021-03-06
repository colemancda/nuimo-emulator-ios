//
//  LEDView.swift
//  NuimoSimulator
//
//  Created by Lars Blumberg on 2/4/16.
//  Copyright © 2016 Senic GmbH. All rights reserved.
//

import UIKit

@IBDesignable
class LEDView : UIView {
    @IBInspectable
    var columns: Int = 3 { didSet { setNeedsDisplay() } }
    @IBInspectable
    var rows: Int = 3 { didSet { setNeedsDisplay() } }
    @IBInspectable
    var ledSize: CGFloat = 24 { didSet { setNeedsDisplay() } }
    @IBInspectable
    var onColor: UIColor = UIColor(red: 1.0, green: 0.0, blue: 0, alpha: 1) { didSet { setNeedsDisplay() } }
    @IBInspectable
    var offColor: UIColor = UIColor(red: 1.0, green: 0.0, blue: 0, alpha: 0.2) { didSet { setNeedsDisplay() } }
    @IBInspectable
    var leds: [Bool] = [true, true, true, true, true, true, true, true, true] { didSet { setNeedsDisplay() } }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        let horzSpace = columns > 1
            ? (bounds.width - CGFloat(columns) * ledSize) / (CGFloat(columns) - 1.0)
            : 0
        let vertSpace = rows > 1
            ? (bounds.width - CGFloat(rows) * ledSize) / (CGFloat(rows) - 1.0)
            : 0

        (0..<rows).forEach { row in
            (0..<columns).forEach { col in
                context.addEllipse(in: CGRect(x: CGFloat(col) * (ledSize + horzSpace), y: CGFloat(row) * (ledSize + vertSpace), width: ledSize - 1, height: ledSize - 1))
                let ledIndex = row * columns + col
                let color: UIColor = ledIndex < leds.count ? (leds[ledIndex] ? onColor : offColor) : offColor
                context.setFillColor(color.cgColor.components!)
                context.fillPath()
            }
        }
    }
}
