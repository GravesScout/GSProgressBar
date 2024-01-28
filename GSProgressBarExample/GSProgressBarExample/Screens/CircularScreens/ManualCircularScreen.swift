//
//  ManualCircularScreen.swift
//  GSProgressBarExample
//
//  Created by Dor Ditchi on 21/01/2024.
//

import SwiftUI
import GSProgressBar

struct ManualProgressScreen: View {
    @State private var barProgress: CGFloat = 0.0
    @State private var circularProgress: CGFloat = 0.0
    @State private var customProgress: CGFloat = 0.0
    
    private let lineWidth: CGFloat = 16.0
    private let customLineWidth: CGFloat = 6.0
    var body: some View {
        VStack(spacing: 30) {
            VStack(spacing: 10, content: {
                GSManualProgressBar(type: .bar,
                                    trackLineWidth: lineWidth,
                                    fillLineWidth: lineWidth - 2,
                                    showShadow: true,
                                    progress: $barProgress)
                .frame(width: 150)
                
                    Text("\(barProgress)")
                    
                    Slider(value: $barProgress, in: 0...1) {
                        EmptyView()
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("1")
                    }.padding(.horizontal, 40)
            })
            
            VStack(spacing: 10, content: {
                ZStack {
                    GSManualProgressBar(type: .circular,
                                        trackLineWidth: lineWidth,
                                        fillLineWidth: lineWidth - 2,
                                        showShadow: true, 
                                        progress: $circularProgress)
                    Text("\(circularProgress)")
                }.frame(width: 120, height: 120)
                    
                    Slider(value: $circularProgress, in: 0...1) {
                        EmptyView()
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("1")
                    }.padding(.horizontal, 40)
            })
                
            VStack(spacing: 10, content: {
                GSManualProgressBar(type: .customPath(path: .swiftLogo),
                                    trackLineWidth: customLineWidth,
                                    fillLineWidth: customLineWidth - 2,
                                    showShadow: true, 
                                    progress: $customProgress)
                .frame(width: 120, height: 120)
                
                    Text("\(customProgress)")
                    
                    Slider(value: $customProgress, in: 0...1) {
                        EmptyView()
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("1")
                    }.padding(.horizontal, 40)
            })
               
        }
    }
}

#Preview("Manual Progress") {
    ManualProgressScreen()
}

