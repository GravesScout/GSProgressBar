//
//  GSLinearProgressBar.swift
//
//
//  Created by Dor Ditchi on 21/01/2024.
//

import SwiftUI

struct GSLinearProgressBar: View {
    @State private var maxWidth: CGFloat = 0
    @Binding var progress: CGFloat
    let trackLineWidth: CGFloat
    let fillLineWidth: CGFloat
    let cornerRadius: CGFloat
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(height: trackLineWidth)
                    .foregroundColor(.gray)
                    .shadow(color:.blue, radius: 5)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width:(maxWidth * progress), height: fillLineWidth)
                    .foregroundColor(.blue)
                    .padding(.horizontal, (trackLineWidth-fillLineWidth)/2)
            }
            .onAppear {
                maxWidth = proxy.size.width
            }
        }
    }
}

#Preview {
    GSLinearProgressBar(progress: .constant(0.4), trackLineWidth: 16, fillLineWidth: 14, cornerRadius: 16)
        .frame(width: 200)
}
