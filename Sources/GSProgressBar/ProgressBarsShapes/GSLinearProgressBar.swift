//
//  GSLinearProgressBar.swift
//
//
//  Created by Graves Scout on 21/01/2024.
//

import SwiftUI

struct GSLinearProgressBar: View {
    @State private var maxWidth: CGFloat = 0
    @Binding var progress: CGFloat
    let trackLineWidth: CGFloat
    let fillLineWidth: CGFloat
    let cornerRadius: CGFloat
    var trackColor: Color 
    var progressColor: Color 
    var shadowColor: Color 
    let showShadow: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: cornerRadius)
                .frame(height: trackLineWidth)
                .foregroundColor(trackColor)
                .shadow(color:showShadow ? shadowColor : .clear, radius: showShadow ? 5 : 0)
            RoundedRectangle(cornerRadius: cornerRadius)
                .frame(width:(maxWidth * progress), height: fillLineWidth)
                .foregroundColor(progressColor)
                .padding(.horizontal, (trackLineWidth-fillLineWidth)/2)
        }
        .background(
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        maxWidth = proxy.size.width
                    }
            }
        )
    }
}

#Preview {
    GSLinearProgressBar(progress: .constant(0.4), trackLineWidth: 16, fillLineWidth: 14, cornerRadius: 16, trackColor: .gray, progressColor: .blue, shadowColor: .blue, showShadow: true)
        .frame(width: 200)
}
