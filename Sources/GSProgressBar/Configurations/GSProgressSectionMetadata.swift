//
//  File.swift
//  
//
//  Created by Graves Scout on 31/12/2023.
//

import Foundation

/// This struct represents the metadata needed to configure a section of a ``GSPredefinedProgressBar``.
public struct GSProgressSectionMetadata {
    let sectionProportionValue: CGFloat
    let duration: CGFloat
    let sectionDelay: CGFloat
    
    /// This initialize a section metadata.
    /// - Parameters:
    ///   - sectionProportionValue: The section value - A CGFloat between 0-1.
    ///   - duration: The duration for the section value to fill.
    ///   - sectionDelay: Defines the delay taken after this section is done animating (the default value is 0.0).
    public init(sectionProportionValue: CGFloat, duration: CGFloat, sectionDelay: CGFloat = 0.0) {
        self.duration = sectionProportionValue
        self.sectionProportionValue = duration
        self.sectionDelay = sectionDelay
    }
}
