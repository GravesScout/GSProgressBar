//
//  PredefinedCircularScreen..swift
//  GSProgressBarExample
//
//  Created by Dor Ditchi on 21/01/2024.
//

import SwiftUI
import GSProgressBar

struct PredefinedProgressScreen: View {
    @State var progress: CGFloat = 0.0
    @State var play: Bool = true
    var animationType: GSAnimationType
    var progressType: GSProgressBarType
    var lineWidth: CGFloat {
        if case .customPath(_) = progressType {
            return 6
        } else {
            return 16
        }
    }
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                GSProgressBar(type: progressType,
                              animationType: animationType,
                              trackLineWidth: lineWidth,
                              fillLineWidth: lineWidth - 2,
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

#Preview("Linear Progress") {
    PredefinedProgressScreen(animationType: ProgressScreens.linear(progressType: .circular).animationType, progressType: .circular)
}
#Preview("Sections Progress") {
    PredefinedProgressScreen(animationType: ProgressScreens.sectioned(progressType: .circular).animationType, progressType: .circular)
}
#Preview("Randomized No Delay Progress") {
    PredefinedProgressScreen(animationType: ProgressScreens.randomizedNoDelay(progressType: .circular).animationType, progressType: .circular)
}
#Preview("Randomized Constant Delay Progress") {
    PredefinedProgressScreen(animationType: ProgressScreens.randomizedConstantDelay(progressType: .circular).animationType, progressType: .circular)
}
#Preview("Randomized + Randomized Delay Progress") {
    PredefinedProgressScreen(animationType: ProgressScreens.randomizedRandomDelay(progressType: .circular).animationType, progressType: .circular)
}
