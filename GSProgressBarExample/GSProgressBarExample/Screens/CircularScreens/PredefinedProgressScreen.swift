//
//  PredefinedProgressScreen..swift
//  GSProgressBarExample
//
//  Created by Graves Scout on 21/01/2024.
//

import SwiftUI
import GSProgressBar

struct PredefinedProgressScreen: View {
    private let lineWidth: CGFloat = 16.0
    private let customLineWidth: CGFloat = 6.0
    @State var barProgress: CGFloat = 0.0
    @State var circularProgress: CGFloat = 0.0
    @State var customProgress: CGFloat = 0.0
    @State var play: Bool = true
    var animationType: GSAnimationType
    
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 10, content: {
                Text("\(barProgress)")
                GSPredefinedProgressBar(type: .bar,
                              animationType: animationType,
                              trackLineWidth: lineWidth,
                              fillLineWidth: lineWidth - 2,
                              showShadow: true, 
                              play: $play) { updatedProgress in
                    barProgress = updatedProgress
                }.frame(width: 150)
            })
            
            ZStack {
                GSPredefinedProgressBar(type: .circular,
                              animationType: animationType,
                              trackLineWidth: lineWidth,
                              fillLineWidth: lineWidth - 2,
                              showShadow: true, 
                              play: $play) { updatedProgress in
                    circularProgress = updatedProgress
                }.frame(width: 150, height: 150)
                Text("\(circularProgress)")
            }
            
            VStack(spacing: 10, content: {
                Text("\(customProgress)")
                GSPredefinedProgressBar(type: .customPath(path: .swiftLogo),
                              animationType: animationType,
                              trackLineWidth: customLineWidth,
                              fillLineWidth: customLineWidth - 2,
                              showShadow: true, 
                              play: $play) { updatedProgress in
                    customProgress = updatedProgress
                }.frame(width: 150, height: 150)
            })
            
           
            
            Button(play ? "Pause" : "Play") {
                play.toggle()
            }
        }
    }
}

#Preview("Linear Progress") {
    PredefinedProgressScreen(animationType: ProgressScreens.linear.animationType)
}
#Preview("Sections Progress") {
    PredefinedProgressScreen(animationType: ProgressScreens.sectioned.animationType)
}
#Preview("Randomized No Delay Progress") {
    PredefinedProgressScreen(animationType: ProgressScreens.randomizedNoDelay.animationType)
}
#Preview("Randomized Constant Delay Progress") {
    PredefinedProgressScreen(animationType: ProgressScreens.randomizedConstantDelay.animationType)
}
#Preview("Randomized + Randomized Delay Progress") {
    PredefinedProgressScreen(animationType: ProgressScreens.randomizedRandomDelay.animationType)
}
