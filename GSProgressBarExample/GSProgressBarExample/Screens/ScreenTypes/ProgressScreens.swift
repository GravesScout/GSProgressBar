//
//  ProgressScreens.swift
//  GSProgressBarExample
//
//  Created by Dor Ditchi on 21/01/2024.
//

import Foundation
import GSProgressBar

enum ProgressScreens: Hashable {
    case manual(progressType: GSProgressBarType)
    case linear(progressType: GSProgressBarType)
    case sectioned(progressType: GSProgressBarType)
    case randomizedNoDelay(progressType: GSProgressBarType)
    case randomizedConstantDelay(progressType: GSProgressBarType)
    case randomizedRandomDelay(progressType: GSProgressBarType)
    
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
    
    var progressType: GSProgressBarType {
        switch self {
        case .manual(let progressType):
            return progressType
        case .linear(let progressType):
            return progressType
        case .sectioned(let progressType):
            return progressType
        case .randomizedNoDelay(let progressType):
            return progressType
        case .randomizedConstantDelay(let progressType):
            return progressType
        case .randomizedRandomDelay(let progressType):
            return progressType
        }
    }
}
