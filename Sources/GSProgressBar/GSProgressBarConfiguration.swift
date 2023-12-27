//
//  File.swift
//  
//
//  Created by Dor Ditchi on 27/12/2023.
//

import Foundation

struct GSProgressBarConfiguration {
    let sectionsDurations: [GSProgressSectionMetadata]
    
    init(progressAnimationConfiguration: GSAnimationType) {
        switch progressAnimationConfiguration {
        case .linear(let duration):
            sectionsDurations = [.init(duration: duration, sectionProportionValue: 1.0)]
        case .sectioned(let sections):
            sectionsDurations = sections
        case .randomized(let configuration):
            sectionsDurations = GSProgressBarConfiguration.getRandomizedSections(using: configuration)
        }
    }
    
    private static func getRandomizedSections(using configuration: GSRandomizedConfiguration) -> [GSProgressSectionMetadata] {
        let sections = Int.random(in: configuration.sectionsRange)
        var randomizedResult = [GSProgressSectionMetadata]()
        
        for _ in 0..<sections {
            let duration = Double.random(in: configuration.durationRange)
            switch configuration.sectionsDelay {
            case .noDelay:
                randomizedResult.append(.init(duration: duration, sectionProportionValue: CGFloat(1.0/CGFloat(sections))))
            case .constantDelay(let delay):
                randomizedResult.append(.init(duration: duration, sectionProportionValue: CGFloat(1.0/CGFloat(sections)), sectionDelay: delay))
            case .randomizedDelay(let delayRange):
                randomizedResult.append(.init(duration: duration, sectionProportionValue: CGFloat(1.0/CGFloat(sections)), sectionDelay: CGFloat.random(in: delayRange)))
            }
        }
        return  randomizedResult
    }
}
