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

public enum GSRandomizedDelay {
    case noDelay
    case constantDelay(delay: CGFloat)
    case randomizedDelay(delayRange: ClosedRange<CGFloat>)
}

public enum GSAnimationType {
    case linear(duration: CGFloat)
    case sectioned(sections: [GSProgressSectionMetadata])
    case randomized(configuration: GSRandomizedConfiguration)
}

public struct GSRandomizedConfiguration {
    public let sectionsRange: ClosedRange<Int>
    public let durationRange: ClosedRange<Double>
    public let sectionsDelay: GSRandomizedDelay
}

public struct GSProgressBar: View {
    private var progressUpdater: GSProgressUpdater?
    private let type: GSProgressBarType
    private let configuration: GSProgressBarConfiguration
    
    @State private var animationTicker: Timer.TimerPublisher = .init(interval: 1/60, runLoop: .main, mode: .common)
    @State private var sectionDelayTask: DispatchWorkItem?

    @State private var currentSection: GSProgressSectionMetadata
    @State private var animationTickerCancellable: Cancellable?

    @State private var currentSectionIndex: Int = 0
    @State private var progress: CGFloat = 0.0 {
        didSet {
            progressUpdater?(progress)
        }
    }
    @State private var nextStopValue: CGFloat = 0.0
    
    private var advancementDelta: CGFloat {
        currentSection.sectionProportionValue/(60.0*currentSection.duration)
    }
    
    public init(type: GSProgressBarType, 
                animationType: GSAnimationType,
                progressUpdater: GSProgressUpdater? = nil
    ) {
        self.type = type
        self.configuration = .init(progressAnimationConfiguration: animationType)
        _currentSection = State(initialValue:configuration.sectionsDurations[0])
        _nextStopValue = State(initialValue:currentSection.sectionProportionValue)
        self.progressUpdater = progressUpdater
    }

    
    public var body: some View {
        ZStack {
            Circle()
                .stroke(.gray,lineWidth: 16)
                .shadow(color:.blue, radius: 5)
            Circle()
                .trim(from: 0, to: progress)
                .rotation(.degrees(-90))
                .stroke(.blue, style: StrokeStyle(lineWidth: 14, lineCap: .round))
            
        }
        .onAppear {
            connect()
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
    
    public func nextSection() {
        updateSection()
    }
    
    public func start() {
        connect()
    }
    
    public func pause() {
        sectionDelayTask?.cancel()
        animationTickerCancellable?.cancel()
    }
}

#Preview("Linear") {
    GSProgressBar(type: .circular, animationType: .linear(duration: 5))
    .frame(width: 150, height: 150)
}
#Preview("Sectioned") {
    GSProgressBar(type: .circular, animationType: .sectioned(sections: [
        .init(duration: 3, sectionProportionValue: 0.3, sectionDelay: 2),
            .init(duration: 1.5, sectionProportionValue: 0.6, sectionDelay: 4),
            .init(duration: 5, sectionProportionValue: 0.1)]))
    .frame(width: 150, height: 150)
}
#Preview("Randomized no delay") {
    GSProgressBar(type: .circular, animationType: .randomized(configuration: .init(sectionsRange: 5...8, durationRange: 1...5, sectionsDelay: .noDelay)))
    .frame(width: 150, height: 150)
}
#Preview("Randomized constant delay") {
    GSProgressBar(type: .circular, animationType: .randomized(configuration: .init(sectionsRange: 5...8, durationRange: 1...5, sectionsDelay: .constantDelay(delay: 1.2))))
    .frame(width: 150, height: 150)
    
}
#Preview("Randomized random delay") {
    GSProgressBar(type: .circular, animationType: .randomized(configuration: .init(sectionsRange: 5...8, durationRange: 1...5, sectionsDelay: .randomizedDelay(delayRange: 0.4...5))))
    
    .frame(width: 150, height: 150)
}
