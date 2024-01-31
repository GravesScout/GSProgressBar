//
//  SwiftLogo.swift
//  GSProgressBarExample
//
//  Created by Graves Scout on 22/01/2024.
//

import SwiftUI

extension Path {
    static var swiftLogo: Path {
        var path = Path()
        let startPoint = CGPoint(x: 0, y: 0.63)
        
        path.move(to: startPoint)
        path.addCurve(
            to: CGPoint(x: 0.98, y: 0.98),
            control1: CGPoint(x: 0.5, y: 1.35),
            control2: CGPoint(x: 0.85, y: 0.67)
        )
        
        path.addQuadCurve(
            to: CGPoint(x: 0.9, y: 0.7),
            control: CGPoint(x: 1.0, y: 0.85)
        )
        
        path.addQuadCurve(
            to: CGPoint(x: 0.61, y: 0),
            control: CGPoint(x: 1.0, y: 0.3)
        )
        
        path.addQuadCurve(
            to: CGPoint(x: 0.7, y: 0.53),
            control: CGPoint(x: 0.78, y: 0.3)
        )
        
        
        path.addQuadCurve(
            to: CGPoint(x: 0.215, y: 0.09),
            control: CGPoint(x: 0.35, y: 0.25)
        )
        
        path.addQuadCurve(
            to: CGPoint(x: 0.5, y: 0.48),
            control: CGPoint(x: 0.3, y: 0.25)
        )
        
        path.addQuadCurve(
            to: CGPoint(x: 0.1, y: 0.15),
            control: CGPoint(x: 0.35, y: 0.4)
        )
        
        path.addQuadCurve(
            to: CGPoint(x: 0.56, y: 0.71),
            control: CGPoint(x: 0.33, y: 0.51)
        )
        
        path.addQuadCurve(
            to: startPoint,
            control: CGPoint(x: 0.3, y: 0.85)
        )
        
        return path
    }
}
