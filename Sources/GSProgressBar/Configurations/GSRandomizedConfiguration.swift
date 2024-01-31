//
//  File.swift
//  
//
//  Created by Graves Scout on 31/12/2023.
//

import Foundation

///  This struct configures the ruleset for randomizing the progress of a ``GSPredefinedProgressBar``
public struct GSRandomizedConfiguration {
    public let sectionsRange: ClosedRange<Int>
    public let durationRange: ClosedRange<Double>
    public let sectionsDelay: GSRandomizedDelay
        
    /// This initialize a randomized configuration.
    /// - Parameters:
    ///   - sectionsRange: A closed range to use for randomizing the amount of sections of progress.
    ///   - durationRange: A closed range to use for randomizing the durations of the sections in the progress bar.
    ///   - sectionsDelay: A ``GSRandomizedDelay`` to use for the delays after each section.
    public init(sectionsRange: ClosedRange<Int>, durationRange: ClosedRange<Double>, sectionsDelay: GSRandomizedDelay) {
        self.sectionsRange = sectionsRange
        self.durationRange = durationRange
        self.sectionsDelay = sectionsDelay
    }
}
