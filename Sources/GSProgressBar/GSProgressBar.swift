// The Swift Programming Language
// https://docs.swift.org/swift-book


import SwiftUI
import Combine

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

public struct GSProgressBar: View, Equatable {
    private let progressUpdater: GSProgressUpdater?
    private let type: GSProgressBarType
    private let animationType: GSAnimationType
    @Binding var play: Bool
    public init(type: GSProgressBarType,
                animationType: GSAnimationType,
                play: Binding<Bool>,
                progressUpdater: GSProgressUpdater? = nil) {
        self.type = type
        self.animationType = animationType
        self.progressUpdater = progressUpdater
        _play = play
    }
    
    public var body: some View {
        GSProgressBarWrapper(type: type, animationType: animationType, progressUpdater: progressUpdater, play: $play)
    }
    
    public static func == (lhs: GSProgressBar, rhs: GSProgressBar) -> Bool {
        return true
    }
}

struct GSProgressBarWrapper: View {
    private let progressUpdater: GSProgressUpdater?
    private let type: GSProgressBarType
    private let configuration: GSProgressBarConfiguration
    @Binding var play: Bool
    
    public init(type: GSProgressBarType,
                animationType: GSAnimationType,
                progressUpdater: GSProgressUpdater? = nil,
                play: Binding<Bool>) {
        self.type = type
        self.configuration = .init(progressAnimationConfiguration: animationType)
        self.progressUpdater = progressUpdater
        _play = play
    }
    
    var body: some View {
        switch type {
        case .linear:
            EmptyView()
        case .circular:
            GSCircularProgressBar(configuration: configuration, progressUpdater: progressUpdater, play: $play)
        case .customPath:
            EmptyView()
        }
    }
}

#Preview("Linear") {
    GSProgressBar(type: .circular, animationType: .linear(duration: 5), play: .constant(true))
    .frame(width: 150, height: 150)
}
#Preview("Sectioned") {
    GSProgressBar(type: .circular, animationType: .sectioned(sections: [
        .init(duration: 3, sectionProportionValue: 0.3, sectionDelay: 2),
            .init(duration: 1.5, sectionProportionValue: 0.6, sectionDelay: 4),
            .init(duration: 5, sectionProportionValue: 0.1)]), play: .constant(true))
    .frame(width: 150, height: 150)
}
#Preview("Randomized no delay") {
    GSProgressBar(type: .circular, animationType: .randomized(configuration: .init(sectionsRange: 2...2, durationRange: 1...5, sectionsDelay: .noDelay)), play: .constant(true))
    .frame(width: 150, height: 150)
}
#Preview("Randomized constant delay") {
    GSProgressBar(type: .circular, animationType: .randomized(configuration: .init(sectionsRange: 5...8, durationRange: 1...5, sectionsDelay: .constantDelay(delay: 1.2))), play: .constant(true))
    .frame(width: 150, height: 150)
    
}
#Preview("Randomized random delay") {
    GSProgressBar(type: .circular, animationType: .randomized(configuration: .init(sectionsRange: 5...8, durationRange: 1...5, sectionsDelay: .randomizedDelay(delayRange: 0.4...5))), play: .constant(true))
    
    .frame(width: 150, height: 150)
}
