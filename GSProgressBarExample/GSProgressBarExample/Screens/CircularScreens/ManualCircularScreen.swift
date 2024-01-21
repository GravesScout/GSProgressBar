//
//  ManualCircularScreen.swift
//  GSProgressBarExample
//
//  Created by Dor Ditchi on 21/01/2024.
//

import SwiftUI
import GSProgressBar

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
                    EmptyView()
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("1")
                }
            }
        }
    }
}

#Preview {
    ManualCircularScreen()
}
