//
//  ExampleContentView.swift
//  GSProgressBarExample
//
//  Created by Dor Ditchi on 21/12/2023.
//

import SwiftUI
import GSProgressBar

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
                PredefinedCircularScreen(animationType: screen.animationType)
            }
        }
    }
}

#Preview {
    ExampleContentView()
}
