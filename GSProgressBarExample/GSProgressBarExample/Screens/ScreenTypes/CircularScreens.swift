//
//  CircularScreens.swift
//  GSProgressBarExample
//
//  Created by Dor Ditchi on 21/01/2024.
//

import Foundation
import GSProgressBar

enum CircularScreens {
    case manual
    case linear
    case sectioned
    case randomizedNoDelay
    case randomizedConstantDelay
    case randomizedRandomDelay
    
    var animationType: GSAnimationType {
        switch self {
        case .manual:
            return .linear(duration: 0)
        case .linear:
            return .linear(duration: 5)
        case .sectioned:
            return .sectioned(
                sections: [
                    .init(duration: 3, sectionProportionValue: 0.3, sectionDelay: 2),
                    .init(duration: 1.5, sectionProportionValue: 0.6, sectionDelay: 4),
                    .init(duration: 5, sectionProportionValue: 0.1)])
        case .randomizedNoDelay:
            return .randomized(configuration: .init(
                sectionsRange: 5...8,
                durationRange: 1...5,
                sectionsDelay: .noDelay))
        case .randomizedConstantDelay:
                return .randomized(configuration: .init(
                    sectionsRange: 5...8,
                    durationRange: 1...5,
                    sectionsDelay: .constantDelay(delay: 1.2)))
        case .randomizedRandomDelay:
                return .randomized(configuration: .init(
                    sectionsRange: 5...8,
                    durationRange: 1...5,
                    sectionsDelay: .randomizedDelay(delayRange: 0.4...5)))
        }
    }
}
