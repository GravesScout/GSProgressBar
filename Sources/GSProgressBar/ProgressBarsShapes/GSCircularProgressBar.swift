//
//  SwiftUIView.swift
//  
//
//  Created by Dor Ditchi on 27/12/2023.
//

import SwiftUI
import Combine

struct GSCircularProgressBar: View {
    @Binding var progress: CGFloat
    let trackLineWidth: CGFloat
    let fillLineWidth: CGFloat
    var trackColor: Color
    var progressColor: Color
    var shadowColor: Color
    let showShadow: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.gray, lineWidth: trackLineWidth)
                .padding(trackLineWidth/2)
                .shadow(color:showShadow ? shadowColor : .clear, radius: showShadow ? 5 : 0)
            Circle()
                .trim(from: 0, to: progress)
                .rotation(.degrees(-90))
                .stroke(progressColor, style: StrokeStyle(lineWidth: fillLineWidth, lineCap: .round))
                .padding(trackLineWidth/2)
        }
    }
}

#Preview {
    GSCircularProgressBar(progress: .constant(0.40), trackLineWidth: 16, fillLineWidth: 14, trackColor: .gray, progressColor: .blue, shadowColor: .blue, showShadow: true)
}
