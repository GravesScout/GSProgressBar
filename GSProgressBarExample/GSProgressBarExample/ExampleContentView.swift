//
//  ExampleContentView.swift
//  GSProgressBarExample
//
//  Created by Graves Scout on 21/12/2023.
//

import SwiftUI
import GSProgressBar

struct ExampleContentView: View {
    @State var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            List {
                NavigationLink(value: ProgressScreens.manual) {
                    Text("Manual loading")
                }
                NavigationLink(value: ProgressScreens.linear) {
                    Text("Linear loading")
                }
                NavigationLink(value: ProgressScreens.sectioned) {
                    Text("Sectioned loading")
                }
                NavigationLink(value: ProgressScreens.randomizedNoDelay) {
                    Text("Randomized no delay loading")
                }
                NavigationLink(value: ProgressScreens.randomizedConstantDelay) {
                    Text("Randomized constant delay loading")
                }
                NavigationLink(value: ProgressScreens.randomizedRandomDelay) {
                    Text("Randomized random delay loading")
                }
            }
            .navigationDestination(for: ProgressScreens.self) { screen in
                switch screen {
                case .manual:
                    ManualProgressScreen()
                default:
                    PredefinedProgressScreen(animationType: screen.animationType)
                }
            }
        }
    }
}

#Preview {
    ExampleContentView()
}
