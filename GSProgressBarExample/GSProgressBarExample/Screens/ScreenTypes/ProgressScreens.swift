//
//  ProgressScreens.swift
//  GSProgressBarExample
//
//  Created by Graves Scout on 21/01/2024.
//

import Foundation
import GSProgressBar

enum ProgressScreens: Hashable {
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
                    .init(sectionProportionValue: 3, duration: 0.3, sectionDelay: 2),
                    .init(sectionProportionValue: 1.5, duration: 0.6, sectionDelay: 4),
                    .init(sectionProportionValue: 5, duration: 0.1)])
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
