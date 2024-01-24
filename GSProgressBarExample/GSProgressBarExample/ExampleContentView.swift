//
//  ExampleContentView.swift
//  GSProgressBarExample
//
//  Created by Dor Ditchi on 21/12/2023.
//

import SwiftUI
import GSProgressBar

enum LoadersScreens {
    case bar
    case circular
    case customPath
}

struct ExampleContentView: View {
    @State var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            List {
                NavigationLink(value: LoadersScreens.circular) {
                    Text("Circular loader")
                }
                NavigationLink(value: LoadersScreens.bar) {
                    Text("Linear loader")
                }
                NavigationLink(value: LoadersScreens.customPath) {
                    Text("Custom loader")
                }
            }
            .navigationDestination(for: LoadersScreens.self) { screen in
                switch screen {
                case .bar:
                    ProgressScreensView(progressType: .bar)
                case .circular:
                    ProgressScreensView(progressType: .circular)
                case .customPath:
                    ProgressScreensView(progressType: .customPath(path: .swiftLogo))
                }
            }
        }
    }
}


struct ProgressScreensView: View {
    var progressType: GSProgressBarType
    var body: some View {
        List {
            NavigationLink(value: ProgressScreens.manual(progressType: progressType)) {
                Text("Manual loading")
            }
            NavigationLink(value: ProgressScreens.linear(progressType: progressType)) {
                Text("Linear loading")
            }
            NavigationLink(value: ProgressScreens.sectioned(progressType: progressType)) {
                Text("Sectioned loading")
            }
            NavigationLink(value: ProgressScreens.randomizedNoDelay(progressType: progressType)) {
                Text("Randomized no delay loading")
            }
            NavigationLink(value: ProgressScreens.randomizedConstantDelay(progressType: progressType)) {
                Text("Randomized constant delay loading")
            }
            NavigationLink(value: ProgressScreens.randomizedRandomDelay(progressType: progressType)) {
                Text("Randomized random delay loading")
            }
        }
        .navigationDestination(for: ProgressScreens.self) { screen in
            switch screen {
            case .manual:
                ManualProgressScreen(progressType: screen.progressType)
            default:
                PredefinedProgressScreen(animationType: screen.animationType,progressType: screen.progressType)
            }
        }
    }
}

#Preview {
    ExampleContentView()
}
