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
        
        let randomSections = getRandomDoubles(count:sections, total: 1.0)
        for section in 0..<sections {
            let duration = Double.random(in: configuration.durationRange)
            switch configuration.sectionsDelay {
            case .noDelay:
                randomizedResult.append(.init(duration: duration, sectionProportionValue: CGFloat(randomSections[section])))
            case .constantDelay(let delay):
                randomizedResult.append(.init(duration: duration, sectionProportionValue: CGFloat(randomSections[section]), sectionDelay: delay))
            case .randomizedDelay(let delayRange):
                randomizedResult.append(.init(duration: duration, sectionProportionValue: CGFloat(randomSections[section]), sectionDelay: CGFloat.random(in: delayRange)))
            }
        }
        return  randomizedResult
    }
    
    private static func getRandomDoubles(count: Int, total: Double) -> [Double] {
        var nonNormalized = [Double]()
        nonNormalized.reserveCapacity(count)
        for i in 0..<count {
            nonNormalized.append(Double(arc4random()) / 0xFFFFFFFF)
        }
        let nonNormalizedSum = nonNormalized.reduce(0) { $0 + $1 }
        let normalized = nonNormalized.map { $0 * total / nonNormalizedSum }
        return normalized
    }
}
