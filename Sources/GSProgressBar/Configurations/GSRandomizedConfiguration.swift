//
//  File.swift
//  
//
//  Created by Dor Ditchi on 31/12/2023.
//

import Foundation

public struct GSRandomizedConfiguration {
    public let sectionsRange: ClosedRange<Int>
    public let durationRange: ClosedRange<Double>
    public let sectionsDelay: GSRandomizedDelay
    
    public init(sectionsRange: ClosedRange<Int>, durationRange: ClosedRange<Double>, sectionsDelay: GSRandomizedDelay) {
        self.sectionsRange = sectionsRange
        self.durationRange = durationRange
        self.sectionsDelay = sectionsDelay
    }
}
