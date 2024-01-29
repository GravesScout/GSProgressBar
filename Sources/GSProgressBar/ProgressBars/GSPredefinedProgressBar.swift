//
//  GSPredefinedProgressBar.swift
//
//
//  Created by Dor Ditchi on 29/01/2024.
//

import SwiftUI

public struct GSPredefinedProgressBar: View, Equatable {
    public let type: GSProgressBarType
    public let animationType: GSAnimationType
    public let trackLineWidth: CGFloat
    public let fillLineWidth: CGFloat
    @Binding public var play: Bool
    var trackColor: Color
    var progressColor: Color
    var shadowColor: Color
    let showShadow: Bool
    public var progressUpdater: GSProgressUpdater? = .none
    
    public init(type: GSProgressBarType,
                animationType: GSAnimationType,
                trackLineWidth: CGFloat,
                fillLineWidth: CGFloat,
                showShadow: Bool,
                play: Binding<Bool>,
                trackColor: Color = .gray,
                progressColor: Color = .blue,
                shadowColor: Color = .blue,
                progressUpdater: GSProgressUpdater? = nil) {
        self.type = type
        self.animationType = animationType
        self.trackLineWidth = trackLineWidth
        self.fillLineWidth = fillLineWidth
        self.progressUpdater = progressUpdater
        self.trackColor = trackColor
        self.progressColor = progressColor
        self.shadowColor = shadowColor
        self.showShadow = showShadow
        _play = play
    }
    
    public var body: some View {
        GSProgressBarWrapper(type: type,
                             animationType: animationType,
                             progressUpdater: progressUpdater,
                             play: $play,
                             trackLineWidth: trackLineWidth,
                             fillLineWidth: fillLineWidth,
                             trackColor: trackColor,
                             progressColor: progressColor,
                             shadowColor: shadowColor,
                             showShadow: showShadow)
    }
    
    public static func == (lhs: GSPredefinedProgressBar, rhs: GSPredefinedProgressBar) -> Bool {
        return true
    }
}


#Preview("Horizontal Linear") {
    GSPredefinedProgressBar(type: .bar,
                  animationType: .linear(duration: 5),
                  trackLineWidth: 16,
                  fillLineWidth: 14,
                  showShadow: true,
                  play: .constant(true),
                  trackColor: .gray,
                  progressColor: .blue,
                  shadowColor: .blue)
    .frame(width: 150)
}

#Preview("Linear") {
    GSPredefinedProgressBar(type: .circular,
                  animationType: .linear(duration: 5),
                  trackLineWidth: 16,
                  fillLineWidth: 14,
                  showShadow: true,
                  play: .constant(true),
                  trackColor: .gray,
                  progressColor: .blue,
                  shadowColor: .blue)
    .frame(width: 150, height: 150)
}
#Preview("Sectioned") {
    GSPredefinedProgressBar(
        type: .circular,
        animationType: .sectioned(
            sections: [
                .init(sectionProportionValue: 3, duration: 0.3, sectionDelay: 2),
                .init(sectionProportionValue: 1.5, duration: 0.6, sectionDelay: 4),
                .init(sectionProportionValue: 5, duration: 0.1)]),
        trackLineWidth: 16,
        fillLineWidth: 14,
        showShadow: true,
        play: .constant(true),
        trackColor: .gray,
        progressColor: .blue,
        shadowColor: .blue)
    .frame(width: 150, height: 150)
}
#Preview("Randomized no delay") {
    GSPredefinedProgressBar(type: .circular,
                  animationType: .randomized(configuration: .init(sectionsRange: 2...2, durationRange: 1...5, sectionsDelay: .noDelay)),
                  trackLineWidth: 16,
                  fillLineWidth: 14,
                  showShadow: true,
                  play: .constant(true),
                  trackColor: .gray,
                  progressColor: .blue,
                  shadowColor: .blue)
    .frame(width: 150, height: 150)
}
#Preview("Randomized constant delay") {
    GSPredefinedProgressBar(type: .circular,
                  animationType: .randomized(configuration: .init(sectionsRange: 5...8, durationRange: 1...5, sectionsDelay: .constantDelay(delay: 1.2))),
                  trackLineWidth: 16,
                  fillLineWidth: 14,
                  showShadow: true,
                  play: .constant(true),
                  trackColor: .gray,
                  progressColor: .blue,
                  shadowColor: .blue)
    .frame(width: 150, height: 150)
    
}
#Preview("Randomized random delay") {
    GSPredefinedProgressBar(type: .circular,
                  animationType: .randomized(configuration: .init(sectionsRange: 5...8, durationRange: 1...5, sectionsDelay: .randomizedDelay(delayRange: 0.4...5))),
                  trackLineWidth: 16,
                  fillLineWidth: 14,
                  showShadow: true,
                  play: .constant(true),
                  trackColor: .gray,
                  progressColor: .blue,
                  shadowColor: .blue)
    
    .frame(width: 150, height: 150)
}
