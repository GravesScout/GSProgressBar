//
//  File.swift
//  
//
//  Created by Graves Scout on 27/12/2023.
//

import Foundation

/// Constants that specify the possible delay modes for a randomized section.
public enum GSRandomizedDelay {
    case noDelay
    case constantDelay(delay: CGFloat)
    case randomizedDelay(delayRange: ClosedRange<CGFloat>)
}
