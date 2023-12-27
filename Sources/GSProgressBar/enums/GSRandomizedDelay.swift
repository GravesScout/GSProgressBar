//
//  File.swift
//  
//
//  Created by Dor Ditchi on 27/12/2023.
//

import Foundation

public enum GSRandomizedDelay {
    case noDelay
    case constantDelay(delay: CGFloat)
    case randomizedDelay(delayRange: ClosedRange<CGFloat>)
}
