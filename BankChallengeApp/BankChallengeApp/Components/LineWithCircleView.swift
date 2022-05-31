//
//  LineWithCircleView.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 31/05/22.
//

import UIKit

/// View that contains a vertical line in its center with a circle in its center
class LineWithCircleView: UIView {

    var circleColor = Colors.primaryGreen
    var circleBorderColor = UIColor.white
    var lineColor = Colors.secondaryTitleColor
    var circleRadius = CGFloat(4)

    // MARK: Initialization

    convenience init(circleColor: UIColor,
                     circleBorderColor: UIColor,
                     lineColor: UIColor,
                     circleRadius: CGFloat) {
        self.init(frame: .zero)
        self.circleColor = circleColor
        self.circleBorderColor = circleBorderColor
        self.lineColor = self.lineColor
        self.circleRadius = circleRadius
    }

    // MARK: - Custom Drawing

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        // Drawing white background
        UIColor.white.set()
        context.addRect(CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        context.fillPath()

        // Drawing vertical line
        let linePath = UIBezierPath()

        linePath.move(to: CGPoint(x: self.frame.width / 2.0, y: 0))
        linePath.addLine(to: CGPoint(x: self.frame.width / 2.0, y: self.frame.height))
        linePath.close()
        lineColor.setStroke()
        linePath.lineWidth = 1.0
        linePath.stroke()

        // Drawing circle
        var path = UIBezierPath()
        path = UIBezierPath(ovalIn: CGRect(x: self.frame.width / 2.0 - circleRadius,
                                           y: self.frame.height / 2.0 - circleRadius,
                                           width: circleRadius * 2,
                                           height: circleRadius * 2))
        circleColor.setFill()
        circleBorderColor.setStroke()
        path.lineWidth = 3
        path.stroke()
        path.fill()
    }
}
