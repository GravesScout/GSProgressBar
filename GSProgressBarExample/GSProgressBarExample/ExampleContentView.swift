//
//  ExampleContentView.swift
//  GSProgressBarExample
//
//  Created by Dor Ditchi on 21/12/2023.
//

import SwiftUI
import GSProgressBar

enum CircularScreens {
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
}

enum LoadersScreens {
    case circular
}

struct ExampleContentView: View {
    @State var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            List {
                NavigationLink(value: LoadersScreens.circular) {
                    Text("Circular loader")
                }
            }
            .navigationDestination(for: LoadersScreens.self) { screen in
                switch screen {
                case .circular:
                    CircularScreensView()
                }
            }
        }
    }
}


struct CircularScreensView: View {
    @State var progress: CGFloat = 0.0
    @State var play: Bool = true
    var body: some View {
        List {
            NavigationLink(value: CircularScreens.manual) {
                Text("Manual loading")
            }
            NavigationLink(value: CircularScreens.linear) {
                Text("Linear loading")
            }
            NavigationLink(value: CircularScreens.sectioned) {
                Text("Sectioned loading")
            }
            NavigationLink(value: CircularScreens.randomizedNoDelay) {
                Text("Randomized no delay loading")
            }
            NavigationLink(value: CircularScreens.randomizedConstantDelay) {
                Text("Randomized constant delay loading")
            }
            NavigationLink(value: CircularScreens.randomizedRandomDelay) {
                Text("Randomized random delay loading")
            }
        }
        .navigationDestination(for: CircularScreens.self) { screen in
            switch screen {
            case .manual:
                ManualCircularScreen()
            default:
                CircularScreen(animationType: screen.animationType)
            }
        }
    }
}


struct ManualCircularScreen: View {
    @State private var progress: CGFloat = 0.0
    
    var body: some View {
        VStack(spacing: 40) {
            ZStack {
                GSManualProgressBar(type: .circular,
                                    trackLineWidth: 16,
                                    fillLineWidth: 14,
                                    progress: $progress)
                .frame(width: 150, height: 150)
                Text("\(progress)")
            }
            VStack(spacing: 10) {
                Text("\(progress)")
                
                Slider(value: $progress, in: 0...1) {
                    Text("\(progress)")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("1")
                }
            }

        }
    }
}

struct CircularScreen: View {
    @State var progress: CGFloat = 0.0
    @State var play: Bool = true
    var animationType: GSAnimationType
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                GSProgressBar(type: .circular,
                              animationType: animationType,
                              trackLineWidth: 16,
                              fillLineWidth: 14,
                              play: $play) { updatedProgress in
                    progress = updatedProgress
                }
                              .frame(width: 150, height: 150)
                Text("\(progress)")
            }
            Button(play ? "Pause" : "Play") {
                play.toggle()
            }
        }
    }
}
#Preview {
    ExampleContentView()
}
