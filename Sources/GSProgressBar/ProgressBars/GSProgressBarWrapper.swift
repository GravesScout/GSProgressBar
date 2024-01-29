// The Swift Programming Language
// https://docs.swift.org/swift-book


import SwiftUI
import Combine

struct GSProgressBarWrapper: View {
    private let progressUpdater: GSProgressUpdater?
    private let type: GSProgressBarType
    private let trackLineWidth: CGFloat
    private let fillLineWidth: CGFloat
    @Binding private var play: Bool
    
    @State private var configuration: GSProgressBarConfiguration
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

    var trackColor: Color
    var progressColor: Color
    var shadowColor: Color
    let showShadow: Bool
    
    private var advancementDelta: CGFloat {
        currentSection.sectionProportionValue/(60.0*currentSection.duration)
    }
    
    init(type: GSProgressBarType,
         animationType: GSAnimationType,
         progressUpdater: GSProgressUpdater? = nil,
         play: Binding<Bool>,
         trackLineWidth: CGFloat,
         fillLineWidth: CGFloat,
         trackColor: Color,
         progressColor: Color,
         shadowColor: Color,
         showShadow: Bool) {
        self.type = type
        self.progressUpdater = progressUpdater
        self.trackLineWidth = trackLineWidth
        self.fillLineWidth = fillLineWidth
        self.trackColor = trackColor
        self.progressColor = progressColor
        self.shadowColor = shadowColor
        self.showShadow = showShadow
        
        _play = play
        let configuration: GSProgressBarConfiguration = .init(progressAnimationConfiguration: animationType)
        _configuration = State(initialValue:configuration)
        _currentSection = State(initialValue:configuration.sectionsDurations[0])
        _nextStopValue = State(initialValue:currentSection.sectionProportionValue)
    }
    
    var body: some View {
        switch type {
        case .bar:
            GSLinearProgressBar(progress: $progress,
                                trackLineWidth: trackLineWidth,
                                fillLineWidth: fillLineWidth,
                                cornerRadius: 16,
                                trackColor: trackColor,
                                progressColor: progressColor,
                                shadowColor: shadowColor,
                                showShadow: showShadow)
            .onAppear {
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
        case .circular:
            GSCircularProgressBar(progress: $progress,
                                  trackLineWidth: trackLineWidth,
                                  fillLineWidth: fillLineWidth,
                                  trackColor: trackColor,
                                  progressColor: progressColor,
                                  shadowColor: shadowColor,
                                  showShadow: showShadow)
                .onAppear {
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
        case .customPath(let path):
            GSCustomProgressBar(path:path,
                                progress: $progress,
                                trackLineWidth: trackLineWidth,
                                fillLineWidth: fillLineWidth,
                                trackColor: trackColor,
                                progressColor: progressColor,
                                shadowColor: shadowColor,
                                showShadow: showShadow)
                .onAppear {
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
