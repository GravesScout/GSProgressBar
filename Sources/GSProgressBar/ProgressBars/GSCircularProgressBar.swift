//
//  SwiftUIView.swift
//  
//
//  Created by Dor Ditchi on 27/12/2023.
//

import SwiftUI
import Combine

struct GSCircularProgressBar: View {
    private var configuration: GSProgressBarConfiguration
    
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
    
    var progressUpdater: GSProgressUpdater?
    @Binding var play: Bool

    init(configuration: GSProgressBarConfiguration,
         progressUpdater: GSProgressUpdater?,
         play: Binding<Bool>) {
        self.configuration = configuration
        _play = play
        _currentSection = State(initialValue:configuration.sectionsDurations[0])
        _nextStopValue = State(initialValue:currentSection.sectionProportionValue)
        self.progressUpdater = progressUpdater
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.gray,lineWidth: 16)
                .shadow(color:.blue, radius: 5)
            Circle()
                .trim(from: 0, to: progress)
                .rotation(.degrees(-90))
                .stroke(.blue, style: StrokeStyle(lineWidth: 14, lineCap: .round))
            
        }
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
    
    public func start() {
        connect()
    }
    
    public func pause() {
        sectionDelayTask?.cancel()
        animationTickerCancellable?.cancel()
    }
}

#Preview {
    SwiftUIView()
}
