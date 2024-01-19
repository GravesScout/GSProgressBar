//
//  File.swift
//  
//
//  Created by Dor Ditchi on 31/12/2023.
//

import Foundation

public struct GSProgressSectionMetadata {
    let duration: CGFloat
    let sectionProportionValue: CGFloat
    let sectionDelay: CGFloat
    
    public init(duration: CGFloat, sectionProportionValue: CGFloat, sectionDelay: CGFloat = 0.0) {
        self.duration = duration
        self.sectionProportionValue = sectionProportionValue
        self.sectionDelay = sectionDelay
    }
}
