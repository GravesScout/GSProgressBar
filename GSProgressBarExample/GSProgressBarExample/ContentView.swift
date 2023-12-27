//
//  ContentView.swift
//  GSProgressBarExample
//
//  Created by Dor Ditchi on 21/12/2023.
//

import SwiftUI
import GSProgressBar

struct ContentView: View {
    @State var progress: CGFloat = 0.0
    var body: some View {
        ZStack {
            GSProgressBar(type: .circular, animationType: .sectioned(sections: [
                .init(duration: 3, sectionProportionValue: 0.3, sectionDelay: 2),
                    .init(duration: 1.5, sectionProportionValue: 0.6, sectionDelay: 4),
                    .init(duration: 5, sectionProportionValue: 0.1)]))
            { updatedProgress in
                    progress = updatedProgress
                }
            .frame(width: 150, height: 150)
            Text("\(progress)")
        }
        .padding()
    }
}

enum CircularScreens {
    case linear
    case sectioned
    case randomizedNoDelay
    case randomizedConstantDelay
    case randomizedRandomDelay
}

enum LoadersScreens {
    case circular
}

struct ContentView2: View {
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
//    init(){
//        print("In Init!")
//    }
    var body: some View {
        List {
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
            case .linear:
                CircularScreen()
            case .sectioned:
                ZStack {
                    GSProgressBar(type: .circular, animationType: .sectioned(sections: [
                        .init(duration: 3, sectionProportionValue: 0.3, sectionDelay: 2),
                        .init(duration: 1.5, sectionProportionValue: 0.6, sectionDelay: 4),
                        .init(duration: 5, sectionProportionValue: 0.1)])) { updatedProgress in
                            progress = updatedProgress
                        }
                    .frame(width: 150, height: 150)
                    Text("\(progress)")
                }
            case .randomizedNoDelay:
                ZStack {
                    GSProgressBar(type: .circular, animationType: .randomized(configuration: .init(sectionsRange: 5...8, durationRange: 1...5, sectionsDelay: .noDelay))){ updatedProgress in
                        progress = updatedProgress
                    }
                        .frame(width: 150, height: 150)
                    Text("\(progress)")
                }
            case .randomizedConstantDelay:
                ZStack {
                    GSProgressBar(type: .circular, animationType: .randomized(configuration: .init(sectionsRange: 5...8, durationRange: 1...5, sectionsDelay: .constantDelay(delay: 1.2)))){ updatedProgress in
                        progress = updatedProgress
                    }
                        .frame(width: 150, height: 150)
                    Text("\(progress)")
                }
            case .randomizedRandomDelay:
                ZStack {
                    GSProgressBar(type: .circular, animationType: .randomized(configuration: .init(sectionsRange: 5...8, durationRange: 1...5, sectionsDelay: .randomizedDelay(delayRange: 0.4...5)))) { updatedProgress in
                            progress = updatedProgress
                        }
                        .frame(width: 150, height: 150)
                    Text("\(progress)")
                }
            }
        }
    }
}

struct CircularScreen: View {
    @State var progress: CGFloat = 0.0
    init(){
        print("In Init!")
    }
    var body: some View {
        ZStack {
            GSProgressBar(type: .circular, animationType: .linear(duration: 5)) { updatedProgress in
                progress = updatedProgress
            }
            .frame(width: 150, height: 150)
            Text("\(progress)")
        }
    }
}
#Preview {
    ContentView2()
}
