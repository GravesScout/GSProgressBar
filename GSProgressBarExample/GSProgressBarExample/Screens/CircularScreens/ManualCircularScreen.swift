//
//  ManualCircularScreen.swift
//  GSProgressBarExample
//
//  Created by Dor Ditchi on 21/01/2024.
//

import SwiftUI
import GSProgressBar

struct ManualProgressScreen: View {
    @State private var progress: CGFloat = 0.0
    var progressType: GSProgressBarType
    var lineWidth: CGFloat {
        if case .customPath(_) = progressType {
            return 6
        } else {
            return 16
        }
    }
    var body: some View {
        VStack(spacing: 40) {
            switch progressType {
            case .linear:
                GSManualProgressBar(type: progressType,
                                    trackLineWidth: lineWidth,
                                    fillLineWidth: lineWidth - 2,
                                    progress: $progress)
                .frame(width: 150)
            case .circular:
                ZStack {
                    GSManualProgressBar(type: progressType,
                                        trackLineWidth: lineWidth,
                                        fillLineWidth: lineWidth - 2,
                                        progress: $progress)
                    .frame(width: 150, height: 150)
                    Text("\(progress)")
                }
            case .customPath:
                GSManualProgressBar(type: progressType,
                                    trackLineWidth: lineWidth,
                                    fillLineWidth: lineWidth - 2,
                                    progress: $progress)
                .frame(width: 150)
            }
            
            VStack(spacing: 10) {
                Text("\(progress)")
                
                Slider(value: $progress, in: 0...1) {
                    EmptyView()
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("1")
                }
            }.padding(.horizontal, 40)
        }
    }
}

#Preview("Linear Progress") {
    ManualProgressScreen(progressType: .linear)
}

#Preview("Circular Progress") {
    ManualProgressScreen(progressType: .circular)
}

#Preview("Custom Progress") {
    ManualProgressScreen(progressType: .customPath(path: .swiftLogo))
}
