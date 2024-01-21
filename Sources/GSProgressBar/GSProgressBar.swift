// The Swift Programming Language
// https://docs.swift.org/swift-book


import SwiftUI
import Combine

public struct GSManualProgressBar: View {
    private let type: GSProgressBarType
    @Binding var progress: CGFloat
    
    public init(type: GSProgressBarType,
                progress: Binding<CGFloat>) {
        self.type = type
        _progress = progress
    }
    
    public var body: some View {
        switch type {
        case .linear:
            EmptyView()
        case .circular:
            GSCircularProgressBar(progress: $progress)
                
        case .customPath:
            EmptyView()
        }
    }
}


public struct GSProgressBar: View, Equatable {
    private let progressUpdater: GSProgressUpdater?
    private let type: GSProgressBarType
    private let animationType: GSAnimationType
    @Binding private var play: Bool
    
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
    @Binding private var play: Bool
    
    @State private var animationTicker: Timer.TimerPublisher = .init(interval: 1/60, runLoop: .main, mode: .common)
    @State private var sectionDelayTask: DispatchWorkItem?

    @State private var currentSection: GSProgressSectionMetadata
    @State private var animationTickerCancellable: Cancellable?
    
    @State private var currentSectionIndex: Int = 0
    @State private var nextStopValue: CGFloat = 0.0
    
    @State private var progress: CGFloat = 0.0 {
        didSet {
            progressUpdater?(progress)
        }
    }

    private var advancementDelta: CGFloat {
        currentSection.sectionProportionValue/(60.0*currentSection.duration)
    }
    
    init(type: GSProgressBarType,
         animationType: GSAnimationType,
         progressUpdater: GSProgressUpdater? = nil,
         play: Binding<Bool>) {
        self.type = type
        self.configuration = .init(progressAnimationConfiguration: animationType)
        self.progressUpdater = progressUpdater
        _play = play
        _currentSection = State(initialValue:configuration.sectionsDurations[0])
        _nextStopValue = State(initialValue:currentSection.sectionProportionValue)
    }
    
    var body: some View {
        switch type {
        case .linear:
            EmptyView()
        case .circular:
            GSCircularProgressBar(progress: $progress)
                .onAppear{
                    play ? start() : pause()
                }
                .onChange(of: play) { newValue in
                    newValue ? start() : pause()
                }
                .onReceive(animationTicker) { _ in
                    guard progress < nextStopValue else {
                        progress = nextStopValue
                        sectionDelay()
                        return
                    }
                    withAnimation {
                        progress += advancementDelta
                    }
                }
        case .customPath:
            EmptyView()
        }
    }
    
    private func updateSection() {
        currentSectionIndex += 1
        guard currentSectionIndex < configuration.sectionsDurations.count else { pause(); return }
        currentSection = configuration.sectionsDurations[currentSectionIndex]
        nextStopValue += currentSection.sectionProportionValue
    }
    
    private func sectionDelay() {
        guard currentSection.sectionDelay > 0 else { updateSection(); return }
        pause()

        sectionDelayTask = DispatchWorkItem {
            updateSection()
            connect()
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + currentSection.sectionDelay, execute: sectionDelayTask!)
    }

    private func connect() {
        animationTicker = .init(interval: 1/60, runLoop: .main, mode: .common)
        animationTickerCancellable = animationTicker.connect()
    }
    
    private func start() {
        connect()
    }
    
    private func pause() {
        sectionDelayTask?.cancel()
        animationTickerCancellable?.cancel()
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
