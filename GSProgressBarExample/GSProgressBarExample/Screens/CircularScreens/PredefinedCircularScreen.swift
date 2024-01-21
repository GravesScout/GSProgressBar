//
//  PredefinedCircularScreen..swift
//  GSProgressBarExample
//
//  Created by Dor Ditchi on 21/01/2024.
//

import SwiftUI
import GSProgressBar

struct PredefinedCircularScreen: View {
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

#Preview("Linear Progress") {
    PredefinedCircularScreen(animationType: CircularScreens.linear.animationType)
}
#Preview("Sections Progress") {
    PredefinedCircularScreen(animationType: CircularScreens.sectioned.animationType)
}
#Preview("Randomized No Delay Progress") {
    PredefinedCircularScreen(animationType: CircularScreens.randomizedNoDelay.animationType)
}
#Preview("Randomized Constant Delay Progress") {
    PredefinedCircularScreen(animationType: CircularScreens.randomizedConstantDelay.animationType)
}
#Preview("Randomized + Randomized Delay Progress") {
    PredefinedCircularScreen(animationType: CircularScreens.randomizedRandomDelay.animationType)
}
